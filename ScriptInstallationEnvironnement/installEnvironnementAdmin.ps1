
# Modification de la politique de vérification des scripts pour permettre l'execution de ce script pour cette utilisateur
Set-ExecutionPolicy -ExecutionPolicy Unrestricted -Scope CurrentUser


Get-WindowsCapability -Name "RSAT*" -Online | Select-Object -Property DisplayName, State

Read-Host "Appuyez sur ENTREE pour continuer..."

# Installation de l'outil de gestion des utilisateurs de l'AD
Add-WindowsCapability -Online -Name "Rsat.ActiveDirectory.DS-LDS.Tools~~~~0.0.1.0"
# Installation de l'outil de gestion des stratégies de groupes (GPO)
Add-WindowsCapability -Online -Name "Rsat.GroupPolicy.Management.Tools~~~~0.0.1.0"
# Installation de l'outil de gestion du DNS
Add-WindowsCapability -Online -Name "Rsat.Dns.Tools~~~~0.0.1.0"




# Création des raccourcis
$WshShell = New-Object -ComObject WScript.Shell

# Utilisateurs et ordinateurs Active Directory
$Shortcut = $WshShell.CreateShortcut("C:\Users\$env:USERNAME\Desktop\Utilisateurs et ordinateurs Active Directory.lnk")
$Shortcut.TargetPath = "dsa.msc"
$Shortcut.Save()

# Gestion de la stratégie de groupe
$Shortcut = $WshShell.CreateShortcut("C:\Users\$env:USERNAME\Desktop\Gestion de la stratégie de groupe.lnk")
$Shortcut.TargetPath = "gpmc.msc"
$Shortcut.Save()

# DNS
$Shortcut = $WshShell.CreateShortcut("C:\Users\$env:USERNAME\Desktop\DNS.lnk")
$Shortcut.TargetPath = "dnsmgmt.msc"
$Shortcut.Save()

# Centre d’administration AD
$Shortcut = $WshShell.CreateShortcut("C:\Users\$env:USERNAME\Desktop\Centre d’administration AD.lnk")
$Shortcut.TargetPath = "dsac.exe"
$Shortcut.Save()

curl "https://cdn.sanity.io/files/r09655ln/production/0248c3996024ac04a0482b051ce3905b76864528.zip" 

# Modification de la politique de vérification des scripts pour reprotéger l'utilsateur
Set-ExecutionPolicy -ExecutionPolicy AllSigned Unrestricted -Scope CurrentUser