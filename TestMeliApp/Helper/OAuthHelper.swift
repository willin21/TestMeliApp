import Foundation

class OAuthHelper {
    
    static let shared = OAuthHelper()
    
    func getToken() -> String {
        guard let accessToken = UserDefaultsHelper.getString(forKey: Constants.UserDefaults.accessToken) else {
            return ""
        }
        
        return accessToken
    }
    
    func getUser() -> [User]? {
        guard let data = UserDefaultsHelper.getObject(forKey: Constants.UserDefaults.user) else {
            return nil
        }
        
        return (try? JSONDecoder().decode([User].self, from: data)) ?? []
    }
    
    func saveUser(_ user: User) throws {
        let data = try JSONEncoder().encode(user)
        UserDefaultsHelper.saveObject(objectToSave: data, forKey: Constants.UserDefaults.user)
    }
}
