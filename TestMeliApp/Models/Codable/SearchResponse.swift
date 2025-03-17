import Foundation

typealias Search = [SearchResponse]

struct SearchResponse: Codable {
    let siteID: String?
    let countryDefaultTimeZone: String?
    let query: String?
    let paging: Paging?
    let results: [SearchProduct]?
    let sort: Sort?
    let availableSorts: [Sort]?
    let filters: [Filter]?
    let availableFilters: [AvailableFilter]?
    let pdpTracking: PDPTracking?
    let rankingIntrospection: RankingIntrospection?

    enum CodingKeys: String, CodingKey {
        case siteID = "site_id"
        case countryDefaultTimeZone = "country_default_time_zone"
        case query, paging, results, sort
        case availableSorts = "available_sorts"
        case filters
        case availableFilters = "available_filters"
        case pdpTracking = "pdp_tracking"
        case rankingIntrospection = "ranking_introspection"
    }
}

// MARK: - AvailableFilter
struct AvailableFilter: Codable {
    let id, name: String?
    let type: String?
    let values: [AvailableFilterValue]?
}

// MARK: - AvailableFilterValue
struct AvailableFilterValue: Codable {
    let id, name: String
    let results: Int?
}

// MARK: - Sort
struct Sort: Codable {
    let id, name: String
}

// MARK: - Filter
struct Filter: Codable {
    let id, name: String
    let type: String
    let values: [FilterValue]?
}

// MARK: - FilterValue
struct FilterValue: Codable {
    let id: String?
    let name: String
    let pathFromRoot: [Sort]

    enum CodingKeys: String, CodingKey {
        case id, name
        case pathFromRoot = "path_from_root"
    }
}

// MARK: - Paging
struct Paging: Codable {
    let total, primaryResults, offset, limit: Int?

    enum CodingKeys: String, CodingKey {
        case total
        case primaryResults = "primary_results"
        case offset, limit
    }
}

// MARK: - PDPTracking
struct PDPTracking: Codable {
    let group: Bool
    let productInfo: [ProductInfo]

    enum CodingKeys: String, CodingKey {
        case group
        case productInfo = "product_info"
    }
}

// MARK: - ProductInfo
struct ProductInfo: Codable {
    let id: String
    let score: Int
    let status: String
}

// MARK: - RankingIntrospection
struct RankingIntrospection: Codable {
}

// MARK: - SearchProduct
struct SearchProduct: Codable, Equatable {
    let id: String?
    let title: String
    let condition: String
    let thumbnailID: String
    let catalogProductID: String?
    let listingTypeID: ListingTypeID?
    let sanitizedTitle: String
    let permalink: String
    let buyingMode: String
    let siteID: String?
    let categoryID: String?
    let domainID: String?
    let thumbnail: String
    let currencyID: String
    let orderBackend: Int
    let price: Double?
    let originalPrice: Double?
    let salePrice: SalePrice?
    let availableQuantity: Int
    let officialStoreID: Int?
    let useThumbnailID, acceptsMercadopago: Bool
    let stopTime: String
    let seller: Seller?
    let address: Address?
    let attributes: [ResultAttribute]?
    let installments: Installments?
    let catalogListing: Bool
    let inventoryID: String?
    let variationID: String?
    let variationFilters: [String]?
    let officialStoreName: String?

    enum CodingKeys: String, CodingKey {
        case id, title, condition
        case thumbnailID = "thumbnail_id"
        case catalogProductID = "catalog_product_id"
        case listingTypeID = "listing_type_id"
        case sanitizedTitle = "sanitized_title"
        case permalink
        case buyingMode = "buying_mode"
        case siteID = "site_id"
        case categoryID = "category_id"
        case domainID = "domain_id"
        case thumbnail
        case currencyID = "currency_id"
        case orderBackend = "order_backend"
        case price
        case originalPrice = "original_price"
        case salePrice = "sale_price"
        case availableQuantity = "available_quantity"
        case officialStoreID = "official_store_id"
        case useThumbnailID = "use_thumbnail_id"
        case acceptsMercadopago = "accepts_mercadopago"
        case stopTime = "stop_time"
        case seller, address, attributes, installments
        case catalogListing = "catalog_listing"
        case inventoryID = "inventory_id"
        case variationID = "variation_id"
        case variationFilters = "variation_filters"
        case officialStoreName = "official_store_name"
    }
    
    static func == (lhs: SearchProduct, rhs: SearchProduct) -> Bool {
        lhs.id == rhs.id && lhs.domainID == rhs.domainID
    }
}

// MARK: - Address
struct Address: Codable {
    let stateID: String
    let stateName: String
    let cityID, cityName: String

    enum CodingKeys: String, CodingKey {
        case stateID = "state_id"
        case stateName = "state_name"
        case cityID = "city_id"
        case cityName = "city_name"
    }
}

