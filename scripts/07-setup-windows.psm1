
$powerNamespace = @{ Namespace = 'root\cimv2\power' }

# https://docs.microsoft.com/en-us/windows-hardware/customize/power-settings/power-button-and-lid-settings-lid-switch-close-action
enum LidAction {
    DoNothing = 0
    Sleep = 1
    Hibernate = 2
    ShutDown = 3
}

enum PowerSupply {
    AC # Plugged In
    DC # On Battery
}

function Get-ActivePowerPlan {
    # get active plan
    $curPlan = Get-CimInstance @powerNamespace -Class Win32_PowerPlan -Filter "IsActive = TRUE"
    return $curPlan
}

function Get-PluggedInLidSetting {
    # get active plan
    $curPlan = Get-ActivePowerPlan
    $planGuid = $curPlan.InstanceID | Get-ExtractInnerGuid

    # get lid close guid
    $lidSetting = Get-CimInstance @powerNamespace -ClassName Win32_Powersetting -Filter "ElementName = 'Lid close action'"
    $lidGuid = $lidSetting.InstanceID | Get-ExtractInnerGuid

    # get plugged in lid setting
    $pluggedInLidSetting = Get-CimInstance @powerNamespace -ClassName Win32_PowerSettingDataIndex -Filter "InstanceID = 'Microsoft:PowerSettingDataIndex\\{$planGuid}\\$([PowerSupply]::AC)\\{$lidGuid}'"
    return $pluggedInLidSetting
}

function Test-ConfigurePowerPlan {
    $pluggedInLidSetting = Get-PluggedInLidSetting

    $alreadySetToDoNothing = $pluggedInLidSetting.SettingIndexValue -eq [int][LidAction]::DoNothing

    return $alreadySetToDoNothing
}


function Invoke-ConfigurePowerPlan {
    $pluggedInLidSetting = Get-PluggedInLidSetting

    # set lid action to do nothing
    $pluggedInLidSetting | Set-CimInstance -Property @{ SettingIndexValue = [int][LidAction]::DoNothing }

    # refresh to activate
    $curPlan | Invoke-CimMethod -MethodName Activate | Out-Null
}

Invoke-ConfigurePowerPlan
