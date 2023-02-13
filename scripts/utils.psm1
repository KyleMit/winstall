using namespace System.Security.Principal

# echo abc | Test-ContainsString b # True
# echo abc | Test-ContainsString d # False
function Test-ContainsString {
  [OutputType([bool])]
  Param (
    [Parameter(Mandatory, ValueFromPipeline)]
    [string]$stringToTest,
    [Parameter(Mandatory, Position = 1)]
    [string]$valueToCompare
  )

  return [bool]($stringToTest | Select-String $valueToCompare).Matches.Success # true
}

function Test-Command {
  [OutputType([bool])]
  Param (
    [Parameter(Mandatory, ValueFromPipeline)]
    [string]$cmdName
  )

  return [bool](Get-Command -Name $cmdName -ErrorAction SilentlyContinue)
}

function Test-Administrator {
  $user = [WindowsIdentity]::GetCurrent();
  $userPrincipal = New-Object WindowsPrincipal $user
  $isAdmin = $userPrincipal.IsInRole([WindowsBuiltinRole]::Administrator)
  return $isAdmin
}


function Get-ExtractInnerGuid {
  [OutputType([string])]
  Param (
    [Parameter(Mandatory, ValueFromPipeline)]
    [string]$stringToTest
  )

  $guidRegex = '[0-9a-f]{8}-?[0-9a-f]{4}-?[0-9a-f]{4}-?[0-9a-f]{4}-?[0-9a-f]{12}'
  $match = [Regex]::Matches($stringToTest, $guidRegex)

  return $(if ($match.Success) { $match.Value } else { "" })
}
