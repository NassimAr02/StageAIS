# -----------------------------------------------
# Script RSAT : réinstallation et création raccourcis
# -----------------------------------------------

# Autoriser temporairement les scripts
Set-ExecutionPolicy -ExecutionPolicy Unrestricted -Scope CurrentUser -Force

# Définir les outils RSAT nécessaires
$rsatTools = @(
    "Rsat.ActiveDirectory.DS-LDS.Tools~~~~0.0.1.0",
    "Rsat.GroupPolicy.Management.Tools~~~~0.0.1.0",
    "Rsat.Dns.Tools~~~~0.0.1.0"
)

# Supprimer les outils existants
Write-Host "Suppression des outils RSAT existants..."
foreach ($tool in $rsatTools) {
    $state = (Get-WindowsCapability -Name $tool -Online).State
    if ($state -eq "Installed") {
        Write-Host "Désinstallation de $tool..."
        Remove-WindowsCapability -Online -Name $tool
    }
}

# Installer les outils RSAT
Write-Host "Installation des outils RSAT..."
foreach ($tool in $rsatTools) {
    $state = (Get-WindowsCapability -Name $tool -Online).State
    if ($state -ne "Installed") {
        Write-Host "Installation de $tool..."
        Add-WindowsCapability -Online -Name $tool
    }
}

# Création des raccourcis sur le bureau
Write-Host "Création des raccourcis sur le bureau..."
$WshShell = New-Object -ComObject WScript.Shell

$shortcuts = @(
    @{Name="Utilisateurs et ordinateurs Active Directory.lnk"; Target="dsa.msc"; Tool="Rsat.ActiveDirectory.DS-LDS.Tools~~~~0.0.1.0"},
    @{Name="Gestion de la stratégie de groupe.lnk"; Target="gpmc.msc"; Tool="Rsat.GroupPolicy.Management.Tools~~~~0.0.1.0"},
    @{Name="DNS.lnk"; Target="dnsmgmt.msc"; Tool="Rsat.Dns.Tools~~~~0.0.1.0"}
)

foreach ($s in $shortcuts) {
    $toolState = (Get-WindowsCapability -Name $s.Tool -Online).State
    if ($toolState -eq "Installed") {
        $Shortcut = $WshShell.CreateShortcut("$env:USERPROFILE\Desktop\$($s.Name)")
        $Shortcut.TargetPath = $s.Target
        $Shortcut.Save()
        Write-Host "Raccourci $($s.Name) créé."
    }
    else {
        Write-Host "L'outil pour $($s.Name) n'est pas installé. Raccourci non créé."
    }
}

# Réactiver une politique d'exécution normale
Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser -Force

Write-Host "Script terminé ! Les outils RSAT sont installés et les raccourcis créés."