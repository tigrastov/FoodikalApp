

import SwiftUI

struct ProfileView: View {
    
    enum Interaction: Hashable{
        case first, second, third
    }
    @FocusState private var focus: Interaction?
    
    @State private var isQuitAlertPresented = false
    @State private var isAuthViewPresented = false
    @State private var usersOrderShow = false
    @StateObject var viewModel: ProfileViewModel
    @StateObject var viewModelForOrders = AdminOrdersViewModel()
    
    var body: some View {
        
        VStack{
            
            HStack{
                Text("Profile").bold().font(.system(size: 40)).foregroundStyle(Color.white)
                Spacer()
            }
                 .padding()
              .frame(height: 80)
                
            
            HStack{
                Image("NameImg").padding()
                
                TextField("Name - MustHave", text: $viewModel.profile.name).focused($focus, equals: .first).font(.system(size: 16)).foregroundStyle(Color.black).padding().background(Color("ProfileColor")).frame(height: 40).cornerRadius(25)
                
                
                Button {
                    isQuitAlertPresented.toggle()
                } label: {
                    Image("ExitCirc")
                }.padding()
                
                    .confirmationDialog(Text("Do you really want to leave?"), isPresented: $isQuitAlertPresented) {
                        Button {
                            isAuthViewPresented.toggle()
                        } label: {
                            Text("Yes")
                        }
                    }
                    .fullScreenCover(isPresented: $isAuthViewPresented, onDismiss: nil) {
                        AuthView()
                    }
            }
            .frame(height: 80)
            
            HStack{
                Image("AdressImg").padding()
                
                TextField("Adress - MustHave!", text: $viewModel.profile.address).focused($focus, equals: .second).font(.system(size: 16)).foregroundStyle(Color.black).padding().background(Color("ProfileColor")).frame(height: 40).cornerRadius(25)
            }
            .padding(.trailing, 10)
            .frame(height: 80)
            
            HStack{
                Image("PhoneImg").padding()
                
                TextField("Phone - MustHave", value: $viewModel.profile.phone, format: .number).keyboardType(.asciiCapableNumberPad).focused($focus, equals: .third).font(.system(size: 16)).foregroundStyle(Color.black).foregroundStyle(Color.black).padding().background(Color("ProfileColor")).frame(height: 40).cornerRadius(25)
                
                Button {
                    print("save")
                    
                    viewModel.setProfile()
                } label: {
                    
                    Image("ButtonSave")
                    
                }.padding()
                
            }
            .frame(height: 80)
            
            List{
                if viewModel.orders.count == 0{
                    Text("Your orders will be here").font(.system(size: 16))
                }else{
                    ForEach(viewModel.orders, id: \.id) { order in
                        
                        OrderCell(order: order)
                        
                            .onTapGesture {
                                viewModelForOrders.currentOrder = order
                                usersOrderShow.toggle()
                            }
                    }
                }
                
            }
            .listStyle(.plain).frame(maxHeight: 200).padding(.bottom, 20).padding(.top, 20).cornerRadius(25)
            
            
        }
        
        .frame(width: screen.width, height: screen.height).ignoresSafeArea()
       
        .background(Image("BackProfile").resizable().scaledToFill().ignoresSafeArea())
        
        .onSubmit {
            viewModel.setProfile()
            print("on submit")
        }
        .onAppear {
            viewModel.getProfile()
            viewModel.getOrders()
            viewModelForOrders.getOrders()
        
        }.onTapGesture {
            focus = nil
        }
                     
    }
       
    }

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView(viewModel: ProfileViewModel(profile: MVUser(id: "", name: "Ivan", phone: 35512556645, address: "anyWhere")))
            
    }
}
