struct AutosuggestRequest: Codable {
    let showFilters: Bool
    let limit: Int
    let apiVersion: Int
    let query: String
    
    enum CodingKeys: String, CodingKey {
        case showFilters
        case limit
        case apiVersion = "api_version"
        case query = "q"
    }
}
