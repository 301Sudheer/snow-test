#!/bin/bash

# Set the date
DATE=$(date +"%Y-%m-%d")

# Set the output file
OUTPUT_FILE="aws_daily_report_$DATE.txt"

# S3 Bucket List
echo "S3 Buckets:" >> "$OUTPUT_FILE"
aws s3 ls >> "$OUTPUT_FILE"
echo "" >> "$OUTPUT_FILE"

# Lambda Functions List
echo "Lambda Functions:" >> "$OUTPUT_FILE"
aws lambda list-functions >> "$OUTPUT_FILE"
echo "" >> "$OUTPUT_FILE"

# EC2 Instances List
echo "EC2 Instances:" >> "$OUTPUT_FILE"
aws ec2 describe-instances >> "$OUTPUT_FILE"
echo "" >> "$OUTPUT_FILE"

# IAM Users List
echo "IAM Users:" >> "$OUTPUT_FILE"
aws iam list-users >> "$OUTPUT_FILE"

# Notify completion
echo "Daily report generated: $OUTPUT_FILE"

# Schedule next execution with cron
CRON_CMD="(crontab -l ; echo '0 8 * * * /path/to/daily_report.sh') | crontab -"
eval $CRON_CMD

