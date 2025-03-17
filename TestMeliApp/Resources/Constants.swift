import UIKit

struct Constants {
    struct Request {
        static let baseURL = "https://api.mercadolibre.com/"
        static let mlstaticURL = "https://http2.mlstatic.com/resources/"
    }
    
    struct Text {
        static let titleBar = "Mobile MeliApp"
        static let tryAgain = "Try again"
        static let done = "Done"
        static let addfavorites = "You have added this item to favorites succesfully"
        static let removefavorites = "You have removed this item from favorites succesfully"
        static let removedItem = "You have removed this item from the list succesfully"
        static let nonefavoriteItems = "You do not have any favorite items"
        static let noneItems = "You do not have items in list"
        static let errorFavorites = "Somthing is wrong, try again later"
        static let loading = "Loading..."
    }
    
    struct Image {
        static let defaultImage = "defaultImage"
        static let favoriteOff = "favoriteOff"
        static let favoriteOn = "favoriteOn"
    }
    
    struct UserDefaults {
        static let saveFavoriteItems = "saveFavoriteItems"
        static let localFavoriteItems = "localFavoriteItems"
        static let saveCategoryItems = "saveCategoryItems"
        static let accessToken = "accessToken"
        static let user = "user"
    }
}
