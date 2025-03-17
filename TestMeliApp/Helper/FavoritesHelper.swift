import UIKit

class FavoritesHelper {
    
    static let shared = FavoritesHelper()
    
    func getFavorites() -> [SearchProduct] {
        guard let data = UserDefaultsHelper.getObject(forKey: Constants.UserDefaults.saveFavoriteItems) else {
            return []
        }
        
        return (try? JSONDecoder().decode([SearchProduct].self, from: data)) ?? []
    }
    
    func removeAllFavorites() {
        UserDefaultsHelper.removeObject(forKey: Constants.UserDefaults.saveFavoriteItems)
    }
    
    func save(product: SearchProduct) throws {
        var products = getFavorites()

        if let index = products.firstIndex(of: product) {
            products.remove(at: index)
            products.insert(product, at: index)
        } else {
            products.append(product)
        }
        
        try save(products)
    }
    
    private func save(_ products: [SearchProduct]) throws {
        let data = try JSONEncoder().encode(products)
        UserDefaultsHelper.saveObject(objectToSave: data, forKey: Constants.UserDefaults.saveFavoriteItems)
    }
    
    func isSaved(product: SearchProduct) -> Bool {
        let products = getFavorites()
        
        if let _ = products.firstIndex(of: product) {
            return true
        }
        
        return false
    }
    
    func delete(at index: Int) throws {
        var products = getFavorites()
        products.remove(at: index)
        try save(products)
    }
}
