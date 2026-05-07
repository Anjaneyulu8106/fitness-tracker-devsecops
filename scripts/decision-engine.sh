#!/bin/bash

echo "Checking Trivy vulnerabilities..."

CRITICAL=$(jq '[.Results[].Vulnerabilities[]? | select(.Severity=="CRITICAL")] | length' reports/trivy.json)

HIGH=$(jq '[.Results[].Vulnerabilities[]? | select(.Severity=="HIGH")] | length' reports/trivy.json)

echo "Critical: $CRITICAL"
echo "High: $HIGH"

if [ "$CRITICAL" -gt 0 ] || [ "$HIGH" -gt 5 ]; then
  echo "BLOCK_DEPLOY=true" >> $GITHUB_ENV
else
  echo "BLOCK_DEPLOY=false" >> $GITHUB_ENV
fi