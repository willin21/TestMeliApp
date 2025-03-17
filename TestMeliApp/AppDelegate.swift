import UIKit
import CocoaLumberjack
import SDWebImage

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        setupLogger()
        verifyTrackingPermissions()
        verifyNotificationPermissions()
        cleanSDImageCache()

        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }

    private func setupLogger() {
        DDLog.add(DDOSLogger.sharedInstance) // Usa el logger de OS
        DDLogInfo("CocoaLumberjack configurado correctamente")
    }
    
    private func verifyTrackingPermissions() {
        // Verificar y solicitar permisos de tracking
        TrackingPermissionHelper.shared.requestTrackingPermission { status in
            switch status {
            case .authorized:
                DDLogInfo("Tracking - Permiso concedido")
            case .denied:
                DDLogInfo("Tracking - Permiso denegado")
            case .notDetermined:
                DDLogInfo("Tracking - El usuario aún no ha tomado una decisión")
            case .restricted:
                DDLogInfo("Tracking - El permiso está restringido")
            @unknown default:
                DDLogInfo("Tracking - Estado desconocido")
            }
        }
    }
    
    private func verifyNotificationPermissions() {
        // Verificar y solicitar permisos de notificación
        NotificationPermissionHelper.shared.getAuthorizationStatus { status in
            DispatchQueue.main.async {
                switch status {
                case .notDetermined:
                    // El usuario aún no ha tomado una decisión, se solicita el permiso
                    NotificationPermissionHelper.shared.requestAuthorization { granted in
                        if granted {
                            DDLogInfo("Permiso concedido")
                        } else {
                            DDLogInfo("Permiso denegado")
                        }
                    }
                case .authorized:
                    DDLogInfo("Permiso ya concedido")
                case .denied:
                    DDLogInfo("Permiso denegado, sugerir ir a Configuración")
                case .provisional:
                    DDLogInfo("Permiso provisional concedido (solo notificaciones no intrusivas)")
                case .ephemeral:
                    DDLogInfo("Permiso efímero concedido (solo en apps webclip)")
                @unknown default:
                    DDLogInfo("Estado desconocido")
                }
            }
        }
    }
    
    private func cleanSDImageCache() {
        SDImageCache.shared.clearMemory()
        SDImageCache.shared.clearDisk(onCompletion: nil)
        SDWebImageManager.shared.removeAllFailedURLs()
    }
}

