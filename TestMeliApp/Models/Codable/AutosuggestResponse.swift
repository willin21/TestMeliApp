// MARK: - Autosuggest
struct AutosuggestResponse: Codable {
    let query: String
    let suggestedQueries: [SuggestedQuery]?

    enum CodingKeys: String, CodingKey {
        case query = "q"
        case suggestedQueries = "suggested_queries"
    }
}

// MARK: - SuggestedQuery
struct SuggestedQuery: Codable {
    let name: String
    let matchStart: Int
    let matchEnd: Int
    let isVerifiedStore: Bool

    enum CodingKeys: String, CodingKey {
        case name = "q"
        case matchStart = "match_start"
        case matchEnd = "match_end"
        case isVerifiedStore = "is_verified_store"
    }
}
