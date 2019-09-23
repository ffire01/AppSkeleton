import Cocoa

final class AppDelegate: NSObject, NSApplicationDelegate {
    let mainWC = MainWindowController()
    
    func applicationDidFinishLaunching(_ aNotification: Notification) {
        setMenus()
        mainWC.showWindow(nil)
    }

    func applicationWillTerminate(_ aNotification: Notification) {
    }

    private func setMenus() {
        let menubar = NSMenu()
        let appMenuItem = NSMenuItem()
        menubar.addItem(appMenuItem)
        NSApp.mainMenu = menubar
        
        let appMenu = NSMenu()
        var quitTitle = "Quit "
        quitTitle.append(appName)
        let quitMenuItem = NSMenuItem(title: quitTitle,
                                      action: #selector(NSApp.terminate(_:)),
                                      keyEquivalent: "q")
        appMenu.addItem(quitMenuItem)
        appMenuItem.submenu = appMenu
    }
}
