#
# Copyright (C) 2021 Simone 'DarkJoker360' Esposito
# SPDX-License-Identifier: GPL-3.0-only
#

#
# Script to backup current user's files
#

$this_user=$env:UserName
$home_path='C:\Users\'+$this_user
$rootdir=$home_path+'\Win-Backup-Tool'
$date_time=Get-Date -Format "MM-dd-yyyy_HH:mm"
$option1=$args[0]

# Edit with your paths (OPTIONAL) 
$paths='Android','Desktop','Documents','Downloads','Giochi','Music','Programmi','Università','Utils'


Write-Output "#" "# Windows Backup Tool" "#"
Write-Output "By DarkJoker360"

function Setup-Paths {
    Write-Output "Setting up working directory..."
    if (-Not (Test-Path $rootdir -e False)) { mkdir $rootdir }   
    if (-Not (Test-Path $rootdir\output -e False)) {
        mkdir $rootdir\output
        mkdir $rootdir\output\full
        mkdir $rootdir\output\partial
    } else {
        if (-Not (Test-Path $rootdir\output\full -e False)) { mkdir $rootdir\output\full }
        if (-Not (Test-Path $rootdir\output\partial -e False)) { mkdir $rootdir\output\partial }      
    }
}

Setup-Paths

foreach ($i in $paths){
    if (Test-Path -Path $home_path\$i\*) {
        Write-Output "Backing up $i folder..."
        Compress-Archive -Path $home_path\$i\* -DestinationPath $rootdir\output\partial\$i-$date_time
    }
}

Write-Output "Processing full backup"
Compress-Archive -Path $output_path\partial\* -DestinationPath $rootdir\output\full\Backup-$date_time

if (($option1 -ne '') -and (($option1 -eq '-ep') -or ($option1 -eq '--exclude-partial'))) {
    Write-Output "Cleaning up partial backups..."
    rm -r $rootdir\output\partial\*
}

Write-Output "Backup completed: $rootdir\output\full\Backup-$date_time"

pause