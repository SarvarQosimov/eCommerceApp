//
//  CustomMiniSheet.swift
//  eCommerceApp
//
//  Created by Sarvar Qosimov on 06/02/24.
//

import SwiftUI

class CustomMiniSheetButton: Identifiable {
    var buttonImage: String
    var buttonTitle: String
    var isSelected: Bool
    var action: (() -> Void )
    
    init(buttonImage: String, buttonTitle: String, isSelected: Bool = false, action: @escaping () -> Void) {
        self.buttonImage = buttonImage
        self.buttonTitle = buttonTitle
        self.isSelected = isSelected
        self.action = action
    }
    
}

struct CustomMiniSheet: View {
    let title: String
    var buttons: [CustomMiniSheetButton]
    
    @Binding var isDismissed: Bool
    
    var body: some View {
        ZStack {
            Color.ColorByAppThemView(.white)
                .ignoresSafeArea()
            
            VStack {
                
                Capsule()
                    .frame(width: 41, height: 7)
                    .foregroundStyle(Color.ColorByAppThemColor(.primary))
                    .padding(.top)
                
                Text(title)
                    .foregroundStyle(Color.ColorByAppThemColor(.black))
                    .font(.title2)
                    .bold()
                    .padding(.vertical)
                
                ForEach(buttons) { btn in
                   ActionButton(
                    buttonImage: btn.buttonImage,
                    buttonTitle: btn.buttonTitle,
                    isSelected: btn.isSelected,
                    action: btn.action
                   )
                   .background(Color(Constants.kSecondary))
                   .clipShape(RoundedRectangle(cornerRadius: 15))
                }
                
                Spacer()
            }
            .padding()
        }
        .ignoresSafeArea()
    }
    
    @ViewBuilder func ActionButton(buttonImage: String, buttonTitle: String, isSelected: Bool = false, action: @escaping ( () -> Void) ) -> some View {
        Button(action: {
            action()
            withAnimation(.spring()) {
                isDismissed.toggle()
            }
        }, label: {
            HStack {
                Spacer()
                
                Image(systemName: buttonImage)
                    .resizable()
                    .frame(width: 25, height: 25)
                    .foregroundStyle(Color(Constants.kPrimary))
                    .padding(.horizontal)
                
                Text(buttonTitle)
                    .foregroundStyle(Color(Constants.kPrimary))
                    .font(.custom(Constants.mainFont, size: 21))
                    .fontWeight(.semibold)
                
                Spacer()
                
                Image(systemName: "checkmark")
                    .resizable()
                    .bold()
                    .frame(width: 19, height: 19)
                    .foregroundStyle(Color(Constants.kPrimary))
                    .padding(.trailing)
                    .opacity(isSelected ? 1 : 0)
            }
            .padding(.vertical, 11)
        })
    }
    
}

#Preview {
    CustomMiniSheet(
        title: "Ilova tilini tanlang",
        buttons: [
            CustomMiniSheetButton(buttonImage: "moon", buttonTitle: "Qorong`u rejim", action: {  }),
            CustomMiniSheetButton(buttonImage: "moon.fill", buttonTitle: "Qorong`u rejim", isSelected: true, action: {  })
        ],
        isDismissed: .constant(false)
    )
}
