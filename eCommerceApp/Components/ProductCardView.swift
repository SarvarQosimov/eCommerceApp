//
//  ProductCardView.swift
//  eCommerceApp
//
//  Created by Sarvar Qosimov on 29/12/23.
//

import SwiftUI

struct ProductCardView: View {
    var currentFurniture: Furniture
    
    var body: some View {
        ZStack {
            Color(Constants.kSecondary)
            
            ZStack(alignment: .bottomTrailing) {
                VStack(alignment: .leading) {
                    FurnitureImageView()
                    
                    FurnitureInfoView()
                    
                    Spacer()
                }
                .padding(.leading)
                
                PlusButtonView()
            }
        }
        .frame(width: 175, height: 275)
        .cornerRadius(15)
    }
    
    //MARK: - FurnitureImageView
    @ViewBuilder func FurnitureImageView() -> some View {
        let url = URL(string: currentFurniture.image)
        
        AsyncImage(url: url) { image in
            image
                .resizable()
                .frame(width: 165, height: 145)
                .cornerRadius(12)
                .padding(.top, 5)
                .padding(.trailing)
            
        } placeholder: {
            Image(systemName: "house")
        }
    }
    
    //MARK: - FurnitureInfoView
    @ViewBuilder func FurnitureInfoView() -> some View {
        Text(currentFurniture.name)
            .font(.headline .bold())
            .foregroundStyle(Color(Constants.kPrimary))
            .padding(.vertical, 1)
            .fixedSize(horizontal: false, vertical: true)
        
        Text(currentFurniture.category)
            .foregroundColor(.gray)
            .padding(.vertical, 0.5)
        
        Text("\(currentFurniture.price)")
            .foregroundStyle(Color(Constants.kPrimary))
            .bold()
    }
    
    //MARK: - PlusButtonView
    @ViewBuilder func PlusButtonView() -> some View {
        Button {
            DataMananger.shared.doSaved(currentFurniture.id)
        } label: {
            Image(systemName: "plus.circle.fill")
                .resizable()
                .foregroundColor(Color(Constants.kPrimary))
                .frame(width: 25, height: 25)
                .padding(.trailing)
                .padding(.bottom, 5)
        }
    }
}

struct ProductCardView_Previews: PreviewProvider {
    static var previews: some View {
        ProductCardView(currentFurniture: furnitureForPreview
        )
    }
}
