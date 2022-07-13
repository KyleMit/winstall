$regKeyFileRoot = "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\FileExts"
$regKeyFileItem = "$regKeyFileRoot\{0}\UserChoice"

$regKeyUrlRoot = "HKCU:\Software\Microsoft\Windows\Shell\Associations\UrlAssociations"
$regKeyUrlItem = "$regKeyUrlRoot\{0}\UserChoice"


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

function Get-ProtocolAssociations {
    $items = Get-ChildItem "$regKeyUrlRoot\*" | ForEach-Object {
        return Get-ProtocolAssociation $_.PSChildName
    }
    return $items
}

# .EXAMPLE
#   Get-ProtocolAssociation http
function Get-ProtocolAssociation($protocol) {
    $item = Get-ItemProperty ($regKeyUrlItem -f $protocol) -ErrorAction SilentlyContinue
    return [PSCustomObject]@{
        Protocol = $protocol
        ProgId = $item.ProgId
    }
}
