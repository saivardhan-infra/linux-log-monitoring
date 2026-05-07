#!/bin/bash

# ==========================================
# Linux Log Monitoring Automation Script
# Author: Sai Vardhan
# ==========================================

# Log file to monitor
LOG_FILE="/var/log/syslog"

# Alert output file
ALERT_FILE="$HOME/log_alerts.txt"

# Keywords to detect
KEYWORDS=("error" "failed" "critical" "warning")

# Current timestamp
DATE=$(date "+%Y-%m-%d %H:%M:%S")

echo "===============================" >> $ALERT_FILE
echo "Log Scan Time: $DATE" >> $ALERT_FILE
echo "===============================" >> $ALERT_FILE

# Scan log file for keywords
for WORD in "${KEYWORDS[@]}"
do
    echo "Checking for: $WORD" >> $ALERT_FILE
    
    grep -i "$WORD" $LOG_FILE | tail -5 >> $ALERT_FILE
    
    echo "" >> $ALERT_FILE
done

echo "Log monitoring completed."

# Optional terminal alert
COUNT=$(grep -iE "error|failed|critical" $LOG_FILE | wc -l)

if [ $COUNT -gt 10 ]; then
    echo "ALERT: High number of critical logs detected!"
fi
