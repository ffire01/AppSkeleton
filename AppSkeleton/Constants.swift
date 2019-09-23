import Cocoa

internal let kDefaultWinStyle: NSWindow.StyleMask = [.titled, .miniaturizable, .closable, .resizable]
internal let kPadding: CGFloat = 5
internal let kTextFieldHeight: CGFloat = 24
internal let kStartupWidth: CGFloat = 700
internal let kStartupHeight: CGFloat = 400
internal let kWinMinWidth: CGFloat = 570
internal let kWinMinHeight: CGFloat = 400

internal let kNoColumnId = "IdCol"
internal let kRuleColumnId = "RuleCol"

internal let appName = ProcessInfo.processInfo.processName
internal let NEW_LINE: UInt8 = 0xA

internal let kgfwlistURLStr = "https://raw.githubusercontent.com/gfwlist/gfwlist/master/gfwlist.txt"
