import Foundation

class CategoriesHelper {
    
    static let shared = CategoriesHelper()
    
    func getLocalCategories() -> Categories {
        guard let data = UserDefaultsHelper.getObject(forKey: Constants.UserDefaults.saveCategoryItems) else {
            return []
        }
        
        return (try? JSONDecoder().decode(Categories.self, from: data)) ?? []
    }
    
    func removeCategories() {
        UserDefaultsHelper.removeObject(forKey: Constants.UserDefaults.saveCategoryItems)
    }
    
    func save(_ items: Categories) throws {
        let categories = getLocalCategories()

        if !categories.isEmpty {
            removeCategories()
        }
        
        let data = try JSONEncoder().encode(items)
        UserDefaultsHelper.saveObject(objectToSave: data, forKey: Constants.UserDefaults.saveCategoryItems)
    }
}
