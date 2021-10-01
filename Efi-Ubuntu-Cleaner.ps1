#
# Copyright (C) 2021 Simone 'DarkJoker360' Esposito
# SPDX-License-Identifier: GPL-3.0-only
#

#
# Simple script to remove ubuntu EFI leftovers after
# removing it from dual boot.
#

function isAdmin() {
    $id = [System.Security.Principal.WindowsIdentity]::GetCurrent()
    $principal = New-Object System.Security.Principal.WindowsPrincipal($id)
    if ($principal.IsInRole([System.Security.Principal.WindowsBuiltInRole]::Administrator)){
        return 1;
    }
    else {
        return 0;
    }
}

Write-Output "EFI Cleanup script"

if(-Not (isAdmin)) { 
    Write-Error "You must have admin rights to run this script !" -Category 'PermissionDenied'
    Return
}

mountvol S: /s
Write-Output "Removing Ubuntu lefotevers..."
Remove-Item -Recurse S:\EFI\ubuntu
Write-Output "Done."

Do {

    $in = Read-Host 'Restart is needed, would you like to reboot now? (y/n)'
    if(($in -ne 'y') -Or ($in -ne 'n')) {
        Write-Warning 'Invalid option...'
    }

} Until(($in -eq 'y') -Or ($in -eq 'n'))

if($in -eq 'y') { Restart-Computer }
