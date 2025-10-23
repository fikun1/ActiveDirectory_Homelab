# ===================================================================
# Script: create_organizational_units.ps1
# Purpose: Create Organizational Units (OUs) for Active Directory
# Author: David Oladejo Oluwafikunayomi
# Domain: adlab.local
# ===================================================================

# Import Active Directory module
Import-Module ActiveDirectory


# Define OU list
$ouList = @("Users", "Groups", "Computers", "TestUsers", "IT", "HR", "Finance", "Engineering", "Marketing", "Security")

# Create OUs
foreach ($ou in $ouList) {
    if (-not (Get-ADOrganizationalUnit -Filter "Name -eq '$ou'" -ErrorAction SilentlyContinue)) {
        New-ADOrganizationalUnit -Name $ou -Path "DC=adlab,DC=local"
        Write-Host "✅ Created OU: $ou" -ForegroundColor Green
    } else {
        Write-Host "⚠️ OU already exists: $ou" -ForegroundColor Yellow
    }
}
