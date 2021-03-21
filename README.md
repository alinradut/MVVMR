# MVVMR

[![Version](https://img.shields.io/cocoapods/v/MVVMR.svg?style=flat)](https://cocoapods.org/pods/MVVMR)
[![License](https://img.shields.io/cocoapods/l/MVVMR.svg?style=flat)](https://cocoapods.org/pods/MVVMR)
[![Platform](https://img.shields.io/cocoapods/p/MVVMR.svg?style=flat)](https://cocoapods.org/pods/MVVMR)

MVVMR is a modest implementation of the iOS Model-View-ViewModel pattern with an associated router. 

### Why

I started out to build MVVMR after being frustrated by the needless complexity and cleverness of other implementations and patterns: VIPER is overly verbose, RIB has completely fallen out of favor, CleanSwift feels too rigid and too much of a lock in along with a hefty dose of boilerplate code.

In a nutshell, MVVMR attempts complete separation of the view logic from business logic and navigational logic, while maintaining an experience as close as possible to vanilla iOS MVC. No more, no less.

The basic idea is the following: each screen is a `Scene`, which in turn is composed of the following:

* `ViewController` - Handles the view and the user interaction. This is your usual, run of the mill, `UIViewController` you are used to. Owns the `ViewModel`.
* `ViewModel` - Handles the business logic, reacting to user interaction, fetching and processing data obtained from `Models` and `Services`. Owns the `Router`. Communicates back and forth with the view controller via means of a data binding mechanism, but MVVMR has no preference over the implemenation, be it `RxSwift`, `Combine`,  `SimpleTwoWayBinding` or just plain callbacks, for flexibility this is left entirely upon the user to decide.
* `Router` - Handles the navigational logic. When it's initialized, an `UINavigationController` is attached to it along with an incoming `Transition`. When it needs to navigate away from the current screen, it usually intantiates a scene and displays it on the current navigation controller.

Unlike other implementations, MVVMR is not very opinionated about how to structure your code, leaving you full control of your implementation.

![MVVMR](/MVVMR_diagram.png)

#### Passing data between scenes

Although not required by default, it is recommended that a view model has a context object that is used to receive and exchange data with the upstream scenes. A common implementation would be the following:

```swift
public struct RegistrationContext {
    let onCompletion: (() -> Void)
}

public struct RegistrationViewModel {

    private(set)var context: RegistrationContext
    
    public func setContext(_ context: RegistrationContext) {
        self.context = context
    }
}
```

The upstream scene would navigate to this scene by calling the router from the view model:
```swift
router.navigate(to: .registration(.init(onCompletion: { print("Registered!") })))
```
And in the upstream router, we would pass this context by using the setContext closure that is part of the `Scene.show()` method:
```swift
Scene<RegisterViewController>.show(on: navigationController) {
    $0.setContext(context)
}
```

#### Code reuse, inheritability and extensibility

View controllers that need to be reused and extended, can safely do so by communicating with the view model over a protocol, instead of a concrete type, which is the default implementation as provided by the templates.

Let's take an example, a scan screen needs to scan a login or registration QR code, but the behavior after scanning the code needs to be different. We'll begin by defining the view controller:

```swift
class ScanViewController<T: ScanViewModel>: UIViewController, ViewController {
    let viewModel: T!
    // ...
    func scannerDidScan(code: String) {
        viewModel.scannerDidScan(code: code)
    }
}

// the protocol which will be implemented by the concrete types
protocol ScanViewModel {
    func scannerDidScan(code: String)
}

struct RegistrationScanViewModel: ScanViewModel {
    func scannerDidScan(code: String) {
        // handle code
    }
}

struct LoginScanViewModel: ScanViewModel {
    func scannerDidScan(code: String) {
        // handle code
    }
}
```

To create the appropriate scene, we'd do the following: 
```swift
Scene<ScanViewController<LoginScanViewModel>>.show(on: navigationController)
```
or 
```swift
Scene<ScanViewController<RegistrationScanViewModel>>.show(on: navigationController)
```

## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Templates

Creating 3 or 4 new files every time you want to add a new scene is tedious, so why not leverage the power of Xcode templates? An MVVMR Scene template is automatically provided in this repo, just run in the current directory:
```bash
./install-xcode-template.sh
```

or manually copy `MVVMR Scene.xctemplate` into `/Library/Developer/Xcode/Templates/File Templates/MVVMR`.

## Requirements

## Installation

MVVMR is available through [CocoaPods](https://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'MVVMR'
```

## Author

Alin Radut

## License

MVVMR is available under the MIT license. See the LICENSE file for more info.
