//
//  SavedProductView.swift
//  eCommerceApp
//
//  Created by Sarvar Qosimov on 13/01/24.
//

import SwiftUI

struct SavedProductView: View {
    @Binding var deletingItemID: Int
    
    var savedProduct: Furniture
    var screenWidth = UIScreen.main.bounds.width
    var isDeleteAble: Bool = false
    
    var body: some View {
        ZStack {
            Color(Constants.kSecondary)
                .cornerRadius(15)
            
            HStack(spacing: 1) {
                FurnitureImageView()
                
                FurnitureInfoView()
                
                Spacer()
                
                if isDeleteAble {
                    DeleteButtonView()
                }
            }
            .cornerRadius(11)
            .frame(width: screenWidth-33, height: 115)
        }
        
    }
    
    //MARK: - FurnitureImageView
    @ViewBuilder func FurnitureImageView() -> some View {
        let url = URL(string: savedProduct.image)
        
        AsyncImage(url: url) { image in
            image
                .resizable()
                .frame(width: 100, height: 65)
                .cornerRadius(10)
                .padding(.leading, 11)
            
        } placeholder: {
            Image(systemName: "house")
        }
    }
    
    //MARK: - FurnitureInfoView
    @ViewBuilder func FurnitureInfoView() -> some View {
        VStack(alignment: .leading, spacing: 5) {
            Text(savedProduct.name)
                .font(.custom("Chalkboard SE Regular", size: 19))
                .foregroundColor(Color.black)
                .bold()
                .fixedSize(horizontal: false, vertical: true)
            
            Text(savedProduct.price.toString())
                .foregroundColor(Color.black)
                .bold()
                .font(.system(size: 17))
            
            + Text(" so`m")
                .foregroundColor(Color.black)
                .font(.system(size: 15))
            
            if isDeleteAble {
                HStack {
                    Spacer()
                    
                    Text(savedProduct.manufacture)
                        .foregroundStyle(.gray)
                    .font(.custom(Constants.mainFont, size: 15))
                }
                .padding(.top)
                .padding(.bottom)
            }
        }
        .padding()
        
    }
    
    //MARK: - DeleteButtonView
    @ViewBuilder func DeleteButtonView() -> some View {
        Image(systemName: "trash")
            .foregroundColor(.red)
            .padding(.trailing)
            .onTapGesture {
                DataMananger.shared.doUnsaved(savedProduct.id)
                deletingItemID = savedProduct.id
            }
    }
    
}

#Preview {
    SavedProductView(deletingItemID: .constant(0), savedProduct: furnitureForPreview, isDeleteAble: true)
}

