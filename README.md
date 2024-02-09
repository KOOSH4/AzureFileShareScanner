# Azure File Share Scanner
This repository contains a PowerShell script that lists all file shares across all storage accounts in all Azure subscriptions.

Description
The script logs into Azure, gets all subscriptions, and iterates over each one. For each subscription, it selects it and gets all storage accounts in that subscription. For each storage account, it gets the context and then gets all file shares in that storage account. It then iterates over each file share and prints information about it, including the subscription name and ID.

Usage
- Clone this repository.
- Open PowerShell.
- Navigate to the directory containing the script.
- Run the script using the command 


```powershell
    .\AzureFileShareScanner.ps1
```

