import Foundation
import RxSwift

protocol RepositoryProtocol {
    func getOAuthToken(oauth: OAuthRequest) -> Observable<OAuthResponse>
    func refreshToken(oauth: OAuthRequest) -> Observable<OAuthResponse>
    func getSearch(query: String) -> Observable<SearchResponse>
    func getCategories() -> Observable<Categories>
    func getSearchByCategory(id: String) -> Observable<SearchResponse>
    func getUser() -> Observable<UserResponse>
}
