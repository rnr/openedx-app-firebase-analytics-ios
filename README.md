# OEXFirebaseAnalytics

OEXFirebaseAnalytics is a Firebase Analytics integration plugin for the OpenEdX iOS application. This package provides seamless integration with Firebase Analytics while conforming to the analytics protocols defined in OEXFoundation.

## Overview

This analytics service allows OpenEdX iOS app to:
- Track user interactions
- Log custom events
- Monitor screen views
- Identify users
- Format analytics data according to Firebase requirements

## Requirements

- iOS 16.0+
- Swift 6.0+
- OEXFoundation 1.0.0
- Firebase iOS SDK 11.3.0+

## Installation

### Step 1: Add Package Dependency

<img width="1127" alt="Screenshot 2024-10-29 at 17 33 06" src="https://github.com/user-attachments/assets/fdd60f8b-bd61-4c3d-b97f-4b28323ec369">

1. Open your OpenEdX iOS project in Xcode
2. Navigate to project settings > Package Dependencies
3. Click the '+' button to add a new package dependency
4. Enter the package URL: `https://github.com/openedx/openedx-app-firebase-analytics-ios`
5. Set the Dependency Rule to "Exact Version" and version to "1.0.0"
6. Click "Add Package"

### Step 2: Add Framework to Your Target

<img width="600" alt="Screenshot 2024-10-29 at 17 33 26" src="https://github.com/user-attachments/assets/ef7b07a5-9fdf-4bbe-b47f-ba328a6faafb">

If you don't see OEXFirebaseAnalytics in the list:
1. Click the '+' button
2. Click "Add Other..."
3. Choose "Add Package Dependency..."
4. Select OEXFirebaseAnalytics from the list
5. Click "Add"

## Setup

1. Ensure Firebase is properly configured in your OpenEdX iOS app by following the [Firebase iOS setup guide](https://firebase.google.com/docs/ios/setup)

2. Initialize the Firebase Analytics service in your OpenEdX application:

```swift
import OEXFirebaseAnalytics
import OEXFoundation

class AppDelegate: UIResponder, UIApplicationDelegate {
    private let pluginManager = PluginManager()

    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {
        initPlugins()
        return true
    }

    private func initPlugins() {
        pluginManager.addPlugin(analyticsService: FirebaseAnalyticsService())
    }
}
```

## Features

### User Identification
```swift
func identify(id: String, username: String?, email: String?)
```
Sets the Firebase user ID for user-scoped analytics in the OpenEdX app.

### Event Logging
```swift
func logEvent(_ event: String, parameters: [String: Any]?)
```
Logs custom events with optional parameters. The service automatically formats event names and parameters to comply with Firebase Analytics requirements:
- Event names are limited to 40 characters
- Parameter values are limited to 100 characters
- Special characters are replaced with underscores
- Double underscores are consolidated

### Screen View Tracking
```swift
func logScreenEvent(_ event: String, parameters: [String: Any]?)
```
Logs screen view events with optional parameters.
