import RxSwift
import RxCocoa

class AppRepository: BaseRepository, RepositoryProtocol {
    
    func getOAuthToken(oauth: OAuthRequest) -> Observable<OAuthResponse>  {
        return callService(api: ApiRouter.getOauthToken(oauth: oauth))
    }
    
    func refreshToken(oauth: OAuthRequest) -> Observable<OAuthResponse>  {
        return callService(api: ApiRouter.refreshToken(oauth: oauth))
    }

    func getSearch(query: String) -> Observable<SearchResponse> {
        return callService(api: ApiRouter.getSearch(query: query))
    }
    
    func getSearchByCategory(id: String) -> Observable<SearchResponse> {
        return callService(api: ApiRouter.getSearchByCategory(id: id))
    }
    
    func getCategories() -> Observable<Categories> {
        return callService(api: ApiRouter.getCategories)
    }
    
    func getUser() -> Observable<UserResponse> {
        return callService(api: ApiRouter.getUser)
    }
}

