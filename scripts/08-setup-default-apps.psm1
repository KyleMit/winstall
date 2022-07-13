$regKeyFileRoot = "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\FileExts"
$regKeyFileItem = "$regKeyFileRoot\{0}\UserChoice"

$regKeyUrlRoot = "HKCU:\Software\Microsoft\Windows\Shell\Associations\UrlAssociations"
$regKeyUrlItem = "$regKeyUrlRoot\{0}\UserChoice"

$regKeyHtm  = $regKeyFileItem -f '.htm'
$regKeyHtml = $regKeyFileItem -f '.html'


$regKeyHttp  = $regKeyUrlItem -f 'http'
$regKeyHttps = $regKeyUrlItem -f 'https'



function Get-FileTypeAssociations {
    $items = Get-ChildItem "$regKeyFileRoot\*" | ForEach-Object {
        return Get-FileTypeAssociation $_.PSChildName
    }
    return $items
}

# .EXAMPLE
#   Get-FileTypeAssociation .html
function Get-FileTypeAssociation($extension) {
    $item = Get-ItemProperty ($regKeyFileItem -f $extension) -ErrorAction SilentlyContinue
    return [PSCustomObject]@{
        Extension = $extension
        ProgId = $item.ProgId
    }
}

Get-FileTypeAssociations

Get-FileTypeAssociation .html

Set-ItemProperty $regKeyHttp  -name ProgId ChromeHTML
Set-ItemProperty $regKeyHttps -name ProgId ChromeHTML
Set-ItemProperty $regKeyHtm  -name ProgId ChromeHTML
Set-ItemProperty $regKeyHtml -name ProgId ChromeHTML

Get-ItemProperty $regKeyHttp
Get-ItemProperty $regKeyHttps
Get-ItemProperty $regKeyHtm
Get-ItemProperty $regKeyHtml

function Test-ConfigurePowerPlan {


}


function Invoke-ConfigurePowerPlan {

    $tempAssocations ="C:\TempCustomAssociations.xml"

    # export file associations to temp file
    Dism /Online /Export-DefaultAppAssociations:$tempAssocations

    # load file
    [xml]$tempXmlDoc = Get-Content $tempAssocations

    # replace associations for relvant rows
    $tempXmlDoc.DefaultAssociations.Association |
        Where-Object { $_.Identifier -in ".htm", ".html", "http", "https" } |
        ForEach-Object {
            $_.ProgId = "ChromeHTML"
            $_.ApplicationName = "Google Chrome"
        }

    # save updates back to temp file
    $tempXmlDoc.Save($tempAssocations)

    # import associations from temp file
    Dism /Online /Import-DefaultAppAssociations:$tempAssocations

    # cleanup - remove temp file
    Remove-Item $tempAssocations
}


$defaultAssociationsPath = "C:\Windows\System32\OEMDefaultAssociations.xml"
[xml]$defaultAssociationsDoc = Get-Content $defaultAssociationsPath

# replace associations for relvant rows
$defaultAssociationsDoc.DefaultAssociations.Association |
    Where-Object { $_.Identifier -in ".htm", ".html", "http", "https" } |
    ForEach-Object {
        $_.ProgId = "MSEdgeHTM"
        $_.ApplicationName = "Microsoft Edge"
    }

# save updates back to temp file
$defaultAssociationsDoc.Save($defaultAssociationsPath)
