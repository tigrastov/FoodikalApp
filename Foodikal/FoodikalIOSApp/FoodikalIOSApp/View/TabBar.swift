
import SwiftUI

struct TabBar: View {
    
    
    
    var viewModel: MainTabBarViewModel
    
    var body: some View {
        TabView{
            
           NavigationView{
                
                
                CatalogView()
           }
            .tabItem {
                Image("ButtonCatalogLitle").resizable().scaledToFill()
            }
            
            CartView(viewModel: CartViewModel.shared)
                .tabItem {
                    Image("ButtonCartLitle").resizable().scaledToFill()
                }
            
            ProfileView(viewModel: ProfileViewModel(profile: MVUser(id: "", name: "", phone: 0000000000, address: "")))
                .tabItem {
                    Image("ButtonProfileLitle").resizable().scaledToFill()
                        
                }
        }
    }
}

