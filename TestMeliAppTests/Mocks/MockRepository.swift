import XCTest
import RxSwift
import CocoaLumberjack

@testable import TestMeliApp

class MockRepository: AppRepository {
    var shouldFail = false
    var errorMessage: String = ""\
    var mockSearchProduct: Observable<SearchResponse>?
    var mockAutosuggestResult: Observable<AutosuggestResponse>?

    func getSearch() -> Observable<[SearchProduct]> {
        let response = searchProduct.map { product in
            SearchProduct(id: product.id, title: product.title, condition: product.condition, thumbnailID: product.thumbnailID, catalogProductID: product.categoryID, listingTypeID: product.listingTypeID, sanitizedTitle: product.sanitizedTitle, permalink: product.permalink, buyingMode: product.buyingMode, siteID: product.siteID, categoryID: product.categoryID, domainID: product.domainID, thumbnail: product.thumbnail, currencyID: product.currencyID, orderBackend: product.orderBackend, price: product.price, originalPrice: product.originalPrice, salePrice: product.salePrice, availableQuantity: product.availableQuantity, officialStoreID: product.officialStoreID, useThumbnailID: product.useThumbnailID, acceptsMercadopago: product.acceptsMercadopago, stopTime: product.stopTime, seller: product.seller, address: product.address, attributes: product.attributes, installments: product.installments, catalogListing: product.catalogListing, inventoryID: product.inventoryID, variationID: product.variationID, variationFilters: product.variationFilters, officialStoreName: product.officialStoreName)
        }
        
        return .just(response)
    }
    
    func getMockSearch(query: String) -> SearchResponse? {
        guard let response = parseMockResponse() else {
            DDLogInfo("MockError")
            return nil
        }
        
        return response
    }
    
    override func getAutosuggest(autoSuggestRequest: AutosuggestRequest) -> Observable<AutosuggestResponse> {
        return mockAutosuggestResult ?? .error(NSError(domain: "MockError", code: -1, userInfo: nil))
    }
    
    func parseMockResponse() -> SearchResponse? {
        guard let data = loadMockResponse(fileName: "search") else { return nil }
        
        let decoder = JSONDecoder()
        return try? decoder.decode(SearchResponse.self, from: data)
    }
    
    func loadMockResponse(fileName: String) -> Data? {
        if let url = Bundle(for: type(of: self)).url(forResource: fileName, withExtension: "json") {
            return try? Data(contentsOf: url)
        }
        
        return nil
    }
}
