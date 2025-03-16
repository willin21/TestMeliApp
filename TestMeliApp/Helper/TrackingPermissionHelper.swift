import AppTrackingTransparency
import AdSupport

class TrackingPermissionHelper {
    static let shared = TrackingPermissionHelper()
    
    private init() {} // Privado para evitar instancias múltiples
    
    func requestTrackingPermission(completion: @escaping (ATTrackingManager.AuthorizationStatus) -> Void) {
        
        if #available(iOS 14, *) {
            ATTrackingManager.requestTrackingAuthorization { status in
                completion(status)
            }
        } else {
            // Manejo para versiones anteriores a iOS 14, si es necesario
            completion(.authorized) // Por defecto, asume autorizado si es compatible con versiones anteriores
        }
    }
}
