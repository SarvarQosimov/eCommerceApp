//
//  CustomBackButtonView.swift
//  eCommerceApp
//
//  Created by Sarvar Qosimov on 06/02/24.
//

import SwiftUI

struct CustomBackButtonView: View {
    @Environment(\.presentationMode) var presentationMode
    
    let navigationTitle: String
    
    var body: some View {
        HStack {
            Button(action: {
                presentationMode.wrappedValue.dismiss()
            }, label: {
                Image(systemName: "arrow.left.circle")
                    .resizable()
                    .frame(width: 35, height: 35)
                    .bold()
                    .foregroundStyle(Color.ColorByAppThemColor(.primary))
                    .padding(.horizontal)
        })
            
            Spacer()
            
            Text(navigationTitle)
                .font(.custom(Constants.mainFont, size: 21))
                .foregroundStyle(Color.ColorByAppThemColor(.primary))
                .padding(.trailing)
            
            Spacer()
            
        }
        .padding(.trailing)
    }
}

#Preview {
    CustomBackButtonView(navigationTitle: "")
}
