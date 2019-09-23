import Cocoa

class MainView: NSView {
    var tableScrollV = NSScrollView(frame: CGRect.zero)
    var tableV = NSTableView(frame: CGRect.zero)
    var urlTextField = NSTextField(frame: CGRect.zero)
    var urlDefaultButton = NSButton(frame: CGRect.zero)
    var fetchButton = NSButton(frame: CGRect.zero)
    
    override init(frame frameRect: NSRect) {
        super.init(frame: frameRect)
//        needsLayout = true
        self.translatesAutoresizingMaskIntoConstraints = false
        urlDefaultButton.translatesAutoresizingMaskIntoConstraints = false
        urlDefaultButton.title = "Default URL"
        urlDefaultButton.bezelStyle = .smallSquare
        urlDefaultButton.setButtonType(.switch)
        urlDefaultButton.state = .on
        addSubview(urlDefaultButton)
        
        urlTextField.translatesAutoresizingMaskIntoConstraints = false
        urlTextField.isEditable = false
        urlTextField.isSelectable = true
        urlTextField.isBordered = true
        urlTextField.isBezeled = true
        urlTextField.maximumNumberOfLines = 1
        urlTextField.placeholderString = "Input URL here"
        urlTextField.stringValue = kgfwlistURLStr
        addSubview(urlTextField)
        
        fetchButton.translatesAutoresizingMaskIntoConstraints = false
        fetchButton.title = "Get"
        fetchButton.bezelStyle = .smallSquare
        addSubview(fetchButton)
        
        tableScrollV.translatesAutoresizingMaskIntoConstraints = false
        tableScrollV.documentView = tableV
        tableScrollV.hasVerticalScroller = true
        tableScrollV.autohidesScrollers = true
        
        let addColumn = { (_ title: String, _ idStr: String, _ minW: CGFloat, _ maxW: CGFloat) in
            let col = NSTableColumn(identifier: NSUserInterfaceItemIdentifier(rawValue: idStr))
            col.title = title
            col.minWidth = minW
            col.maxWidth = maxW
            self.tableV.addTableColumn(col)
        }
        
        addColumn("No.", kNoColumnId, 10, 40)
        addColumn("Rules", kRuleColumnId, 370, 700)
        
        tableV.intercellSpacing = CGSize(width: 5.0, height: 5.0)
        tableV.usesAlternatingRowBackgroundColors = true
        addSubview(tableScrollV)
    }
    
    required init?(coder decoder: NSCoder) {
        super.init(coder: decoder)
    }
    
    override func layout() {
        super.layout()
        var leddingWidth = kPadding
        var leddingHeight = frame.height - kTextFieldHeight - kPadding
        urlDefaultButton.frame = CGRect(x: leddingWidth,
                                        y: leddingHeight,
                                        width: urlDefaultButton.intrinsicContentSize.width + 7,
                                        height: kTextFieldHeight)
        leddingWidth += urlDefaultButton.frame.width + kPadding
        let fetchButtonWidth = fetchButton.intrinsicContentSize.width
        let urlTextFieldWidth = frame.width - leddingWidth - kPadding - fetchButtonWidth - kPadding
        urlTextField.frame = CGRect(x: leddingWidth,
                                    y: leddingHeight,
                                    width: urlTextFieldWidth,
                                    height: kTextFieldHeight)
        leddingWidth += urlTextFieldWidth + kPadding
        fetchButton.frame = CGRect(x: leddingWidth,
                                   y: leddingHeight,
                                   width: fetchButtonWidth,
                                   height: kTextFieldHeight)
        leddingHeight -= kPadding
        tableScrollV.frame = CGRect(x: 0, y: 0,
                                    width: frame.width,
                                    height: leddingHeight)
    }
    
//    override to change the background
//    override func draw(_ dirtyRect: NSRect) {
//        super.draw(dirtyRect)
//        NSColor(calibratedRed: 1.0, green: 0.0, blue: 0.0, alpha: 0.4).setFill()
//        dirtyRect.fill()
//    }
}
