param (
    # Name of the resource
    [ValidateNotNullOrEmpty()]
    $SName,
    # Name of the resource group
    [Parameter()]
    [string]
    $ResourceGroupName
)

# Accepts an empty ResourceGroup and will query all resources by Type,
# If ResourceGroup is provided we can query by ResourceGroupName
if (!$ResourceGroup) {
    $ResourceType = "Microsoft.Storage/storageAccounts"
    $resource = Get-AzResource -Name $ResourceGroupName -ResourceType $ResourceType

    # As we have a native command to get the actual resource we will query for the Storage Accounts
    # The object returned will have all configured properties
    $storage = Get-AzStorageAccount -Name $resource.Name -ResourceGroupName $resource.ResourceGroupName
}
else {
    $resource = Get-AzResource -Name $Name -ResourceGroupName $ResourceGroupName
    $storage = Get-AzStorageAccount -Name $resource.Name -ResourceGroupName $resource.ResourceGroupName
}

Describe "Storage Account" {

    <# Mandatory requirement of ADLS Gen 2 are:
     - Resource Type is Microsoft.Storage/storageAccounts, as we know we are looking for this it is obsolete to check
     - Kind is StorageV2
     - Hierarchical namespace is enabled
     https://docs.microsoft.com/en-us/azure/storage/blobs/data-lake-storage-quickstart-create-account?toc=%2fazure%2fstorage%2fblobs%2ftoc.json
    #>
    it "should have tags" {
        $storage.Tags.count -ge 1 | should -be $true
    }

}
