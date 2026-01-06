#!/usr/bin/env swift

import Foundation
import Cocoa

let lightIP = "192.168.1.XX" // Replace with your Light IP

func setLight(on: Bool) {
    guard let url = URL(string: "http://\(lightIP):9123/elgato/lights") else { return }
    
    var request = URLRequest(url: url)
    request.httpMethod = "PUT"
    request.setValue("application/json", forHTTPHeaderField: "Content-Type")
    request.timeoutInterval = 5.0

    let state = on ? 1 : 0
    let body: [String: Any] = [
        "lights": [["on": state]]
    ]
    
    request.httpBody = try? JSONSerialization.data(withJSONObject: body)
    
    let task = URLSession.shared.dataTask(with: request) { _, _, error in
        if let error = error {
            print("Error: \(error.localizedDescription)")
        } else {
            print("Light turned \(on ? "ON" : "OFF")")
        }
    }
    task.resume()
}

// DistributedNotificationCenter is for System-level events like Screen Lock
let dnc = DistributedNotificationCenter.default()

// NSWorkspace.shared.notificationCenter is for User-level events like Sleep/Wake
let wsnc = NSWorkspace.shared.notificationCenter

// --- OFF EVENTS ---
// 1. Manually locking the screen (Cmd+Ctrl+Q)
dnc.addObserver(
    forName: NSNotification.Name("com.apple.screenIsLocked"),
    object: nil,
    queue: .main
) { _ in
    print("Screen locked - turning off light")
    setLight(on: false)
}

// 2. The system putting the displays to sleep (Inactivity)
wsnc.addObserver(
    forName: NSWorkspace.willSleepNotification,
    object: nil,
    queue: .main
) { _ in
    print("Event - Workspace Will Sleep")
    setLight(on: false)
}

// --- ON EVENTS ---
// 1. Unlocking the screen
dnc.addObserver(
    forName: NSNotification.Name("com.apple.screenIsUnlocked"),
    object: nil,
    queue: .main
) { _ in
    print("Screen unlocked - turning on light")
    setLight(on: true)
}

// 2. Waking from sleep
wsnc.addObserver(
    forName: NSWorkspace.didWakeNotification,
    object: nil,
    queue: .main
) { _ in
    print("Event - Workspace Did Wake")
    setLight(on: true)
}

print("Elgato Lock Monitor running...")
print("Listening for Sleep/Wake and Lock/Unlock events. Press Ctrl+C to stop.")

RunLoop.main.run()
