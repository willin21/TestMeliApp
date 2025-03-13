import Foundation

struct Preferences {
    private static var secrets: [String: String] = {
        var propertyListFormat = PropertyListSerialization.PropertyListFormat.xml
        let plistPath = Bundle.main.path(forResource: "Secrets", ofType: "plist")!
        let plistXML = FileManager.default.contents(atPath: plistPath)!
        let dict = try? PropertyListSerialization.propertyList(from: plistXML,
                                                               options: .mutableContainersAndLeaves,
                                                               format: &propertyListFormat)
        return dict as! [String: String]
    }()
    
    static let refreshToken: String = secrets["RefreshToken"]!
    static let clientId: String = secrets["ClientId"]!
    static let clientSecret: String = secrets["ClientSecret"]!
}
