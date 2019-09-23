import Cocoa

final class MainWindowController: NSWindowController/*, NSWindowDelegate */{
    override func loadWindow() {
        self.window = NSWindow(contentRect: CGRect(x: 0, y: 0, width: kStartupWidth, height: kStartupHeight), styleMask: kDefaultWinStyle, backing: .buffered, defer: false)
    }

    override func windowDidLoad() {
        super.windowDidLoad()
//        self.window?.delegate = self
        self.window?.minSize = CGSize(width: kWinMinWidth, height: kWinMinHeight)
        self.window?.cascadeTopLeft(from: NSPoint(x: 20, y: 20))
        self.window?.title = appName
        self.window?.backgroundColor = NSColor(calibratedRed: 0.7, green: 0.7, blue: 0.7, alpha: 1.0)
        self.contentViewController = TableVC()
    }
    
    // this override is needed if you want to programmatically create window
    // through override loadWindow, detailed info is explained in:
    // https://github.com/lionheart/openradar-mirror/issues/11340
    override var windowNibName: NSNib.Name? {
        return ""
    }
}
