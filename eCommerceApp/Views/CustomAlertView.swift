//
//  CustomAlertView.swift
//  eCommerceApp
//
//  Created by Sarvar Qosimov on 01/02/24.
//

import SwiftUI

struct CustomAlertView: View {
    @Binding var isDismissed: Bool

    var body: some View {
        ZStack {
            Color.ColorByAppThemView(.white).opacity(0.5).edgesIgnoringSafeArea(.all)
            
            RoundedRectangle(cornerRadius: 25)
                .stroke(lineWidth: 3)
                .foregroundStyle(Color.ColorByAppThemColor(.primaryOrSecondary))
                .frame(width: 300, height: 400)
                .background(Color.ColorByAppThemColor(.white))
                .overlay {
                    VStack(alignment: .center) {
                        Image("empty")
                            .resizable()
                            .frame(width: 101, height: 101)
                            .background(Color(Constants.kSecondary))
                            .clipShape(RoundedRectangle(cornerRadius: 25))
                        
                        Text("Kechirasiz! \n \n Ammo hozircha buyurtma berish funkiyasi mavjud emas")
                            .foregroundStyle(Color.ColorByAppThemColor(.black))
                            .font(.custom(Constants.mainFont, size: 25))
                            .fontWeight(.semibold)
                            .multilineTextAlignment(.center)
                        
                        Spacer()
                        
                        Button(action: {
                            isDismissed.toggle()
                        }, label: {
                            HStack {
                                Spacer()
                                
                                Text("Tushunarli")
                                    .foregroundStyle(Color.ColorByAppThemColor(.white))
                                    .bold()
                                    .padding()
                                
                                Spacer()
                            }
                            .background(Color.ColorByAppThemColor(.primary))
                            .clipShape(RoundedRectangle(cornerRadius: 15))
                        })
                        .padding()
                    }
                    .padding(.vertical)
                }
                .cornerRadius(25)
        }
        
    }
}

#Preview {
    CustomAlertView(isDismissed: .constant(true))
}
