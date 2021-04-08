# Routes-iOS

Routes are responsible for transitions for alerts, system dialogs, to other apps and etc. Plugged by DI principle in coordinator.

Available routes:
- MailRoute - route to default mail app with draft
- PhotoRoute - route to default image or video picker
- AlertRoute - route for showing default alert
- ShareRoute - route to default share flow
- URLRoute - route to open URL with safary view controller or with default browser

## Installation

### Depo

[Depo](https://github.com/rosberry/depo) is a universal dependency manager that combines CocoaPods, Carthage and SPM.

You can use Depo to install Routes-iOS by adding it to your `Depofile`:
```yaml
carts:
  - kind: github
    identifier: rosberry/Routes-iOS
```

### Carthage

[Carthage](https://github.com/Carthage/Carthage) is a decentralized dependency manager that builds your dependencies and provides you with binary frameworks. To integrate Routes-iOS into your Xcode project using Carthage, specify it in your `Cartfile`:

```ogdl
github "rosberry/Routes-iOS"
```

## About

<img src="https://github.com/rosberry/Foundation/blob/master/Assets/full_logo.png?raw=true" height="100" />

This project is owned and maintained by [Rosberry](http://rosberry.com). We build mobile apps for users worldwide 🌏.

Check out our [open source projects](https://github.com/rosberry), read [our blog](https://medium.com/@Rosberry) or give us a high-five on 🐦 [@rosberryapps](http://twitter.com/RosberryApps).

## License

Core-iOS is available under the MIT license. See the LICENSE file for more info.
