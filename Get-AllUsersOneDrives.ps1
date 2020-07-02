<#
  .SYNOPSIS
  Lists the OneDrive URLs in your O365 Tenant and export to a csv file.
  .DESCRIPTION
  Lists the OneDrive URLs in your O365 Tenant and export to a csv file.
  .PARAMETER
  -AdminUrl The SPO Admin URL of your tenant.
  .EXAMPLE
  Get-AllUsersOneDrives.ps1 -UPN https://yourtenant-admin.sharepoint.com 
  .INPUTS
  None
  .OUTPUTS
  AllOneDrives.csv
  .NOTES
  Author:        Patrick Horne
  Creation Date: 02/07/20
  Requires:      SharePoint Online Modules
  Change Log:
  V1.0:         Initial Development
  V1.1:         Removed Exporting to Excel
#>

#Requires -Modules Microsoft.Online.SharePoint.PowerShell

param (
    [Parameter(Mandatory)]
    [String]$TenantUrl
)

$filepath = "AllOneDriveUrls.csv"

Connect-SPOService -Url $TenantUrl
Get-SPOSite -IncludePersonalSite $true -Limit all -Filter "Url -like '-my.sharepoint.com/personal/'" | Select-Object -ExpandProperty Url | Out-File $filepath 

Write-Host "Complete. File saved as $filepath"