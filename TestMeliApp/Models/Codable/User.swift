
struct User: Codable {
    let id: Int
    let nickname: String
    let registrationDate: String
    let firstName: String
    let lastName: String
    let gender: String
    let countryID: String
    let email: String
    let points: Int
    let siteID: String
    
    init(id: Int, nickname: String, registrationDate: String, firstName: String, lastName: String, gender: String, countryID: String, email: String, points: Int, siteID: String) {
        self.id = id
        self.nickname = nickname
        self.registrationDate = registrationDate
        self.firstName = firstName
        self.lastName = lastName
        self.gender = gender
        self.countryID = countryID
        self.email = email
        self.points = points
        self.siteID = siteID
    }
}
