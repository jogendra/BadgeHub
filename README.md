# BadgeHub
A way to quickly add a notification badge icon to any view.

<img src="https://user-images.githubusercontent.com/20956124/52379966-080a5f00-2a92-11e9-8c85-9c34fabd4641.png">

[![CI Status](https://img.shields.io/travis/jogendra/BadgeHub.svg?style=flat)](https://travis-ci.org/jogendra/BadgeHub)
[![Version](https://img.shields.io/cocoapods/v/BadgeHub.svg?style=flat)](https://cocoapods.org/pods/BadgeHub)
[![License](https://img.shields.io/cocoapods/l/BadgeHub.svg?style=flat)](https://cocoapods.org/pods/BadgeHub)
[![Platform](https://img.shields.io/cocoapods/p/BadgeHub.svg?style=flat)](https://cocoapods.org/pods/BadgeHub)
[![Donate](https://img.shields.io/badge/Donate-PayPal-green.svg)](https://www.paypal.com/cgi-bin/webscr?cmd=_s-xclick&hosted_button_id=5TZAT3TL6XTD4&source=url)

![Blink](https://imgur.com/AEgi5tW.gif) ![Bump](https://i.imgur.com/238tikf.gif) ![Pop](https://i.imgur.com/aQ0sOtZ.gif) ![Custom](https://i.imgur.com/PhlDWXW.gif) ![setCircle](https://i.imgur.com/8CtI0nf.gif) ![showCount](https://i.imgur.com/VHdp2vO.gif) ![mix](https://i.imgur.com/4DohGxr.gif) ![hideCount](https://i.imgur.com/E3hOrX5.gif)

## Demo/Example
For demo:
```ruby
$ pod try BadgeHub
```

To run the example project, clone the repo, and run `pod install` from the Example directory first.
```ruby
$ cd Example
```
```ruby
$ pod install
```
If you don't have CocoaPods installed, grab it with `[sudo] gem install cocoapods`.
```ruby
$ open BadgeHub.xcworkspace
```

## Requirements
- iOS 10.0 or later
- Swift 5+
- Xcode 10+

## Installation

#### CocoaPods

BadgeHub is available through [CocoaPods](https://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'BadgeHub'
```

#### Manual Installation
Just drag the `BadgeHub.swift` files into your project.

## Usage
Initialization
```swift
let hub = BadgeHub(view: yourView) // Initially count set to 0
```
Increase count value by 1
```swift
hub.increment()
```
Increase count by some int value
```swift
hub.increment(by: Int)
```
Decrease count value by 1
```swift
hub.decrement()
```
Decrease count by some int value
```swift
hub.decrement(by: Int)
```
Set count to static integer value
```swift
hub.setCount(newCount: Int)
```
Combine actions

![mix](https://i.imgur.com/4DohGxr.gif)
```swift
hub.increment()
hub.pop()
hub.blink()
```
Don't forget to `import BadgeHub`

## Customization

Change the color of the notification circle

![setCircleColor](https://i.imgur.com/MrsGB4p.gif)
```swift
hub.setCircleColor(_ circleColor: UIColor?, label labelColor: UIColor?)
```
Change the border color and border width of the circle

![Custom](https://i.imgur.com/PhlDWXW.gif)
```swift
hub.setCircleBorderColor(_ color: UIColor?, borderWidth width: CGFloat)
```
Set the frame of the notification circle relative to the view

![setCircle](https://i.imgur.com/8CtI0nf.gif)
```swift
hub.setCircleAtFrame(_ frame: CGRect)
```
Move the circle (left/right or up/down)
```swift
hub.moveCircleBy(x: CGFloat, y: CGFloat)
```
Changes the size of the circle. setting a scale of 1 has no effect
```swift
hub.scaleCircleSize(by scale: CGFloat)
```
Hide the count (Blank Bedge)

![hideCount](https://i.imgur.com/E3hOrX5.gif)
```swift
hub.hideCount()
```
Show count again on the bedge

![showCount](https://i.imgur.com/VHdp2vO.gif)
```swift
hub.showCount()
```

## Animations

Pop out and pop in the bedge

![Pop](https://i.imgur.com/aQ0sOtZ.gif)
```swift
hub.pop()
```
Make bedge blinking

![Blink](https://imgur.com/AEgi5tW.gif)
```swift
hub.blink()
```
Animation that jumps similar to OSX dock icons

![Bump](https://i.imgur.com/238tikf.gif)
```swift
hub.bump()
```

## TROUBLESHOOTING
**Notification isn't showing up!**
* If the hub value is < 1, the circle hides.  Try calling `increment()`.
* Make sure the view you set the hub to is visible (i.e. did you call `self.view.addSubview(yourView)`?).
* Make sure you didn't call `hideCount()` anywhere. Call `showCount()` to counter this.

**It isn't incrementing / decrementing properly!**
* Any count < 1 doesn't show up. If you need help customizing this, reach out to me!

**The circle is in a weird place**
* If you want to resize the circle, use `scaleCircleSize(by scale: CGFloat)`. 0.5 will give you half the size, 2 will give you double.
* If the circle is just a few pixels off, use `moveCircleBy(x: CGFloat, y: CGFloat)`. This shifts the circle by the number of pixels given.
* If you want to manually set the circle, call `setCircleAtFrame(_ frame: CGRect)` and give it your own CGRect.

**Something else isn't working properly**
* Use github's issue reporter on the right.
* Send me an email jogendra.iitbhu@gmail.com

## Author

<table>
<tr>
<td>
<img src="https://avatars2.githubusercontent.com/u/20956124?s=400&u=01fab3fc9bb3d2ee799e314d3fe23c54d1deeb07&v=4" width="180"/>

Jogendra Kumar

<p align="center">
<a href = "https://github.com/jogendra"><img src = "http://www.iconninja.com/files/241/825/211/round-collaboration-social-github-code-circle-network-icon.svg" width="36" height = "36"/></a>
<a href = "https://twitter.com/jogendrafx"><img src = "https://www.shareicon.net/download/2016/07/06/107115_media.svg" width="36" height="36"/></a>
<a href = "https://www.linkedin.com/in/jogendrasingh24/"><img src = "http://www.iconninja.com/files/863/607/751/network-linkedin-social-connection-circular-circle-media-icon.svg" width="36" height="36"/></a>
</p>
</td>
</tr> 
</table>

## DONATION
If this project help you reduce time to develop or you loved this project, you can give me a cup of coffee :)

[![paypal](https://www.paypalobjects.com/en_US/i/btn/btn_donateCC_LG.gif)](https://www.paypal.com/cgi-bin/webscr?cmd=_s-xclick&hosted_button_id=5TZAT3TL6XTD4&source=url)

## License

BadgeHub is available under the MIT license. See the [LICENSE](LICENSE) file for more info.