// MARK: - ResultAttribute
struct ResultAttribute: Codable {
    let id, name: String?
    let valueID: String?
    let valueName: String?
    let attributeGroupID: String?
    let attributeGroupName: String?
    let values: [AttributeValue]?
    let source: Int?
    let valueType: String?

    enum CodingKeys: String, CodingKey {
        case id, name
        case valueID = "value_id"
        case valueName = "value_name"
        case attributeGroupID = "attribute_group_id"
        case attributeGroupName = "attribute_group_name"
        case values, source
        case valueType = "value_type"
    }
}

// MARK: - AttributeValue
struct AttributeValue: Codable {
    let id: String?
    let name: String?
    let source: Int?

    enum CodingKeys: String, CodingKey {
        case id, name
        case source
    }
}

// MARK: - Installments
struct Installments: Codable {
    let quantity, amount, rate: Int
    let currencyID: String
    let metadata: InstallmentsMetadata?

    enum CodingKeys: String, CodingKey {
        case quantity, amount, rate
        case currencyID = "currency_id"
        case metadata
    }
}

// MARK: - InstallmentsMetadata
struct InstallmentsMetadata: Codable {
    let meliplusInstallments, additionalBankInterest: Bool

    enum CodingKeys: String, CodingKey {
        case meliplusInstallments = "meliplus_installments"
        case additionalBankInterest = "additional_bank_interest"
    }
}

enum ListingTypeID: String, Codable {
    case goldPro = "gold_pro"
    case goldSpecial = "gold_special"
}

// MARK: - SalePrice
struct SalePrice: Codable {
    let priceID: String?
    let amount: Double?
    let conditions: Conditions?
    let currencyID: String?
    let paymentMethodType: String?
    let regularAmount: Double?
    let type: String?

    enum CodingKeys: String, CodingKey {
        case priceID = "price_id"
        case amount, conditions
        case currencyID = "currency_id"
        case paymentMethodType = "payment_method_type"
        case regularAmount = "regular_amount"
        case type
    }
}

// MARK: - Conditions
struct Conditions: Codable {
    let eligible: Bool?
    let contextRestrictions: [String]?

    enum CodingKeys: String, CodingKey {
        case eligible
        case contextRestrictions = "context_restrictions"
    }
}

// MARK: - SalePriceMetadata
struct SalePriceMetadata: Codable {
    let experimentID, promotionID, promotionType, fundingMode: String?
    let orderItemPrice: Double?
    let promotionOfferType: String?
    let campaignDiscountPercentage: Double?
    let campaignID: String?
    let discountMeliAmount: Int?
    let promotionOfferSubType, variation: String?
    let campaignEndDate: Date?
    let referencePriceType: String?

    enum CodingKeys: String, CodingKey {
        case experimentID = "experiment_id"
        case promotionID = "promotion_id"
        case promotionType = "promotion_type"
        case fundingMode = "funding_mode"
        case orderItemPrice = "order_item_price"
        case promotionOfferType = "promotion_offer_type"
        case campaignDiscountPercentage = "campaign_discount_percentage"
        case campaignID = "campaign_id"
        case discountMeliAmount = "discount_meli_amount"
        case promotionOfferSubType = "promotion_offer_sub_type"
        case variation
        case campaignEndDate = "campaign_end_date"
        case referencePriceType = "reference_price_type"
    }
}

// MARK: - Seller
struct Seller: Codable {
    let id: Int?
    let nickname: String
}

enum LogisticType: String, Codable {
    case crossDocking = "cross_docking"
    case fulfillment = "fulfillment"
    case xdDropOff = "xd_drop_off"
}

enum Tag: String, Codable {
    case fulfillment = "fulfillment"
    case mandatoryFreeShipping = "mandatory_free_shipping"
    case selfServiceIn = "self_service_in"
}

// MARK: - VariationsDatum
struct VariationsDatum: Codable {
    let thumbnail: String
    let ratio, name: String
    let picturesQty: Int
    let price: Double?
    let userProductID: String
    let attributes: [VariationsDatumAttribute]?
    let attributeCombinations: [AttributeCombination]?

    enum CodingKeys: String, CodingKey {
        case thumbnail, ratio, name
        case picturesQty = "pictures_qty"
        case price
        case userProductID = "user_product_id"
        case attributes
        case attributeCombinations = "attribute_combinations"
    }
}

// MARK: - AttributeCombination
struct AttributeCombination: Codable {
    let id: String?
    let name: String
    let valueID: String?
    let valueName: String?

    enum CodingKeys: String, CodingKey {
        case id, name
        case valueID = "value_id"
        case valueName = "value_name"
    }
}

// MARK: - VariationsDatumAttribute
struct VariationsDatumAttribute: Codable {
    let id, name: String?
    let valueName: String?
    let valueType: String?

    enum CodingKeys: String, CodingKey {
        case id, name
        case valueName = "value_name"
        case valueType = "value_type"
    }
}
