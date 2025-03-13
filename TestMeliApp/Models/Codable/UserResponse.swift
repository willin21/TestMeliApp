import Foundation

struct UserResponse: Codable {
    let id: Int
    let nickname, registrationDate, firstName, lastName: String
    let gender, countryID, email: String
    let phone: Phone
    let alternativePhone: AlternativePhone
    let userType: String
    let tags: [String]
    let points: Int
    let siteID: String
    let permalink: String
    let sellerExperience: String
    let sellerReputation: SellerReputation
    let buyerReputation: BuyerReputation
    let status: Status
    let secureEmail: String
    let company: Company
    let credit: Credit
    let context: Context
    let registrationIdentifiers: [RegistrationIdentifier]

    enum CodingKeys: String, CodingKey {
        case id
        case nickname
        case registrationDate = "registration_date"
        case firstName = "first_name"
        case lastName = "last_name"
        case gender
        case countryID = "country_id"
        case email, phone
        case alternativePhone = "alternative_phone"
        case userType = "user_type"
        case tags, points
        case siteID = "site_id"
        case permalink
        case sellerExperience = "seller_experience"
        case sellerReputation = "seller_reputation"
        case buyerReputation = "buyer_reputation"
        case status
        case secureEmail = "secure_email"
        case company, credit, context
        case registrationIdentifiers = "registration_identifiers"
    }
}

// MARK: - AlternativePhone
struct AlternativePhone: Codable {
    let areaCode, alternativePhoneExtension, number: String

    enum CodingKeys: String, CodingKey {
        case areaCode = "area_code"
        case alternativePhoneExtension = "extension"
        case number
    }
}

// MARK: - BuyerReputation
struct BuyerReputation: Codable {
    let canceledTransactions: Int
    let transactions: BuyerReputationTransactions

    enum CodingKeys: String, CodingKey {
        case canceledTransactions = "canceled_transactions"
        case transactions
    }
}

// MARK: - BuyerReputationTransactions
struct BuyerReputationTransactions: Codable {
    let period: String

    enum CodingKeys: String, CodingKey {
        case period
    }
}

// MARK: - Company
struct Company: Codable {
    let cityTaxID, corporateName, identification, stateTaxID: String
    let custTypeID: String

    enum CodingKeys: String, CodingKey {
        case cityTaxID = "city_tax_id"
        case corporateName = "corporate_name"
        case identification
        case stateTaxID = "state_tax_id"
        case custTypeID = "cust_type_id"
    }
}

// MARK: - Context
struct Context: Codable {
    let device, flow, ipAddress, source: String

    enum CodingKeys: String, CodingKey {
        case device, flow
        case ipAddress = "ip_address"
        case source
    }
}

// MARK: - Credit
struct Credit: Codable {
    let consumed: Int
    let creditLevelID, rank: String

    enum CodingKeys: String, CodingKey {
        case consumed
        case creditLevelID = "credit_level_id"
        case rank
    }
}

// MARK: - Phone
struct Phone: Codable {
    let areaCode, number: String

    enum CodingKeys: String, CodingKey {
        case areaCode = "area_code"
        case number
    }
}

// MARK: - RegistrationIdentifier
struct RegistrationIdentifier: Codable {
    let userIdentifier: String
    let creationDate, lastUpdated: String
    let metadata: Metadata

    enum CodingKeys: String, CodingKey {
        case userIdentifier = "user_identifier"
        case creationDate = "creation_date"
        case lastUpdated = "last_updated"
        case metadata
    }
}

// MARK: - Metadata
struct Metadata: Codable {
    let countryCode, number: String

    enum CodingKeys: String, CodingKey {
        case countryCode = "country_code"
        case number
    }
}

// MARK: - SellerReputation
struct SellerReputation: Codable {
    let transactions: SellerReputationTransactions
    let metrics: Metrics

    enum CodingKeys: String, CodingKey {
        case transactions
        case metrics
    }
}

// MARK: - Metrics
struct Metrics: Codable {
    let sales: Sales
    let claims, delayedHandlingTime, cancellations: Cancellations

    enum CodingKeys: String, CodingKey {
        case sales, claims
        case delayedHandlingTime = "delayed_handling_time"
        case cancellations
    }
}

// MARK: - Cancellations
struct Cancellations: Codable {
    let period: String
    let rate, value: Int
}

// MARK: - Sales
struct Sales: Codable {
    let period: String
    let completed: Int
}

// MARK: - SellerReputationTransactions
struct SellerReputationTransactions: Codable {
    let canceled, completed: Int
    let period: String
    let ratings: Ratings
    let total: Int
}

// MARK: - Ratings
struct Ratings: Codable {
    let negative, neutral, positive: Int
}

// MARK: - Status
struct Status: Codable {
    let billing: Billing
    let buy: Buy
    let confirmedEmail: Bool
    let shoppingCart: ShoppingCart
    let immediatePayment: Bool
    let list: Buy
    let mercadoenvios, mercadopagoAccountType: String
    let mercadopagoTcAccepted: Bool
    let requiredAction: String
    let sell: Buy
    let siteStatus: String

    enum CodingKeys: String, CodingKey {
        case billing, buy
        case confirmedEmail = "confirmed_email"
        case shoppingCart = "shopping_cart"
        case immediatePayment = "immediate_payment"
        case list, mercadoenvios
        case mercadopagoAccountType = "mercadopago_account_type"
        case mercadopagoTcAccepted = "mercadopago_tc_accepted"
        case requiredAction = "required_action"
        case sell
        case siteStatus = "site_status"
    }
}

// MARK: - Billing
struct Billing: Codable {
    let allow: Bool
    let codes: [String]
}

// MARK: - Buy
struct Buy: Codable {
    let allow: Bool
    let codes: [String]
    let immediatePayment: ImmediatePayment

    enum CodingKeys: String, CodingKey {
        case allow, codes
        case immediatePayment = "immediate_payment"
    }
}

// MARK: - ImmediatePayment
struct ImmediatePayment: Codable {
    let immediatePaymentRequired: Bool

    enum CodingKeys: String, CodingKey {
        case immediatePaymentRequired = "required"
    }
}

// MARK: - ShoppingCart
struct ShoppingCart: Codable {
    let buy, sell: String
}

