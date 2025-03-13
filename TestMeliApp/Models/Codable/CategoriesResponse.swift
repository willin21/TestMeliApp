import Foundation

typealias Categories = [CategoryResponse]

struct CategoryResponse: Codable {
    let id: String
    let name: String

    enum CodingKeys: String, CodingKey {
        case id
        case name
    }
}
