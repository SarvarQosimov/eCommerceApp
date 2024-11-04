//
//  HomePageView.swift
//  eCommerceApp
//
//  Created by Sarvar Qosimov on 13/01/24.
//

import SwiftUI
import Combine
import os

struct HomePageView: View {
    @ObservedObject var homePageViewModel = HomePageViewModel()
    
    @Binding var hideTabbar: Bool
    
    @State var showCartView = false
    
    var body: some View {
        print("home page update full \(homePageViewModel.furnitures.count)")
        
        return  NavigationStack {
            ZStack(alignment: .topLeading) {
                Color.ColorByAppThemView(.white)
                    .ignoresSafeArea()
                
                ScrollView {
                    ZStack {
                        VStack {
                            AppBarView()
                            
                            ImageSliderView()
                            
                            NewFurnituresView(hideTabbar: {
                                hideTabbar = true
                            })
                            
                            Spacer(minLength: 75)
                        }
                        .ignoresSafeArea()
                    }
                    .ignoresSafeArea()
                    .onAppear(perform: {
                        homePageViewModel.fetchFurnitures()
                        hideTabbar = false
                    })
                }
                .ignoresSafeArea()
                .padding(.vertical)
            }
        }
    }
    
    func someFunc(){
        
        
    }
    
    //MARK: - AppBarView
    @ViewBuilder func AppBarView() -> some View {
        ZStack {
            Color.ColorByAppThemView(.white)
                .ignoresSafeArea()
            
            VStack(alignment: .leading) {
                HStack {
                    Text("Eng sara ")
                        .font(.custom(Constants.mainFont, size: 25))
                        .foregroundColor(Color.ColorByAppThemColor(.black))
                    
                    + Text(" Jihozlar")
                        .foregroundColor(Color.ColorByAppThemColor(.primary))
                        .font(.custom(Constants.mainFont, size: 25))
                        .bold()
                    
                    Spacer()
                }
                
                Text("faqat bizda")
                    .font(.custom(Constants.mainFont, size: 25))
                    .foregroundColor(Color.ColorByAppThemColor(.black))
            }
            .padding(.horizontal)
            .fixedSize(horizontal: false, vertical: true)
        }
    }
    
}

#Preview {
    HomePageView(hideTabbar: .constant(false))
}

//MARK: - NewFurnituresView
struct NewFurnituresView: View {
    @ObservedObject var homePageViewModel = HomePageViewModel()
    
    var hideTabbar: ( () -> Void )
    
    init(hideTabbar: @escaping ( () -> Void )) {
        self.hideTabbar = hideTabbar
        homePageViewModel.fetchFurnitures()
    }
    
    var body: some View {
        HStack {
            Text("Yangei mebellar")
                .font(.title2)
                .fontWeight(.medium)
                .foregroundColor(Color.ColorByAppThemColor(.black))
            
            Spacer()
            
            Image(systemName: "circle.grid.2x2.fill")
                .foregroundColor(Color.ColorByAppThemColor(.primary))
                .onTapGesture {
                    hideTabbar()
                    DispatchQueue.main.asyncAfter(deadline: .now()+0.1) {
                        CurrentNavigation.shared.push(AllFurnituresView())
                    }
                }
        }
        .padding(.horizontal)
        .padding(.top)
        
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 10) {
                ForEach(homePageViewModel.furnitures) { furniture in
                    ProductCardView(currentFurniture: furniture)
                        .onTapGesture {
                            hideTabbar()
                            DispatchQueue.main.asyncAfter(deadline: .now()+0.1) {
                                CurrentNavigation.shared.push(FurnitureDetailView(furniture: furniture))
                            }
                        }
                }
            }
            .padding(.leading)
        }
    }
}
