
struct OAuthRequest: Codable {
    let grantType: String
    let clientId: String
    let clientSecret: String
    let code: String?
    let redirectUri: String?
    let refreshToken: String?
    
    enum CodingKeys: String, CodingKey {
        case grantType = "grant_type"
        case clientId = "client_id"
        case clientSecret = "client_secret"
        case code
        case redirectUri = "redirect_uri"
        case refreshToken = "refresh_token"
    }
}
