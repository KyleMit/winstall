# Window Management


## Acronyms

* **CIM** - Common Information Model
* **DMTF** - Distributed Management Task Force
* **WMI** - Windows Management Instrumentation
* **MI** - Management Infrastructure
* **WS-Man** - WS-Management
* **WinRM** - Windows Remote Management
* **PIC** - Powershell Integrated Console
* **WBEM** - Web-Based Enterprise Management
* **MOF** - Managed Object Format


## CMI

* [Introduction to CIM Cmdlets](https://devblogs.microsoft.com/powershell/introduction-to-cim-cmdlets/)
* [Get-CimInstance](https://docs.microsoft.com/en-us/powershell/module/cimcmdlets/get-ciminstance?view=powershell-7.2)

## WMI

* [Windows Management Instrumentation](https://docs.microsoft.com/en-us/windows/win32/wmisdk/wmi-start-page)
* [About WMI](https://docs.microsoft.com/en-us/windows/win32/wmisdk/about-wmi)
* [Using WMI](https://docs.microsoft.com/en-us/windows/win32/wmisdk/using-wmi)
* [Accessing Data in the Interop Namespace](https://docs.microsoft.com/en-us/windows/win32/wmisdk/accessing-data-in-the-interop-namespace#assigning-the-power-profile-to-a-variable)

### MI

[Why Use MI](https://docs.microsoft.com/en-us/previous-versions/windows/desktop/wmi_v2/why-use-mi-)


### Win32 Provider

* [CIM WMI Provider](https://docs.microsoft.com/en-us/windows/win32/cimwin32prov/cim-wmi-provider)
* [Win32 Provider](https://docs.microsoft.com/en-us/windows/win32/cimwin32prov/win32-provider)
  * [Computer System Hardware Classes](https://docs.microsoft.com/en-us/windows/win32/cimwin32prov/computer-system-hardware-classes)
    * Cooling Device Classes
    * Input Device Classes
    * Mass Storage Classes
    * Motherboard, Controller, and Port Classes
    * Networking Device Classes
    * Power Classes
    * Printing Classes
    * Telephony Classes
    * Video and Monitor Classes
  * [Operating System Classes](https://docs.microsoft.com/en-us/windows/win32/cimwin32prov/operating-system-classes)
    * COM
    * Desktop
    * Drivers
    * Event log
    * File system
    * Job objects
    * Memory and page files
    * Multimedia audio or visual
    * Networking
    * Operating system events
    * Operating system settings
    * Processes
    * Registry
    * Scheduler jobs
    * Security
    * Services
    * Shares
    * Start menu
    * Storage
    * Users
    * Windows product activation


## Questions

* Get Current Power Plan

  ```ps1
  Get-CimInstance -Namespace "root\cimv2\power" -Query "SELECT * FROM Win32_PowerPlan WHERE IsActive = True"
  Get-CimInstance -Namespace "root\cimv2\power" -Class Win32_PowerPlan | Where-Object { $_.IsActive }
  Get-CimInstance -Namespace "root\cimv2\power" -Class Win32_PowerPlan -Filter "IsActive = TRUE"
  ```

* Get Associated Objects

  [Get-CimAssociatedInstance](https://docs.microsoft.com/en-us/powershell/module/cimcmdlets/get-cimassociatedinstance?view=powershell-7.2)

  ```ps1
  $powerNamespace = @{ Namespace = 'root\cimv2\power' }

  $curPlan = Get-CimInstance @powerNamespace -Class Win32_PowerPlan -Filter "IsActive = TRUE"
  $planGuid = Get-ExtractInnerGuid $curPlan.InstanceID

  # Opt 1
  $curPlan | Get-CimAssociatedInstance -ResultClass Win32_PowerSettingDataIndex
  # Opt 2
  Get-CimInstance @powerNamespace -Class Win32_PowerSettingDataIndex -Filter "InstanceId LIKE '%$planGuid%'"
  ```


* Change Default Lid Close Action

  * Tutorials
    * [PowerShell/WMI power management](https://stackoverflow.com/q/35325862/1366033)
    * [Powershell Set Lid Close Action](https://stackoverflow.com/q/15455864/1366033)
    * [Created a script to toggle lid close action](https://stackoverflow.com/q/23944639/1366033)
    * [Change what closing the lid does, from the command line?](https://superuser.com/q/874849/180163)
    * [How to Change Default Lid Close Action on Windows 10](https://winaero.com/how-to-change-default-lid-close-action-on-windows-10/)
    * [How to Change Default Lid Close Action in Windows 10](https://www.tenforums.com/tutorials/69762-how-change-default-lid-close-action-windows-10-a.html)

  * Docs
    * [Configure power settings](https://docs.microsoft.com/en-us/windows-hardware/customize/power-settings/configure-power-settings)
    * [Power button and lid settings overview](https://docs.microsoft.com/en-us/windows-hardware/customize/power-settings/power-button-and-lid-settings)
    * [Lid switch close action](https://docs.microsoft.com/en-us/windows-hardware/customize/power-settings/power-button-and-lid-settings-lid-switch-close-action)

  * [Power Policy Provider](https://docs.microsoft.com/en-us/previous-versions/windows/desktop/powerwmiprov/power-policy-provider-)
    * [Win32\_PowerPlan class](https://docs.microsoft.com/en-us/previous-versions/windows/desktop/powerwmiprov/win32-powerplan)
    * [Win32\_PowerSetting class](https://docs.microsoft.com/en-us/previous-versions/windows/desktop/powerwmiprov/win32-powersetting)

  * [Powercfg command-line options](https://docs.microsoft.com/en-us/windows-hardware/design/device-experiences/powercfg-command-line-options)
    * [Lid switch close action](https://docs.microsoft.com/en-us/windows-hardware/customize/power-settings/power-button-and-lid-settings-lid-switch-close-action)
