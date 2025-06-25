az account set --subscription "$(jq -r .dev.subscriptionId environments.json)"
az deployment group create \
  --resource-group my-rg \
  --template-file main.bicep \
  --parameters environment=dev
