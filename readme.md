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
