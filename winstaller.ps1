# import modules
Get-ChildItem "**/*.psm1" | Import-Module -Force

Invoke-CreateLocalAdmin
Invoke-RenameUser
Invoke-InstallApps
Invoke-ConfigureGit
Invoke-ConfigureGithub
Invoke-ConfigureGitRepos
Invoke-ConfigurePowerPlan
