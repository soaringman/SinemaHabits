import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?

    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        let controller = MainViewController()
        let navController = UINavigationController(rootViewController: controller)
        let window = UIWindow(frame: UIScreen.main.bounds)
        window.rootViewController = navController
        self.window = window
        window.makeKeyAndVisible()

        return true
    }
}
