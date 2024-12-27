#!/bin/bash

#Script usage
#  sh script.sh 2 $GUID

# Check if a parameter is passed
if [ -z "$1" ]; then
    echo "Usage: $0 <value>"
    exit 1
fi

if [ -z "$2" ]; then
    echo "Usage: $0 <value>"
    exit 1
fi

# Assign the parameter to a variable
PARAM_VALUE=$1
GUID=$2

#    tenant_id: "{{ tenand_id }}"
#    master_client_id: "{{ master_client_id }}"
#    master_client_secret: "{{ master_client_secret }}"
#    child_app_display_name: "RHDP-lightspeed-{{ GUID }}-5"
#    group_id: "{{ group_id }}"
#    azure_region: "{{ azure_region }}"  # e.g., westus, eastus
    
# Use the parameter in the display name
CHILD_APP_DISPLAY_NAME="RHDP-lightspeed-$GUID-$PARAM_VALUE"

TENANT_ID="{{ tenand_id }}"
CLIENT_ID="{{ master_client_id }}"
CLIENT_SECRET="{{ master_client_secret }}"

az login --service-principal --username "$CLIENT_ID" --password "$CLIENT_SECRET" --tenant "$TENANT_ID"

echo $CHILD_APP_DISPLAY_NAME

# Get app IDs and store them in app_ids.txt
az ad app list --display-name "$CHILD_APP_DISPLAY_NAME" | grep -i appid | cut -d'"' -f4 > app_ids.txt

# Loop through each appId and delete it
while read -r app_id; do
  echo "Deleting app with ID: $app_id"
  az ad app delete --id "$app_id"
  sleep 5  # Delay 5 seconds before next deletion
done < app_ids.txt
