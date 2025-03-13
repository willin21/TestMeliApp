import XCTest
import RxSwift

@testable import TestMeliApp

class MockRepository: AppRepository {
    var shouldFail = false
    var searchProduct: [SearchProduct] = []
    var errorMessage: String = ""

    func getSearch() -> Observable<[SearchProduct]> {
        let response = searchProduct.map { product in
            SearchProduct(id: product.id, title: product.title, condition: product.condition, thumbnailID: product.thumbnailID, catalogProductID: product.categoryID, listingTypeID: product.listingTypeID, sanitizedTitle: product.sanitizedTitle, permalink: product.permalink, buyingMode: product.buyingMode, siteID: product.siteID, categoryID: product.categoryID, domainID: product.domainID, thumbnail: product.thumbnail, currencyID: product.currencyID, orderBackend: product.orderBackend, price: product.price, originalPrice: product.originalPrice, salePrice: product.salePrice, availableQuantity: product.availableQuantity, officialStoreID: product.officialStoreID, useThumbnailID: product.useThumbnailID, acceptsMercadopago: product.acceptsMercadopago, stopTime: product.stopTime, seller: product.seller, address: product.address, attributes: product.attributes, installments: product.installments, catalogListing: product.catalogListing, inventoryID: product.inventoryID, variationID: product.variationID, variationFilters: product.variationFilters, officialStoreName: product.officialStoreName)
        }
        
        return .just(response)
    }
}
