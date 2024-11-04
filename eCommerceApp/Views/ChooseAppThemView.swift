//
//  ChooseAppThemView.swift
//  eCommerceApp
//
//  Created by Sarvar Qosimov on 01/02/24.
//

import SwiftUI

struct ChooseAppThemView: View {
    @AppStorage("appThem") var appThem = AppThem.auto.rawValue
    @StateObject var updateManager: UpdateMananger
    @Binding var isDismissed: Bool
    
    var body: some View {
        ZStack {
            Color.ColorByAppThemView(.white)
                .ignoresSafeArea()
            
            VStack {
                Text("Ilova mavzusini tanlang")
                    .foregroundStyle(Color.ColorByAppThemColor(.black))
                    .font(.title2)
                    .bold()
                    .padding(.vertical)
                
                ThemButtonView(
                    imageName: "sun.min.fill",
                    themName: "Yoqug` rejim",
                    isSelected: appThem == "light",
                    action: { appThem = "light" }
                )
                    .background(Color(Constants.kSecondary))
                    .clipShape(RoundedRectangle(cornerRadius: 15))
                
                ThemButtonView(
                    imageName: "moon.fill",
                    themName: "Qorong`u rejim",
                    isSelected: appThem == "dark",
                    action: { appThem = "dark" }
                )
                    .background(Color(Constants.kSecondary))
                    .clipShape(RoundedRectangle(cornerRadius: 15))
                
                ThemButtonView(
                    imageName: "iphone.gen2",
                    themName: "Avtomatik",
                    isSelected: appThem == "auto",
                    action: { appThem = "auto" }
                )
                    .background(Color(Constants.kSecondary))
                    .clipShape(RoundedRectangle(cornerRadius: 15))
                
                Spacer()

            }
            .padding()
        }
        .ignoresSafeArea()
    }
    
    @ViewBuilder func ThemButtonView(imageName: String, themName: String, isSelected: Bool, action: @escaping ( () -> Void) ) -> some View {
        Button(action: {
            action()
            updateManager.shouldUpdate.toggle()
            isDismissed.toggle()
        }, label: {
            HStack {
                Spacer()
                
                Image(systemName: imageName)
                    .resizable()
                    .frame(width: 25, height: 25)
                    .foregroundStyle(Color(Constants.kPrimary))
                    .padding(.horizontal)
                
                Text(themName)
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
    ChooseAppThemView(
        updateManager: UpdateMananger(), isDismissed: .constant(false)
    )
}

