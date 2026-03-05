# Autoriser temporairement les scripts
Set-ExecutionPolicy -ExecutionPolicy Unrestricted -Scope CurrentUser

# Afficher les outils RSAT disponibles
Get-WindowsCapability -Name "RSAT*" -Online | Select-Object DisplayName, State

Read-Host "Appuyez sur ENTREE pour continuer..."

# Installation RSAT
Add-WindowsCapability -Online -Name "Rsat.ActiveDirectory.DS-LDS.Tools~~~~0.0.1.0"
Add-WindowsCapability -Online -Name "Rsat.GroupPolicy.Management.Tools~~~~0.0.1.0"
Add-WindowsCapability -Online -Name "Rsat.Dns.Tools~~~~0.0.1.0"

# Création des raccourcis
$WshShell = New-Object -ComObject WScript.Shell

# AD Users and Computers
$Shortcut = $WshShell.CreateShortcut("$env:USERPROFILE\Desktop\Utilisateurs et ordinateurs Active Directory.lnk")
$Shortcut.TargetPath = "dsa.msc"
$Shortcut.Save()

# GPO Management
$Shortcut = $WshShell.CreateShortcut("$env:USERPROFILE\Desktop\Gestion de la stratégie de groupe.lnk")
$Shortcut.TargetPath = "gpmc.msc"
$Shortcut.Save()

# DNS
$Shortcut = $WshShell.CreateShortcut("$env:USERPROFILE\Desktop\DNS.lnk")
$Shortcut.TargetPath = "dnsmgmt.msc"
$Shortcut.Save()

# Réactiver une politique normale
Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser