

import SwiftUI
import Firebase
import FirebaseAuth

let screen = UIScreen.main.bounds
@main
struct FoodikalIOSApp: App {
    @UIApplicationDelegateAdaptor  private var appDelegate: AppDelegate
    
    var body: some Scene {
        WindowGroup {
            
            if let user = AuthService.shared.currentUser{
                
                if user.uid == "FvzHRWC9loMDkOXbE4MYc2UtFaJ2"{
                    
                    AdminOrdersView()
                    
                }else{
                    let viewModel = MainTabBarViewModel(user: user)
                    TabBar(viewModel: viewModel)
                }
                
            }else{
                AuthView()
            }
        }
    }
        class AppDelegate: NSObject, UIApplicationDelegate {
            
            func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
                FirebaseApp.configure()
                print("Ok")
                return true
            }
        }
    }


