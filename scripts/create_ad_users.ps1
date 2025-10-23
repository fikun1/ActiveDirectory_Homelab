# ===================================================================
# Script: create_ad_users.ps1
# Purpose: Bulk create 100 AD users and assign random departments
# Author: David Oladejo Oluwafikunayomi
# Domain: adlab.local
# ===================================================================

# Import Active Directory module
Import-Module ActiveDirectory

# Define departments (match OU names)
$departments = @("IT", "HR", "Finance", "Engineering", "Marketing", "Security")

# OU where users will be placed
$ouPath = "OU=TestUsers,DC=adlab,DC=local"

# Create users
for ($i = 1; $i -le 100; $i++) {

    $num = "{0:D3}" -f $i
    $userName = "User$num"
    $samName = "user$num"
    $dept = Get-Random -InputObject $departments

    # Skip existing users
    if (Get-ADUser -Filter "SamAccountName -eq '$samName'" -ErrorAction SilentlyContinue) {
        Write-Host "⚠️ User already exists: $samName" -ForegroundColor Yellow
        continue
    }

    # Create new user
    New-ADUser `
        -Name $userName `
        -SamAccountName $samName `
        -UserPrincipalName "$samName@adlab.local" `
        -Department $dept `
        -Path $ouPath `
        -AccountPassword (ConvertTo-SecureString "Password@123" -AsPlainText -Force) `
        -Enabled $true `
        -ChangePasswordAtLogon $false

    Write-Host "✅ Created: $userName (Department: $dept)" -ForegroundColor Green
}
