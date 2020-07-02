<#
  .SYNOPSIS
  Lists the OneDrive URLs in your O365 Tenant and export to an Excel Spreadsheet.
  .DESCRIPTION
  Lists the OneDrive URLs in your O365 Tenant and export to a nice formatted Excel Spreadsheet.
  .PARAMETER
  -AdminUrl The SPO Admin URL of your tenant.
  .EXAMPLE
  Get-AllUsersOneDrives.ps1 -UPN https://yourtenant-admin.sharepoint.com 
  .INPUTS
  None
  .OUTPUTS
  AllOneDrives.xlsx
  .NOTES
  Author:        Patrick Horne
  Creation Date: 02/07/20
  Requires:      ImportExcel and SharePoint Online Modules
  Change Log:
  V1.0:         Initial Development
#>

#Requires -Modules ImportExcel, Microsoft.Online.SharePoint.PowerShell

param (
    [Parameter(Mandatory)]
    [String]$TenantUrl
)

# $TenantUrl = Read-Host "Enter the SharePoint admin center URL"
# $LogFile = [Environment]::GetFolderPath("Desktop") + "\OneDriveSites.log"
Connect-SPOService -Url $TenantUrl
$OneDriveUrls = Get-SPOSite -IncludePersonalSite $true -Limit all -Filter "Url -like '-my.sharepoint.com/personal/'" | Select-Object -ExpandProperty Url

$ExportExcelSplat = @{
    Path            = "OneDriveUrls.xlsx"
    AutoSize        = $true
    WorkSheetname   = "OneDriveUrls"
    TableName       = "OneDriveUrls"
    TableStyle      = "Medium6"

}

$OneDriveUrls | Export-Excel @exportExcelSplat

Write-Host "Complete. File saved as "$ExportExcelSplat.path" "