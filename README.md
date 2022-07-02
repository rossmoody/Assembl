<div align="center">
 <a href="https://assembl.app">
  <img src="Assets/app_icon.png" width="200" height="200">
 </a>
 <h1>Assembl</h1>
 <p>
  <b>Dead simple window manager for MacOS</b>
 </p>

 <br>
</div>

Assemble, organize, and maximize all screen windows with one keyboard shortcut.

## Features

-

## Download

### Download Assembl for macOS

Requires macOS 12 or later.

## FAQ

### Isn't Assembl just like [Rectangle](https://rectangleapp.com/) and [Magnet](https://magnet.crowdcafe.com) but without as much functionality?

Yes, no question. Rectangle and Magnet contain more functionality and customization options. Plus, I made this app almost entirely by dissecting the [open-source code from the Rectangle repository](https://github.com/rxhanson/Rectangle) to learn Swift (I usually write Typescript). So it's the same app with less functionality. _(Thank you, Rectangle folks, I learned so much)_.

I wanted an app where I press one key and have all my windows organized. So, this app could be for you if you want that one thing.

### Does this mean you won't be adding new functionality?

I personally found it tedious to organize my windows one at a time the way Rectangle and Magnet do. Plus, I could never remember the keyboard shortcuts. Assembl intentionally strips all that.

The only improvement I may make to this app is the experience of organizing all windows at once, with one keyboard shortcut, to one screen.

This may include:

- Gather all windows from all screens instead of just the screen the mouse is on
- Reset all the windows to their previous positions and sizes
- Ignore selected screens from being queried

### Why isn't Assembl on the App Store?

Assembl, Magnet, and Rectangle all resize windows using the [Accessibility API](https://developer.apple.com/documentation/objectivec/nsobject/uiaccessibility). It's a hacky approach that developers have been doing since before 2010, but Apple doesn't provide any other way to manage windows. Since 2012, [Apple no longer allows the Accessibility API](https://developer.apple.com/library/archive/documentation/Security/Conceptual/AppSandboxDesignGuide/DesigningYourSandbox/DesigningYourSandbox.html) for apps in the App Store because they must be sandboxed.

This is why Rectangle isn't in the App Store, as well. Magnet was approved by Apple before the change in 2012 and therefore gets to be the only window manager app in the App Store with no possibility for competition in perpetuity.

## Built with

- [KeyboardShortcuts](https://github.com/sindresorhus/KeyboardShortcuts) - Add user-customizable global keyboard shortcuts to your macOS app
- [LaunchAtLogin](https://github.com/sindresorhus/LaunchAtLogin) - Add “Launch at Login” functionality to your macOS app in seconds
- [SwiftUIWindow](https://github.com/mortenjust/SwiftUIWindow) - Open a new macOS (10.12+) window with SwiftUI contents.

## Links

- [More apps by me](https://rossmoody.com)
