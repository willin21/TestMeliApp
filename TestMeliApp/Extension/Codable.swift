import Foundation

extension Decodable {
    
    static func toModel<T: Decodable>(data: Data) throws -> T {
        do {
            if T.self is String.Type {
                let str = String(decoding: data, as: UTF8.self)
                return str as! T
            } else {
                let decoder = JSONDecoder()
                let model = try decoder.decode(T.self, from: data)
                return model
            }
        } catch let error {
          print("toModel failed. Error: `\(error)`")
          throw error
        }
    }
    
}

extension Encodable {
    func toDictionary() -> [String: Any]? {
        do {
            let jsonData = try JSONEncoder().encode(self)
            let dictionary = try JSONSerialization.jsonObject(with: jsonData, options: []) as? [String: Any]
            return dictionary
        } catch {
            print("Error al convertir el objeto a diccionario: \(error)")
            return nil
        }
    }
}
