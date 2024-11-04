//
//  CartOfProductsView.swift
//  eCommerceApp
//
//  Created by Sarvar Qosimov on 13/01/24.
//

import SwiftUI

struct CartOfProductsView: View {
    @State var isPresented = false
    @State var deletingItemID = 0
    
    @Binding var backPressed: Bool

    @StateObject var updateMananger = UpdateMananger()

    @ObservedObject var cartViewModel = CartViewModel()

    @Environment(\.presentationMode) var presentationMode

    var body: some View {
        NavigationView {
            ZStack {
                Color.ColorByAppThemView(.white)
                    .ignoresSafeArea()
                
                VStack {
                    BackAndClearButtonView()
                    
                    if cartViewModel.savedFurnituries.isEmpty {
                        Image("yourCartIsEmpty")
                            .resizable()
                    }
                    
                    ZStack {
                        Color.ColorByAppThemView(.white)
                        
                        CartItemsListView()
                    }
                    
                    OrderButtonView()
                }
            }
            .ignoresSafeArea(edges: .bottom)
            .overlay(alignment: .center, content: {
                withAnimation(.smooth) {
                    CustomAlertView(isDismissed: $isPresented)
                        .opacity(isPresented ? 1 : 0)
                }
            })
        }
        
    }
    
    //MARK: - BackAndClearButton
    @ViewBuilder func BackAndClearButtonView() -> some View {
        HStack(alignment: .center) {
            Image("cartIcon")
                .resizable()
                .frame(width: 55, height: 55)
                .bold()
                .foregroundColor(Color.ColorByAppThemColor(.primaryOrSecondary))
            
            Text("Savatcha")
                .foregroundStyle(Color.ColorByAppThemColor(.primary))
                .font(.custom(Constants.mainFont, size: 21))
                .fontWeight(.semibold)
        }
        
        HStack {
            Button(action: {
                backPressed.toggle()
                updateMananger.shouldUpdate.toggle()
            }, label: {
                Image(systemName: "xmark")
                    .resizable()
                    .foregroundColor(Color.ColorByAppThemColor(.primary))
                    .bold()
                    .frame(width: 21, height: 21)
            })
            
            Spacer()
            
            Button(action: {
                cartViewModel.removeAllFromCart()
            }, label: {
                Text("Tozalash")
                    .foregroundStyle(.red)
                    .font(.custom(Constants.mainFont, size: 21))
                    .fontWeight(.semibold)
            })
        }
        .padding()
    }
      
    //MARK: - CartItemsListView
    @ViewBuilder func CartItemsListView() -> some View {
        ZStack {
            Color.ColorByAppThemView(.white)
                .ignoresSafeArea()
            
            ZStack {
                Color.ColorByAppThemView(.white)
                    .ignoresSafeArea()
                
                List(cartViewModel.savedFurnituries) { savedFurniture in
                    NavigationLink {
                        FurnitureDetailView(furniture: savedFurniture)
                    } label: {
                        SavedProductView(
                            deletingItemID: $deletingItemID,
                            savedProduct: savedFurniture,
                            isDeleteAble: true
                        )
                        .listRowBackground(Color.ColorByAppThemView(.white))
                    }
                }
                .listStyle(PlainListStyle())
                .listRowSpacing(5)
                .padding(.leading)
            }
            .task {
                cartViewModel.fetchSavedFurnitures()
            }
            .onChange(of: deletingItemID, perform: { value in
                cartViewModel.unsaveFurniture(ID: deletingItemID)
            })
        }
       
    }
    
    //MARK: - OrderButtonView
    @ViewBuilder func OrderButtonView() -> some View {
        VStack {
            HStack {
                Spacer()
                
                Text("Barchasi: \(cartViewModel.totalPrice) so`m")
                    .frame(alignment: .trailing)
                    .font(.custom(Constants.mainFont, size: 19))
                    .foregroundColor(Color.ColorByAppThemColor(.black))
            }
            .padding(.horizontal)
            
            HStack {
                Spacer()
                
                Text("Buyurtma berish")
                    .frame(height: 50)
                    .foregroundColor(Color.ColorByAppThemColor(.white))
                    .font(.custom(Constants.mainFont, size: 25))
                    .fontWeight(.semibold)
                
                Spacer()
            }
            .background(Color.ColorByAppThemColor(.primary))
            .cornerRadius(15)
            .padding()
            .padding(.trailing, 25)
            .overlay(alignment: .topTrailing) {
                ZStack {
                    Circle()
                        .fill(Color(Constants.kSecondary))
                        .frame(width: 33, height: 33)
                    
                    Text("\(cartViewModel.savedFurnituries.count)  ")
                        .bold()
                        .foregroundStyle(Color(Constants.kPrimary))
                }
                .offset(x: -23, y: 0)
            }
            .onTapGesture {
                isPresented = true
            }
        }
        .opacity(cartViewModel.savedFurnituries.count == 0 ? 0 : 1)
        .padding(.bottom)
    }
    
}

#Preview {
    CartOfProductsView(backPressed: .constant(true))
}
