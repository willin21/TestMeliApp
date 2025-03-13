import RxSwift

class BaseRepository {
    
    let network = NetworkManager()
    
    func callService<T: Codable>(api: ApiRouter) -> Observable<T> {
        return network.request(api)
    }
    
}
