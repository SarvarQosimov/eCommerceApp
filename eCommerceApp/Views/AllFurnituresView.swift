//
//  AllFurnituresView.swift
//  eCommerceApp
//
//  Created by Sarvar Qosimov on 23/01/24.
//

import SwiftUI

struct AllFurnituresView: View {
    @ObservedObject var homePageVM = HomePageViewModel()
    
    var column = [GridItem(.adaptive(minimum: 160), spacing: 20)]
    
    var body: some View {
            ZStack(alignment: .topLeading) {
                Color.ColorByAppThemView(.white)
                    .ignoresSafeArea()
                
                VStack {
                    CustomBackButtonView(navigationTitle: "Barcha mebellar")
                    //TODO: maybe ScrollView should remove (is LazyVGrid scrollable)
                    ScrollView {
                        LazyVGrid(columns: column, content: {
                            ForEach(homePageVM.furnitures) { furniture in
                                NavigationLink {
                                FurnitureDetailView(furniture: furniture)
                                } label: {
                                    ProductCardView(currentFurniture: furniture)
                                }
                            }
                        })
                        .padding()
                    }
                }
            }
            .navigationBarBackButtonHidden(true)
        .task {
            homePageVM.fetchFurnitures()
        }
    }
}

#Preview {
    AllFurnituresView()
}
