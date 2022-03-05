
$regKeyUrl = "HKCU:\Software\Microsoft\Windows\Shell\Associations\UrlAssociations\{0}\UserChoice"
$regKeyHttp  = $regKeyUrl -f 'http'
$regKeyHttps = $regKeyUrl -f 'https'

$regKeyFile = "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\FileExts\{0}\UserChoice"
$regKeyHtm  = $regKeyFile -f '.htm'
$regKeyHtml = $regKeyFile -f '.html'


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
