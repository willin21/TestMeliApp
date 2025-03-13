import Foundation

struct Product: Codable, Equatable {
    let id, title: String
    let condition: String
    let thumbnailID: String
    let listingTypeID: ListingTypeID?
    let sanitizedTitle: String
    let permalink: String
    let buyingMode: String
    let siteID: String?
    let categoryID: String?
    let domainID: String?
    let thumbnail: String
    let currencyID: String
    let orderBackend, price: Int
    let salePrice: SalePrice?
    let availableQuantity: Int
    let useThumbnailID, acceptsMercadopago: Bool
    let stopTime: String
    let seller: Seller?
    let address: Address
    let attributes: [ResultAttribute]?
    let installments: Installments?
    let catalogListing: Bool
    
    static func == (lhs: Product, rhs: Product) -> Bool {
        lhs.id == rhs.id && lhs.domainID == rhs.domainID
    }
}
