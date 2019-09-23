import Cocoa

protocol DataSourceDelegate: AnyObject {
    func dataSourceDidLoadData(_ dataSrc: DataSource)
    func dataSourceDidGetError(_ sender: AnyObject)
}

class DataSource: NSObject, NSTableViewDataSource, NetFetcherDelegate {

    var rowData = [String]()
    weak var delegate: DataSourceDelegate?
    
    func fetchDidComplete(_ sender: NetFetcher) {
        if let urlStr = sender.receivedResponse?.url?.absoluteString {
            if urlStr == kgfwlistURLStr {
                guard let decodedData = Data(base64Encoded: sender.receivedData, options: .ignoreUnknownCharacters) else {
                    print("Cannot deceded raw data!")
                    delegate?.dataSourceDidGetError(self)
                    return
                }
                rowData = decodedData.split(separator: NEW_LINE).map {
                    String(data: $0, encoding: .utf8) ?? ""
                }
            } else if let mime = sender.receivedResponse?.mimeType, mime == "text/html" {
                rowData = sender.receivedData.split(separator: NEW_LINE).map {
                    String(data: $0, encoding: .utf8) ?? ""
                }
            }
        } else { return }
        delegate?.dataSourceDidLoadData(self)
    }
    
    func fetchGotError(_ sender: NetFetcher) {
        delegate?.dataSourceDidGetError(sender)
    }
    
    func numberOfRows(in tableView: NSTableView) -> Int {
        return rowData.count
    }
}
