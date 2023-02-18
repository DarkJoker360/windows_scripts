#
# Set of tweaks and automated tasks i run on windows clean install
#

# Set windows updates to manual
$PathToLMPoliciesWindowsUpdate = "HKLM:\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate\AU"		
If (!(Test-Path "$PathToLMPoliciesWindowsUpdate")) {
    New-Item -Path "$PathToLMPoliciesWindowsUpdate" -Force | Out-Null
}
Set-ItemProperty -Path "$PathToLMPoliciesWindowsUpdate" -Name "AUOptions" -Type DWord -Value 2
Set-ItemProperty -Path "$PathToLMPoliciesWindowsUpdate" -Name "NoAutoUpdate" -Type DWord -Value 0
Set-ItemProperty -Path "$PathToLMPoliciesWindowsUpdate" -Name "ScheduledInstallDay" -Type DWord -Value 0
Set-ItemProperty -Path "$PathToLMPoliciesWindowsUpdate" -Name "ScheduledInstallTime" -Type DWord -Value 3
Set-ItemProperty -Path "$PathToLMPoliciesWindowsUpdate" -Name "NoAutoRebootWithLoggedOnUsers" -Type DWord -Value 1
Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\WindowsUpdate\UX\Settings" -Name "UxOption" -Type DWord -Value 1
	
# Disable telemetry (need also to disable DiagTrack service!)
Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\DataCollection" -Name "AllowTelemetry" -Type DWord -Value 0
Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\DataCollection" -Name "AllowDeviceNameInTelemetry" -Type DWord -Value 0
Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\DataCollection" -Name "AllowTelemetry" -Type DWord -Value 0
Set-ItemProperty -Path "HKLM:\SOFTWARE\WOW6432Node\Microsoft\Windows\CurrentVersion\Policies\DataCollection" -Name "AllowTelemetry" -Type DWord -Value 0

# Debloat
Get-AppxPackage -allusers Microsoft.549981C3F5F10 | Remove-AppxPackage # Cortana