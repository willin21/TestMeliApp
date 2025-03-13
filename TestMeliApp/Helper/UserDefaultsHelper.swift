import Foundation

class UserDefaultsHelper{
    static func saveObject(objectToSave: Any, forKey key: String) {
        let defaults = UserDefaults.standard
        defaults.set(objectToSave, forKey: key)
    }
 
    static func getObject(forKey key: String) -> Data? {
        let defaults = UserDefaults.standard
        return defaults.data(forKey: key)
    }
    
    static func removeObject(forKey key: String) {
        let defaults = UserDefaults.standard
        defaults.removeObject(forKey: key)
    }
    
    
    static func getString(forKey key: String) -> String? {
        let defaults = UserDefaults.standard
        return defaults.string(forKey: key)
    }
    
    static func saveString(objectToSave: String, forKey key: String) {
        let defaults = UserDefaults.standard
        defaults.set(objectToSave, forKey: key)
    }
}
