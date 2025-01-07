import SwiftUI
import UIKit
import FirebaseCore

class AppDelegate: NSObject, UIApplicationDelegate {
    
    // there are two didFinishLaunching we will take which return Bool value(all launch options)
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        FirebaseApp.configure()
        return true
    }
}

@main
struct FirebaseAuthenticationApp: App {
    // it is property wrapper you can use to use UIKit's AppDelegate into SwiftUI. Register app delegate for firebase setup.
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    @StateObject private var authViewModel = AuthViewModel()
    @ObservedObject private var router = Router()
    
    var body: some Scene {
        WindowGroup {
            
            NavigationStack(path: $router.navPath) {
                ContentView()
                    .navigationDestination(for: Router.AuthFlow.self) { destination in
                        
                        switch destination {
                            
                        case .createAccount: CreateAccountView()
                        case .emailSent: EmailSentView()
                        case .forgotPassword: ForgotPasswordView()
                        case .login: LoginView()
                        case .profile: ProfileView()
                                    
                        }
                    }
            }
            .environmentObject(authViewModel)
            .environmentObject(router)// we are passing value from here.
        }
    }
}
