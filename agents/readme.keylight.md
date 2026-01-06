# Auto Elgato

A script to turn off elgato key lights when the monitor is turned off and turn back on upon wake

## Setup

1. Place the plist in `~/Library/LaunchAgents/com.user.keylight.plist`
2. Place the script in `~/Scripts/keylight_auto.swift`
3. Get the IP of your light in Elgato Control Center > Settings and replace in script
4. Make the script executable

    ```bash
    chmod +x ~/Scripts/keylight_auto.swift
    ```

5. Register and start the launch agent

    ```bash
    launchctl load ~/Library/LaunchAgents/com.user.keylight.plist
    ```

## Debugging

1. Verify it's running with

    ```bash
    launchctl list | grep keylight
    ```

2. In order to stop the agent, run

    ```bash
    launchctl unload ~/Library/LaunchAgents/com.user.keylight.plist
    ```

3. If you need to check the logs, run

    ```bash
    cat /tmp/keylight.out
    cat /tmp/keylight.err
    ```
