import Alamofire
import RxSwift
import CocoaLumberjack

protocol NetworkRequest {
    func request<T: Codable>(_ api: ApiRouter) -> Observable<T>
}

class NetworkManager: NetworkRequest {
    private let session: Session

    init() {
        let config = URLSessionConfiguration.default
        config.timeoutIntervalForRequest = 15
        config.timeoutIntervalForResource = 15
        session = Session(configuration: config)
    }
    
    func request<T: Codable>(_ api: ApiRouter) -> Observable<T> {
        let request = session.request(api)
        return Observable.create { (observer) -> Disposable in
            request
                .validate()
                .response { (response) in
                    
                    if let data = response.data {
                        do {
                            let model: T = try T.toModel(data: data)
                            
                            DDLogInfo("Parsing data from '\(api.path)' was successfully.")
                            observer.onNext(model)
                        } catch let error {
                            let nsError = NSError(domain: "Parsing data error.", code: response.response?.statusCode ?? 0, userInfo: ["message": error.localizedDescription])
                            let errorDescription = error.localizedDescription
                            
                            DDLogError("Parsing data error: \(errorDescription)")
                            observer.onError(nsError)
                        }
                    } else if let error = response.error {
                        let nsError = NSError(domain: "Error", code: 0, userInfo: ["message": error.localizedDescription])
                        let errorDescription = error.localizedDescription
                        
                        DDLogError("Response error on api \(api.path): \(errorDescription)")
                        observer.onError(nsError)
                    }
                }
            return Disposables.create()
        }
    }
}
