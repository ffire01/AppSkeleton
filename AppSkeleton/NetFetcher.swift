import Foundation

protocol NetFetcherDelegate: AnyObject {
    func fetchDidComplete(_ sender: NetFetcher)
    func fetchGotError(_ sender: NetFetcher)
}

class NetFetcher: NSObject, URLSessionDataDelegate {
    
    var receivedData: Data
    var receivedResponse: HTTPURLResponse?
    weak var delegate: NetFetcherDelegate?
    
    override init() {
        self.receivedData = Data()
        super.init()
    }
    
    func startFetching(url: URL, session: URLSession) {
        receivedData.removeAll()
        let task = session.dataTask(with: url)
        task.resume()
    }
    
    func urlSession(_ session: URLSession, dataTask: URLSessionDataTask, didReceive response: URLResponse, completionHandler: @escaping (URLSession.ResponseDisposition) -> Void) {
        receivedResponse = response as? HTTPURLResponse
        guard let response = response as? HTTPURLResponse,
//            let mimeType = response.mimeType,
            response.statusCode >= 200 && response.statusCode <= 299 /*&& mimeType == "text/plain"*/ else {
                delegate?.fetchGotError(self)
                completionHandler(.cancel)
                return
        }
//        #if DEBUG
//        print("[HTTP Response Headers Begin]")
//        for (key, val) in response.allHeaderFields {
//            if let k = key as? String, let v = val as? String {
//                print("\(k): \(v)")
//            }
//        }
//        print("[HTTP Response Headers End]")
//        #endif
        completionHandler(.allow)
    }
    
    func urlSession(_ session: URLSession, dataTask: URLSessionDataTask, didReceive data: Data) {
        #if DEBUG
        print("received data bytes: \(data.count)")
        #endif
        self.receivedData.append(data)
    }
    
    func urlSession(_ session: URLSession, task: URLSessionTask, didCompleteWithError error: Error?) {
        if let err = error {
            delegate?.fetchGotError(self)
            print(err)
        } else {
            delegate?.fetchDidComplete(self)
        }
    }
}
