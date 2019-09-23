import Cocoa

final class TableVC: NSViewController, NSTableViewDelegate, DataSourceDelegate {
    
    private lazy var dataSrc = DataSource()
    private lazy var dataFetcher = NetFetcher()
    private lazy var session = URLSession(configuration: .default, delegate: dataFetcher, delegateQueue: nil)
    private var mainView: MainView {
        return self.view as! MainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        dataSrc.delegate = self
        mainView.tableV.dataSource = dataSrc
        mainView.tableV.delegate = self
        dataFetcher.delegate = dataSrc
        mainView.tableV.columnAutoresizingStyle = .firstColumnOnlyAutoresizingStyle
        
        mainView.urlDefaultButton.target = self
        mainView.urlDefaultButton.action = #selector(self.setDefaultURL(_:))
        
        mainView.fetchButton.target = self
        mainView.fetchButton.action = #selector(self.fetchURL(_:))
    }
    
    override func loadView() {
        self.view = MainView(frame: CGRect(x: 0, y: 0, width: kStartupWidth, height: kStartupHeight))
    }
    
    func dataSourceDidLoadData(_ dataSrc: DataSource) {
        DispatchQueue.main.async {
            self.mainView.fetchButton.isEnabled = true
            self.mainView.tableV.reloadData()
            self.mainView.tableV.sizeToFit()
        }
    }
    
    func dataSourceDidGetError(_ sender: AnyObject) {
        DispatchQueue.main.async {
            self.mainView.fetchButton.isEnabled = true
        }
    }
    
    @objc func setDefaultURL(_ sender: AnyObject) {
        guard let b = sender as? NSButton else { return }
        if b.state == .off {
            self.view.window?.makeFirstResponder(mainView.urlTextField)
            mainView.urlTextField.isEditable = true
            mainView.urlTextField.stringValue = ""
        } else if b.state == .on {
            self.view.window?.makeFirstResponder(mainView.urlDefaultButton)
            mainView.urlTextField.isEditable = false
            mainView.urlTextField.isSelectable = true
            mainView.urlTextField.stringValue = kgfwlistURLStr
        }
    }
    
    @objc func fetchURL(_ sender: AnyObject) {
        let urlStr = mainView.urlTextField.stringValue
        guard !urlStr.isEmpty else { return }
        guard let b = sender as? NSButton else { return }
        b.isEnabled = false
        guard let url = URL(string: urlStr) else { return }
        dataFetcher.startFetching(url: url, session: session)
    }

    func tableView(_ tableView: NSTableView, viewFor tableColumn: NSTableColumn?, row: Int) -> NSView? {
        guard let id = tableColumn?.identifier else {
            return nil
        }
        var columnTextField = tableView.makeView(withIdentifier: id, owner: nil) as? NSTextField
        if columnTextField == nil {
//            #if DEBUG
//            struct Counter {
//                static var tf_counts = 0
//            }
//            Counter.tf_counts += 1
//            print("create new text field, total no now: ", Counter.tf_counts)
//            #endif
            columnTextField = NSTextField(labelWithString: "")
            columnTextField?.identifier = id
        }
        
        if id.rawValue == kNoColumnId {
            columnTextField?.stringValue = String(row + 1)
        }
        if id.rawValue == kRuleColumnId {
            columnTextField?.stringValue = dataSrc.rowData[row]
        }

        return columnTextField
    }
    
    deinit {
        session.finishTasksAndInvalidate()
    }
}
