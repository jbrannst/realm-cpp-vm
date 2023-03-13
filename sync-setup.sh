source config.sh
realm-cli login --api-key $PUBKEY --private-api-key $PRIVKEY
# pull your setup
#realm-cli pull --remote $APP_ID 

# push preconfigured sync app
cd realm/sync
realm-cli push -y --project=$GROUPID

# set APP_ID in config.sh
output=$(realm-cli app describe)
app_id=$(echo $output | sed 's/^.*client_app_id": "\([^"]*\).*/\1/')
echo "set APP_ID=$app_id in config.sh"