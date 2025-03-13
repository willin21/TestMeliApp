import Alamofire

enum ApiRouter: URLRequestConvertible {
    case getSearch(query: String)
    case getSearchByCategory(id: String)
    case getCategories
    case getOauthToken(oauth: OAuthRequest)
    case refreshToken(oauth: OAuthRequest)
    case getUser

    var absoluteUrl: String {
        switch self {
        default:
            return getBaseDomain()
        }
    }
    
    var siteID: String {
        return "sites/MCO/"
    }

    func getBaseDomain() -> String {
        switch self {
        default:
            return Constants.Request.baseURL + path
        }
    }

    var path: String {
        switch self {
        case .getSearch, .getSearchByCategory:
            return siteID + "search"
            
        case .getCategories:
            return siteID + "categories"
            
        case .getOauthToken, .refreshToken:
            return "oauth/token"
            
        case .getUser:
            return "users/me"
        }
    }

    var headers: HTTPHeaders {
        switch self {
        case .getCategories:
            return [:]

        case .getSearch:
            
            return [
                "accept": "application/json",
            ]
        case .getOauthToken,
                .refreshToken:
            return [
                "content-type": "application/x-www-form-urlencoded"
            ]
        case .getUser, .getSearchByCategory:
            let accessToken = OAuthHelper.shared.getToken()
            
            if !accessToken.isEmpty {
                return ["Authorization": "Bearer \(accessToken)"]
            }
            
            return [:]
        }
    }

    var method: HTTPMethod {
        switch self {
        case .getOauthToken, .refreshToken:
            return .post
        default:
            return .get
        }
    }

    var params: [String: Any] {
        switch self {
        case .getCategories, .getUser:
            return [:]
            
        case .getSearch(let query):
            return ["q": query,
                    "limit": 15]
            
        case .getSearchByCategory(let categoryId):
            return ["category": categoryId]
            
        case .getOauthToken(let oauth), .refreshToken(let oauth):
            return oauth.toDictionary() ?? [:]
        }
    }

    var encoding: ParameterEncoding {
        switch self {
        case .getSearch,
                .getSearchByCategory,
                .getCategories,
                .getUser:
            
            return URLEncoding.queryString
            
        case .getOauthToken, .refreshToken:
            return URLEncoding.default
        }
    }

    func asURLRequest() throws -> URLRequest {
        let url = try absoluteUrl.asURL()
        var urlRequest = try URLRequest(url: url, method: method, headers: headers)
        urlRequest = try encoding.encode(urlRequest, with: params)

        return urlRequest
    }
}

