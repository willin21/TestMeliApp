
import Foundation
@testable import TestMeliApp

class MockFavoritesHelper {
    var favorites: [Product] = []
    
    // Variables para verificar si los métodos fueron llamados
    var didCallGetFavorites = false
    var didCallDeleteProduct = false
    var lastDeletedIndex: Int?
    
    func getFavorites() -> [Product] {
        didCallGetFavorites = true
        return favorites
    }
    
    func deleteProducty(at index: Int) throws {
        didCallDeleteProduct = true
        lastDeletedIndex = index
        
        // Simular un error si el índice es inválido
        guard index >= 0 && index < favorites.count else {
            throw NSError(domain: "Invalid index", code: 1, userInfo: nil)
        }
        
        favorites.remove(at: index)
    }
}
