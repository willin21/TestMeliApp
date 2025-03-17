extension String {
    /// Reemplaza "http://" con "https://" en el string actual
    func asSecureURL() -> String {
        return self.replacingOccurrences(of: "http://", with: "https://")
    }
}
