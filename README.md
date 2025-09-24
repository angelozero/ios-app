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


## What is the `SceneDelegate`?

The `SceneDelegate` is the class responsible for managing the lifecycle of a "scene" in an iOS app. Introduced in iOS 13, it divides the responsibilities that previously fell only to the `AppDelegate`. While the `AppDelegate` handles the overall application lifecycle, the `SceneDelegate` manages the lifecycle of individual windows.

This is fundamental for apps that support multiple windows, such as on **iPadOS** and **macOS Catalyst**, where a user can have more than one instance of your app open at the same time.

### Structure and Protocols

The `SceneDelegate` is also a subclass of `UIResponder` and implements the `UIWindowSceneDelegate` protocol.

```swift
class SceneDelegate: UIResponder, UIWindowSceneDelegate {
// ...
}
```

  * **`UIWindowSceneDelegate`**: This protocol defines the methods that allow your app to react to lifecycle events of a specific scene, such as connection, disconnection, or state transitions (active, inactive, in the background).

-----

## Essential `SceneDelegate` Methods

The `SceneDelegate` methods are called at specific moments in a scene's lifecycle, allowing you to respond to events in a granular way.

### `scene(_:willConnectTo:options:)`

This is the first method called when a new scene (window) is being created and connected to the app.

```swift
func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
    // Use this method to optionally configure and attach the UIWindow `window` to the provided UIWindowScene `scene`.
    guard let windowScene = (scene as? UIWindowScene) else { return }
    
    // 1. Create a new UIWindow using the scene
    let window = UIWindow(windowScene: windowScene)
    
    // 2. Create and assign an initial ViewController
    let viewController = ViewController() // Replace with your ViewController
    window.rootViewController = viewController
    
    // 3. Make the window the key window and visible
    self.window = window
    window.makeKeyAndVisible()
}
```

  * **Purpose**: This is the main place to configure your scene's user interface. It's where you create the **`UIWindow`**, assign it the **`rootViewController`** (the app's initial screen), and make it visible.

### `sceneDidDisconnect(_:)`

Called when a scene is disconnected from the app by the system. This can happen when a user closes a window or when the system is releasing resources.

```swift
func sceneDidDisconnect(_ scene: UIScene) {
    // Release any resources associated with this scene that can be re-created
    // the next time the scene connects.
}
```

  * **Purpose**: Use this method to release resources that are specific to the discarded scene, such as closing network connections or open files, ensuring your app doesn't consume unnecessary memory.

### `sceneDidBecomeActive(_:)`

Invoked when the scene transitions from an inactive to an active state. A scene is considered "active" when it's visible and the user can interact with it.

```swift
func sceneDidBecomeActive(_ scene: UIScene) {
    // Use this method to restart any tasks that were paused
    // when the scene was inactive.
}
```

  * **Purpose**: This is the ideal time to start tasks that should only run when the app is in the foreground and interactive. For example, starting animations, updating data, or re-enabling data entry.

### `sceneWillResignActive(_:)`

Called when the scene is about to move from an active state to an inactive state. This may occur due to temporary interruptions, like an incoming phone call, or when the user switches to another app.

```swift
func sceneWillResignActive(_ scene: UIScene) {
    // Called when the scene will move from an active state to an inactive state.
}
```

  * **Purpose**: Great for pausing tasks that don't need to run in the background, such as stopping animations or saving the current state so the user can resume from where they left off.

### `sceneWillEnterForeground(_:)`

Triggered when the scene is about to transition from the background to the foreground.

```swift
func sceneWillEnterForeground(_ scene: UIScene) {
    // Called as the scene transitions from the background to the foreground.
}
```

  * **Purpose**: Use this method to "wake up" your app. For example, you can re-validate a user's token or reactivate the user interface that was in the background.

### `sceneDidEnterBackground(_:)`

This method is called when the scene transitions from the foreground to the background. The system can terminate your app at any time while it is in the background.

```swift
func sceneDidEnterBackground(_ scene: UIScene) {
    // Use this method to save data, release shared resources, and store enough scene-specific state information
    // to restore the scene back to its current state.
}
```

  * **Purpose**: This is a crucial moment to save any data the user has modified and release non-essential resources, like large media files or network connections. This ensures the app can be restored correctly and that the system can free up memory.

-----

## What is a `ViewController`?

The `ViewController` is the **main class for a screen** in an iOS application. It acts as an intermediary between the user interface (the `View`) and the data (`Model`), following the **MVC** (Model-View-Controller) design pattern. Its responsibility is to manage the screen's lifecycle, handle user interactions, and display data correctly.

Every screen in your app, such as the login screen, the main screen, or the settings screen, is typically controlled by its own `ViewController`.

### Structure and Protocols

The `ViewController` is a subclass of `UIViewController`, which is the fundamental class for managing screens in iOS.

```swift
class ViewController: UIViewController {
// ...
}
```

  * **`UIViewController`**: This is the base class from the **UIKit** framework for managing the user interface. It provides all the necessary methods and properties to load, display, and release a `view` (a screen), and to respond to system and user events.

-----

## Essential Lifecycle Methods

The `ViewController` has a well-defined lifecycle, with methods that are called at specific moments. You can override these methods to perform actions at each stage.

### `viewDidLoad()`

This is the most common and important method. It is called **only once** when the `ViewController`'s `view` is loaded into memory for the first time.

```swift
override func viewDidLoad() {
    super.viewDidLoad()
    // Perform any initial setup here.
}
```

  * **Purpose**: This is the ideal place to perform **initial configurations** that do not change during the screen's lifetime. For example:
      * **UI Setup**: Adding subviews, setting background colors, or adjusting constraints.
      * **Data Loading**: Making a network request to fetch data that will be displayed on the screen.
      * **Gesture Configuration**: Adding gesture recognizers (like taps or swipes) to the view.

### Other Important Methods

  * `viewWillAppear(_:)`: Called **every time** the `view` is about to appear on the screen. Use it for tasks that need to be updated before the screen is visible, like reloading data in a list.
  * `viewDidAppear(_:)`: Called **every time** the `view` has already appeared on the screen. Useful for starting animations or tasks that should only occur after the screen is fully visible to the user.
  * `viewWillDisappear(_:)`: Called when the `view` is about to be removed from the screen. Use it to save the screen's state or to dismiss keyboards.
  * `viewDidDisappear(_:)`: Called when the `view` has been completely removed from the view hierarchy. This is the place to stop ongoing tasks, such as stopping animations.

Understanding the difference between these methods is crucial for creating efficient and bug-free apps. For example, placing an API call in `viewDidLoad` is efficient because it will only be executed once. If the same call were in `viewWillAppear`, it would run every time the user navigates back to the screen, which could cause unnecessary data and battery consumption.

---

## What is `Main.storyboard`?

In the iOS development ecosystem, the **`Main.storyboard`** is not a code file but rather an interface file that describes the visual flow and layout of your app's screens.

`Main.storyboard` is an **XML** file that stores information about an application's user interface. It acts as a visual "blueprint," allowing you to create and organize screens (`View Controllers`), interface elements (`UIButtons`, `UILabels`, etc.), and the transitions between them (`Segues`).

Instead of writing code to position every button and label, you can use a graphical interface in **Xcode** to drag and drop these elements.

### Key Components

* **View Controllers**: Represent each screen of your app. In the Storyboard, each `View Controller` is a distinct scene.
* **Views**: These are the visual elements that make up the interface, such as buttons, text labels, and input fields.
* **Segues**: These are the arrows that link one `View Controller` to another. They define the transition from one screen to the next, either by clicking a button or after a specific action.
* **Auto Layout**: A system of constraints that ensures your interface adapts to different screen sizes (various generations of iPhones and iPads), orientations (portrait and landscape), and dynamic text sizes.

### How Does It Work?

When your app starts, the system loads the `Main.storyboard` and creates instances of the `View Controllers` and `views` it describes. The **`Segues`** are also configured, waiting to be triggered to perform the transition between screens.

It is important to note that using Storyboards is a traditional approach in iOS. While still widely used, many more experienced developers also choose to build interfaces entirely with code, especially in large and complex projects, to have more precise control and facilitate teamwork. However, for beginners and quick prototypes, the `Main.storyboard` is a powerful and intuitive tool.

---

## What is the `Assets` Folder?

The `Assets.xcassets` folder (commonly just called `Assets`) is a container in your Xcode project used to organizedly manage all the visual resources for your app, such as images, app icons, and colors.

It acts as a central catalog where you can add, configure, and optimize resources without having to deal directly with individual files.

### Key Components and Purpose

* **Images**: Instead of simply dragging a `.png` file into your project, you add it to the `Assets` folder. Xcode then automatically manages the different image resolutions (`@1x`, `@2x`, `@3x`) to ensure that images look sharp on all Apple devices, regardless of screen pixel density.
* **App Icon**: The icon that appears on your device's home screen is managed here. The `Assets` folder allows you to provide variations of the icon for different sizes and contexts (such as on the home screen, in notifications, or in the App Store), ensuring it adapts correctly.
* **Colors**: You can define custom, reusable colors in your project. By adding a color to the `Assets` folder, it can be accessed by name throughout your app, both in code and in the Storyboard. This makes maintenance easier and ensures a consistent color palette, especially when working with light and dark modes.

### Why Use `Assets`?

1.  **Organization**: It keeps all visual resources in a single, centralized location, making the project cleaner and easier to navigate.
2.  **Automatic Optimization**: Xcode optimizes images to the correct format and efficiently packages them into your app, which helps reduce the final file size.
3.  **Multiple Resolution Support**: The system automatically knows which image version to use for each device, eliminating the need to write manual code for this.
4.  **Dark Mode Support**: The `Assets` folder makes it easy to set up color and image variations for light and dark modes, allowing your app to dynamically adapt to the user's preference.

In summary, the `Assets` folder is an essential tool that simplifies the management of visual resources, ensuring your app is efficient and visually consistent across all iOS devices.