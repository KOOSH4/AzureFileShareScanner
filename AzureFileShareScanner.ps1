<#
.DESCRIPTION
The goal of this script is to list all file shares across all storage accounts in all Azure subscriptions.
This script logs into Azure, gets all subscriptions, and iterates over each one. For each subscription, it selects it and gets all storage accounts in that subscription. For each storage account, it gets the context and then gets all file shares in that storage account. It then iterates over each file share and prints information about it, including the subscription name and ID.

.NOTES
Filename : AzureFileShareScanner.ps1
Author   : KOOSH4
Version  : 1
Date     : 08.02.2024

#>

# Get all subscriptions
$subscriptions = Get-AzSubscription

# Create an empty array to store the output
$outputArray = @()

# Loop through each subscription
foreach ($subscription in $subscriptions) {
    # Select the subscription
    Set-AzContext -Subscription $subscription.Id

    # Get all storage accounts
    $storageAccounts = Get-AzStorageAccount

    # Loop through each storage account
    foreach ($storageAccount in $storageAccounts) {

        # Get the storage account context
        $context = $storageAccount.Context
        # Get all file shares in the storage account
            $fileShares = Get-AzStorageShare -Context $context
            Write-Host " FileShare: $fileShares"
            # Iterate through each file share
            foreach ($fileShare in $fileShares) {

                # Print information about the file share
                write-host "  ### File Share found ### "
                Write-Host "Subscription Name: $($subscription.Name)"
                Write-Host "Subscription ID: $($subscription.Id)"
                Write-Host "Resource Group: $($storageAccount.ResourceGroupName)"
                Write-Host "Storage Account: $($storageAccount.StorageAccountName)"
                Write-Host "File Share: $($fileShare.Name)"
                Write-Host "-----------------------------"
            }
    }
}