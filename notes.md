# Notes


* [How to create new account with PowerShell on Windows 10](https://pureinfotech.com/create-new-user-account-powershell-windows-10/)
* [What is the Linq.First equivalent in PowerShell?](https://stackoverflow.com/q/5360145)
* [Rename Windows user account and profile folder](https://tinyapps.org/docs/rename-user-profile-folder.html)
* [rename user directory](https://superuser.com/q/890812/180163)
* [get registry key value](https://stackoverflow.com/q/15511809)

    ```ps1
    $profileKeys = "HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\ProfileList\*"
    $profileKeys = "Registry::HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\ProfileList\*"
    ```

* [registry subkeys](https://stackoverflow.com/a/37746096)
* [working with registry entries](https://docs.microsoft.com/en-us/powershell/scripting/samples/working-with-registry-entries?view=powershell-7.2)

* [Full Listing of Installed Programs using Powershell](https://stackoverflow.com/q/53161112/1366033)
* [How can I uninstall an application using PowerShell?](https://stackoverflow.com/q/113542/1366033)

* [How to check if a cmdlet exists in PowerShell at runtime via script](https://stackoverflow.com/q/3919798/1366033)
* [Load all functions into PowerShell from a certain directory](https://stackoverflow.com/q/763799/1366033)

  ```ps1
  'G:\sync\Office\*.psm1' | gci | Import-Module
  ```

* [PowerShell module design - Export-ModuleMember](https://stackoverflow.com/q/22205103/1366033)
* [Relative path in Import-Module](https://stackoverflow.com/q/14382579/1366033)

  ```ps1
  Import-Module $PSScriptRoot\Script1.ps1
  ```

* [Powershell split() vs -split - what's the difference?](https://stackoverflow.com/q/23796959/1366033)

  ```ps1
  "1,2" -split ","
  "1,2".split(",")
  ```

* [Split a string with spaces on a new line in PowerShell](https://stackoverflow.com/q/41836526/1366033)

  [about Split](https://docs.microsoft.com/en-us/powershell/module/microsoft.powershell.core/about/about_split?view=powershell-7.2)

* Powershell Docs
  * [Approved Verbs for PowerShell Commands](https://docs.microsoft.com/en-us/powershell/scripting/developer/cmdlet/approved-verbs-for-windows-powershell-commands?view=powershell-7.2#common-verbs)
  * [about PSModulePath](https://docs.microsoft.com/en-us/powershell/module/microsoft.powershell.core/about/about_psmodulepath?view=powershell-7.2)

* Static Analysis
  * [PowerShell editing with Visual Studio Code](https://code.visualstudio.com/docs/languages/powershell#_plaster)
  * [Invoke-ScriptAnalyzer (PSScriptAnalyzer)](https://docs.microsoft.com/en-us/powershell/module/psscriptanalyzer/invoke-scriptanalyzer?view=ps-modules)
  * [List of PSScriptAnalyzer rules](https://docs.microsoft.com/en-us/powershell/utility-modules/psscriptanalyzer/rules/readme?view=ps-modules)

* [How do I force powershell to reload a custom module?](https://stackoverflow.com/q/39426477/1366033)

  ```ps1
  Import-Module -Force
  ```

* [Param list vs Param block](https://stackoverflow.com/q/61944141/1366033)

  * Interchangeable, but `param(...)` offers more options

* [Executing powershell with or without parenthesis](https://stackoverflow.com/q/26941644/1366033)

  * When you call a($svr, $usr) you're passing an array with the two values as the single value of the first parameter
  * *without* the enclosing `(...)` the arguments are parsed in argument mode, where, notably, strings needn't be quoted
  * *with* the enclosing `(...)`, are parsed in expression mode, where strings do need to be quoted.

* [How to define the return type / OutputType of a function](https://stackoverflow.com/q/57478715/1366033)

  ```ps1
  function SomeFunction
  {
      [OutputType([string])]
      param(
          [string]$SomeParameter
      )

      return $SomeParameter
  }
  ```

  * **Note**: `[OutputType()]` makes *no guarantees* as to the type of objects emitted during execution
    * It's simply a way for the author of a function to indicate the *intended output type*.

* Pluralsight
  * [Getting Started with PowerShell Scripting](https://app.pluralsight.com/library/courses/powershell-scripting-getting-started/table-of-contents)
  * [Performing Windows 10 Post-installation Tasks](https://app.pluralsight.com/library/courses/windows-10-performing-post-installation-tasks-cert/table-of-contents)


The cmdlet 'Get-CommandExists' uses a plural noun. A singular noun should be used instead.


* [How to change a Windows username using the command prompt?](https://superuser.com/q/1159929/180163)

  ```bash
  Rename-LocalUser -Name "Kylem" -NewName "kylemit"
  ```

  * [`Rename-LocalUser`](https://docs.microsoft.com/en-us/powershell/module/microsoft.powershell.localaccounts/rename-localuser?view=powershell-5.1)




* [Add Native PowerShell Support](https://github.com/microsoft/winget-cli/issues/221)

  [How to create a list of non upgradable software for winget](https://www.codewrecks.com/post/general/winget-update-selective/)


## VS Code

* [How to change indentation in Visual Studio Code?](https://stackoverflow.com/q/34174207/1366033)

  ```json
  "[typescript]": {
      "editor.tabSize": 2
  }
  ```

## Regex

* [Regular Expression for alphanumeric and underscores](https://stackoverflow.com/q/336210/1366033)

  `\w` is equivalent to `[A-Za-z0-9_]`

* [Regex for Guid](https://stackoverflow.com/questions/11040707/c-sharp-regex-for-guid)

  ```js
  /[0-9A-F]{8}-?[0-9A-F]{4}-?[0-9A-F]{4}-?[0-9A-F]{4}-?[0-9A-F]{12}/i
  ```

* [Ternary operator in PowerShell](https://stackoverflow.com/q/31341998/1366033)

  * Powershell 7 allows [ternary operators](https://docs.microsoft.com/en-us/powershell/scripting/whats-new/what-s-new-in-powershell-70?view=powershell-7#ternary-operator):

    ```ps1
    $message = (Test-Path $path) ? "Path exists" : "Path not found"
    ```

  * Earlier versions: PowerShell gives back values that haven't been assigned.

    ```ps1
    $a = if ($condition) { $true } else { $false }
    ```

  * Further Reading
    * [PowerShell inline If (IIf)](https://stackoverflow.com/q/25682507/1366033)
    * [PowerShell syntax for something like :? operator?](https://stackoverflow.com/q/52899849/1366033)
    * [PSAvoidUsingCmdletAliases fires on ternary operator](https://github.com/PowerShell/PSScriptAnalyzer/issues/1612)
