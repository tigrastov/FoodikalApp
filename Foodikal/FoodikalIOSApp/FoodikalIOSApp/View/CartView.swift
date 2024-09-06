
import SwiftUI

struct CartView: View {
    
   @StateObject var viewModel: CartViewModel
    
    @State private var isShowAlertAboutOrderSent =  false
    @State private var isShowDialogOrder = false
    @State private var isShowAlertAboutEmptyOrder = false
    
    var body: some View {
        
            VStack {
               
                VStack {
                    Text("Cart").bold().font(.system(size: 40)).foregroundStyle(Color.black).padding()
                    List(viewModel.positions){ position in
                       
                            PositionCell(position: position)
                                .swipeActions {
                                    Button {
                                        viewModel.positions.removeAll { pos in
                                            pos.id == position.id
                                        }
                                    } label: {
                                        Text("Delete")
                                    }.background(Color.red)
                                }
                       
                    }.listStyle(.plain)
                        .navigationTitle("Корзина")
                }.background(GlassView(removeEffects: false)).cornerRadius(20).shadow(radius: 20).padding().padding(.top, 10)
                    .frame(height: screen.height / 2)
                
                Image("Wallet")
                    .overlay {
                        HStack{
                            Spacer()
                            Text("\(viewModel.cost) din").fontWeight(.bold).padding()
                    }
                }.padding()
            
                HStack(spacing: 30){
                    Button {
                        viewModel.positions.removeAll()
                        print("Очистить корзину")
                    } label: {
                        Image("ClearCartButton")
                    }
                        
                    Button {
                        print("Заказать")
                        isShowDialogOrder.toggle()
                        
                       
                    } label: {
                        Image("AddOrderButton")
                    }
                    .confirmationDialog("Do you want sent an order?", isPresented: $isShowDialogOrder) {
                        
                        Button {
                            
                            if viewModel.positions.count != 0{
                                print("sent an order")
                                
                                isShowAlertAboutOrderSent.toggle()
                                
                                var order = Order(userID: AuthService.shared.currentUser!.uid,
                                                  date: Date(),
                                                  status: OrderStatus.new.rawValue)
                                order.positions = self.viewModel.positions
                                
                                DatabaseService.shared.setOrder(order: order) { result in
                                    switch result{
                                        
                                    case .success(let order):
                                        print(order.cost)
                                    case .failure(let error):
                                        print(error.localizedDescription)
                                    }
                                }
                                viewModel.positions.removeAll()
                                
                            } else{
                                isShowAlertAboutEmptyOrder.toggle()
                            }
                            
                        } label: {
                            Text("Yes")
                        }
                       
                    }
                    .alert(Text("Order is accepted / Ваш заказ принят!"), isPresented: $isShowAlertAboutOrderSent) {
                    } message: {
                        Text("The administrator will call you to clarify delivery details to the number specified in your profile / Администратор позвонит вам для уточнения деталей доставки на указанный в профиле номер")
                    }
                    .alert(Text("Error: empty order"), isPresented: $isShowAlertAboutEmptyOrder) {
                    } message: {
                       Text("The order cannot be empty")
                    }
                    
                   
                }.padding()
                    .padding(.bottom, 80)
                    
            }
            .frame(width: screen.width, height: screen.height).ignoresSafeArea()
            
            .background(Image("GrayRed").resizable().scaledToFill().ignoresSafeArea())
               
    }
}

struct CartView_Previews: PreviewProvider {
    static var previews: some View {
        CartView(viewModel: CartViewModel.shared)
            
    }
}

