import Cocoa

_ = NSApplication.shared
//NSApp.setActivationPolicy(.regular)
let delegate = AppDelegate()
NSApp.delegate = delegate
NSApp.run()
