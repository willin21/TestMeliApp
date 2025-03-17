import Foundation

extension Double {
    func toCOPCurrency() -> String? {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.locale = Locale(identifier: "es_CO") // Configuramos el formato para Colombia
        formatter.currencyCode = "COP" // Aseguramos el uso de pesos colombianos
        formatter.maximumFractionDigits = 0

        return formatter.string(from: NSNumber(value: self))
    }
}
