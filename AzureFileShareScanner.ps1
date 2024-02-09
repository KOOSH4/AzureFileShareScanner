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

# Import the required module
Import-Module Az.Accounts
Import-Module Az.Storage

# Login to your Azure account
Connect-AzAccount

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
        # Get all file shares
        $fileShares = Get-AzStorageShare -Context $storageAccount.Context

        # Loop through each file share
        foreach ($fileShare in $fileShares) {
            # Create a custom object
            $outputObject = New-Object PSObject -Property @{
                "Subscription Name" = $subscription.Name
                "Subscription ID" = $subscription.Id
                "Resource Group" = $storageAccount.ResourceGroupName
                "Storage Account" = $storageAccount.StorageAccountName
                "File Share" = $fileShare.Name
            }

            # Write the object to the console
                # Print information about the file share
                write-host "  ### File Share found ### "
                Write-Host "Subscription Name: $($subscription.Name)"
                Write-Host "Subscription ID: $($subscription.Id)"
                Write-Host "Resource Group: $($storageAccount.ResourceGroupName)"
                Write-Host "Storage Account: $($storageAccount.StorageAccountName)"
                Write-Host "File Share: $($fileShare.Name)"
                Write-Host "-----------------------------"

            # Add the object to the output array
            $outputArray += $outputObject
        }
    }
}

# Write the output array to a CSV file
$outputArray | Export-Csv -Path 'AllFileSharesInTenant.csv' -NoTypeInformation