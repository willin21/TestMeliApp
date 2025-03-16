import UserNotifications
import UIKit

class NotificationPermissionHelper {
    static let shared = NotificationPermissionHelper()
    
    private init() {} // Evitar múltiples instancias

    // Método para solicitar permisos de notificaciones
    func requestAuthorization(completion: @escaping (Bool) -> Void) {
        let notificationCenter = UNUserNotificationCenter.current()
        
        notificationCenter.requestAuthorization(options: [.alert, .sound, .badge]) { granted, error in
            if let error = error {
                print("Error al solicitar permisos de notificación: \(error.localizedDescription)")
                completion(false)
                return
            }
            completion(granted)
        }
    }

    // Método para verificar el estado actual de las notificaciones
    func getAuthorizationStatus(completion: @escaping (UNAuthorizationStatus) -> Void) {
        let notificationCenter = UNUserNotificationCenter.current()
        notificationCenter.getNotificationSettings { settings in
            completion(settings.authorizationStatus)
        }
    }
}
