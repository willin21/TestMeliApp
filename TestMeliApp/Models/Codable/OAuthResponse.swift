import Foundation

typealias OAuthToken = [OAuthResponse]

struct OAuthResponse: Codable {
    let accessToken: String
    let tokenType: String
    let expiresIn: Date
    let scope: String
    let userId: Int
    let refreshToken: String

    enum CodingKeys: String, CodingKey {
        case accessToken = "access_token"
        case tokenType = "token_type"
        case expiresIn = "expires_in"
        case scope
        case userId = "user_id"
        case refreshToken = "refresh_token"
    }
}
