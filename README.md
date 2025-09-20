# My First iOs App

The `AppDelegate` is the main class of an iOS application, responsible for managing the application's lifecycle. It interacts directly with **UIKit** to respond to important events, such as app launch, transitioning to the background, and termination.

-----

## `AppDelegate` Structure

### Imports and Annotations

The `AppDelegate` class typically starts with the `UIKit` framework import and the `@main` annotation.

```swift
import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
// ...
}
```

  * `import UIKit`: This command brings in all the necessary tools and classes to build the user interface and manage the application's lifecycle.
  * `@main`: This annotation is crucial. Introduced with **SwiftUI** and later adopted by **UIKit**, it marks `AppDelegate` as the main entry point for the application. In other words, when your app is launched, the system knows to start its execution from this class.

### Protocols

The `AppDelegate` implements two protocols: `UIResponder` and `UIApplicationDelegate`.

```swift
class AppDelegate: UIResponder, UIApplicationDelegate {
// ...
}
```

  * `UIResponder`: This is the base class for objects that can respond to user events and handle event chains (like screen touches and movements). The `AppDelegate` inherits this capability.
  * `UIApplicationDelegate`: This is the most important protocol for the `AppDelegate`. It defines a set of methods that your app can implement to react to system events, such as the app starting or ending its execution.

-----

## Essential Methods

The `AppDelegate` contains several methods that the system calls at specific moments in the application's lifecycle.

### `application(_:didFinishLaunchingWithOptions:)`

This is the first method called when the application is launched.

```swift
func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
    // Override point for customization after application launch.
    return true
}
```

  * **Purpose**: This is the ideal place to perform your app's initial setup, such as initializing third-party libraries, configuring databases, or performing any initial setup before the user interface is displayed. Returning `true` signals to the system that the app's launch was successful.

### Scene Lifecycle Methods (iOS 13+)

Starting with iOS 13, the **"Scene"** concept was introduced to support multiple windows on iPads and macOS.

#### `application(_:configurationForConnecting:options:)`

This method is called when a new scene (or window) is being created.

```swift
func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
    // Use this method to select a configuration to create the new scene with.
    return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
}
```

  * **Purpose**: You use this to provide a configuration for the new scene, such as which `Info.plist` to use for the layout or how it should behave. The returned `UISceneConfiguration` defines the foundation for the new window.

#### `application(_:didDiscardSceneSessions:)`

This method is invoked when the user discards a scene (for example, by closing a window on the iPad).

```swift
func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
    // Called when the user discards a scene session.
    // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
}
```

  * **Purpose**: This is the place to release resources associated with the scene that is being closed. For instance, if a scene was responsible for a specific file, you can close that file here.


---