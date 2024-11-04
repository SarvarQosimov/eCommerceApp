//
//  FurnitureDetailView.swift
//  eCommerceApp
//
//  Created by Sarvar Qosimov on 22/01/24.
//

import SwiftUI

struct FurnitureDetailView: View {
    @State var countOfProduct = 1
    
    var furniture: Furniture
    
    var body: some View {
        ZStack(alignment: .topLeading) {
            Color.ColorByAppThemView(.white)
                .ignoresSafeArea()
            
            VStack {
//                CustomBackButtonView(navigationTitle: "Batafsil")
                
                ScrollView(showsIndicators: false) {
                    VStack(alignment: .leading) {
                        FurnitureImageView()
                        
                        VStack {
                            MainInfoView()
                            
                            AdditionalInfoView()
                            
                            Spacer()
                            
                            AddToCartButton()
                        }
                        .background(Color.ColorByAppThemView(.white))
                        //TODO: why we need .cornerRadius(20)
                        .cornerRadius(20)
                        .offset(y: -30)
                    }
                }
            }
        }
        .navigationBarBackButtonHidden(true)
        .navigationBarItems(leading: CustomBackButtonView(navigationTitle: "Batafsil")
            .navigationBarTitle("")
)
    }
    
    //MARK: - FurnitureImageView
    @ViewBuilder func FurnitureImageView() -> some View {
        ZStack(alignment: .topTrailing) {
            let url = URL(string: furniture.image)
            
            AsyncImage(url: url) { image in
                image
                    .resizable()
                    .ignoresSafeArea(edges: .top)
                    .frame(height: 250)
            } placeholder: { } //TODO: put defalut image
        }
    }
    
    //MARK: - MainInfoView
    @ViewBuilder func MainInfoView() -> some View {
        VStack {
            HStack {
                Text(furniture.name)
                    .font(.title2)
                    .bold()
                    .foregroundColor(Color.ColorByAppThemColor(.black))
                    .padding()
                
                Spacer()
                
                Text("  \(furniture.price)  ")
                    .font(.title3)
                    .fontWeight(.semibold)
                    .bold()
                    .background(Color(Constants.kSecondary))
                    .cornerRadius(7)
                    .padding(.horizontal)
            }
            
            HStack() {
                Spacer()
                
                Button {
                    if countOfProduct != 1 { countOfProduct -= 1 }
                } label: {
                    Image(systemName: "minus.square")
                        .resizable()
                        .foregroundColor(Color.ColorByAppThemColor(.primary))
                        .frame(width: 25, height: 25)
                }
                
                Text("\(countOfProduct)")
                    .font(.title2)
                    .foregroundColor(Color.ColorByAppThemColor(.primary))
                    .bold()
                
                Button {
                    countOfProduct += 1
                } label: {
                    Image(systemName: "plus.square.fill")
                        .resizable()
                        .foregroundColor(Color.ColorByAppThemColor(.primary))
                        .frame(width: 25, height: 25)
                }.padding(.trailing)
            }
        }
    }
    
    //MARK: - AdditionalInfoView
    @ViewBuilder func AdditionalInfoView() -> some View {
        VStack {
            VStack {
                Text("Tafsilotlar")
                    .font(.title2)
                    .foregroundColor(Color.ColorByAppThemColor(.black))
                    .bold()
                    .padding(.bottom, 1)
                
                Text(furniture.description)
                    .fontWeight(.medium)
                    .foregroundColor(Color.ColorByAppThemColor(.black))
                    .padding()
            }
            
            HStack(alignment: .top) {
                VStack(alignment: .leading) {
                    Text("O`lchamlari")
                        .font(.title2)
                        .foregroundColor(Color.ColorByAppThemColor(.black))
                        .bold()
                    
                    Text("Balandlik: \(furniture.height)")
                        .font(.title3)
                        .foregroundColor(.gray)
                    
                    Text("Uzunlik: \(furniture.length)")
                        .font(.title3)
                        .foregroundColor(.gray)
                    
                    Text("Eni: \(furniture.width)")
                        .font(.title3)
                        .foregroundColor(.gray)
                }
                
                Spacer()
                
                VStack {
                    Text("Ranglari")
                        .font(.title2)
                        .foregroundColor(Color.ColorByAppThemColor(.black))
                        .bold()
                    
                    HStack {
                        Circle()
                            .foregroundColor(Color.init(hex: furniture.colors[0]))
                            .frame(width: 25, height: 25)
                        
                        Circle()
                            .foregroundColor(Color.init(hex: furniture.colors[1]))
                            .frame(width: 25, height: 25)
                    }
                }
            }.padding(.horizontal)
        }
    }
    
    //MARK: - AddToCartButton
    @ViewBuilder func AddToCartButton() -> some View {
        HStack {
            Button(action: {
                DataMananger.shared.doSaved(furniture.id)
            }, label: {
                AddToCardButtonView()
            })
            
            Spacer()
            
            VStack(alignment: .trailing) {
                Text("\(furniture.price * countOfProduct)")
                    .font(.title3)
                    .foregroundColor(Color.ColorByAppThemColor(.black))
                    .bold()
                
                Text("so`m")
                    .foregroundColor(Color.ColorByAppThemColor(.primary))
                    .frame(alignment: .trailing)
                    .fontWeight(.semibold)
                
            }.padding()
        }
    }
}

#Preview {
    FurnitureDetailView(furniture: furnitureForPreview)
}

//MARK: - AddToCardButtonView
struct AddToCardButtonView: View {
    var body: some View {
        HStack {
            Image(systemName: "cart.fill.badge.plus")
                .resizable()
                .foregroundColor(Color.ColorByAppThemColor(.white))
                .frame(width: 25, height: 25)
                .padding(.vertical)
                .padding(.leading)
            
            Text("Savatga qo`shish")
                .foregroundColor(Color.ColorByAppThemColor(.white))
                .font(.custom(Constants.mainFont, size: 17))
                .bold()
                .padding(.trailing)
        }
        .background(Color.ColorByAppThemColor(.primary))
        .cornerRadius(15) //TODO: use clipShape
        .padding(.leading, 5)
    }
}


