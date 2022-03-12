# Winstaller

Automating something I do at most once every year

## Goals

* Operations should be idempotent - in that you may run the script as many times as you like in setting up or resetting your machine
* Errors should be actionable, but resolved programmatically

## Todo

* set chrome as default browser
* dotfiles
  * spellcheck dictionary
  * Download necessary assets (git repo)
    * Icons
    * Wallpapers
* winget
  * only install new apps
  * winget upgrade
  * download `winget` if not present
* bootstrap
  * if you don't have ps, download via bat or sh
* windows
  * thumbnail size
* apps
  * [nvm-windows](https://github.com/coreybutler/nvm-windows/releases)
* scripting
  * out-menu so we don't accidentally run anything
  * stop script if sub-error
  * use test checks
  * Add requires reboot and instructions on create admin account
  * todo - prompt for values or set via config?
* trackpad
  * invert scrolling
  * three finger tap -> middle click
* VS Code - Powershell Integrated Console
  * Use PS7

## Prior Art

* [windows-devenv/install.ps1](https://github.com/CodingSpiderFox/windows-devenv/blob/master/install.ps1)
* [Windows-10-1803-Post-Install-Script/Run_Once.ps1](https://github.com/Gaz2600/Windows-10-1803-Post-Install-Script/blob/master/Run_Once.ps1)

## Notes

* [Set File Type Association Default Application Command Line Windows 10 UserChoice Hash Internal Method](https://danysys.com/set-file-type-association-default-application-command-line-windows-10-userchoice-hash-internal-method/)

  > The main problem is that in recent versions of Windows 8/10 This key is protected by a hash associated with the file type, and succeeding in editing it without generating the valid hash the association is automatically restored to the default application.

```ps1
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
```

```xml
<Association Identifier=".htm" ProgId="MSEdgeHTM" ApplicationName="Microsoft Edge" />
<Association Identifier=".html" ProgId="MSEdgeHTM" ApplicationName="Microsoft Edge" />
<Association Identifier="http" ProgId="MSEdgeHTM" ApplicationName="Microsoft Edge" />
<Association Identifier="https" ProgId="MSEdgeHTM" ApplicationName="Microsoft Edge" />

<Association Identifier=".htm" ProgId="ChromeHTML" ApplicationName="Google Chrome" />
<Association Identifier=".html" ProgId="ChromeHTML" ApplicationName="Google Chrome" />
<Association Identifier="http" ProgId="ChromeHTML" ApplicationName="Google Chrome" />
<Association Identifier="https" ProgId="ChromeHTML" ApplicationName="Google Chrome" />
```

## VS Code

* [Enable or disable VS Code Integrated Terminal Tabs?](https://stackoverflow.com/q/40406096/1366033)

  ```json
  "terminal.integrated.tabs.enabled": true
  ```
