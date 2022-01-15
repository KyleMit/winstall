function Test-Command
{
    [OutputType([bool])]
    Param (
      [Parameter(Mandatory,ValueFromPipeline)]
      [string]$cmdName
    )

    return [bool](Get-Command -Name $cmdName -ErrorAction SilentlyContinue)
}
