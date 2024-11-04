//
//  AppView.swift
//  eCommerceApp
//
//  Created by Sarvar Qosimov on 03/02/24.
//

import SwiftUI

struct AppView: View {
    
    //MARK: - Variables
    
    @State var selectedTab: Tab = .Home
    
    ///This variable to present and dismiss `CartOfProductsView`
    @State var showCartView = false
    
    /// `appThemChanged` variable to listen changes of appThem (light mode , dark mode, automatic)
    @State var appThemChanged = false
    
    @State var shouldHideTabbar = false
    
    let tabs: [Tab] = [.Home, .Search, .Cart, .Profile]
    
    init() {
        UITabBar.appearance().isHidden = true
    }
    
    var body: some View {
            ZStack {
                Color.ColorByAppThemView(.white)
                    .ignoresSafeArea()
                
                ZStack(alignment: .bottom, content: {
                    
                    TabView(selection: $selectedTab) {
                        
                        HomePageView(hideTabbar: $shouldHideTabbar)
                            .tag(Tab.Home)
                            .tabItem {
                                TabBarItem(tab: .Home, selected: $selectedTab)
                            }
                        
                        SearchPageView(filtrModel: FiltrModel(), hideTabbar: $shouldHideTabbar)
                            .tag(Tab.Search)
                            .tabItem {
                                TabBarItem(tab: .Search, selected: $selectedTab)
                            }
                            .ignoresSafeArea()
                        
                        Text("")
                            .tag(Tab.Cart)
                            .tabItem {
                                TabBarItem(tab: .Cart, selected: $selectedTab)
                            }
                            .onAppear(perform: {
                                showCartView = true
                            })
                            .fullScreenCover(isPresented: $showCartView, content: {
                                CartOfProductsView(backPressed: $showCartView)
                            })
                            .onChange(of: showCartView, perform: { value in
                                if !value {
                                    selectedTab = .Home
                                }
                            })
                            .onChange(of: appThemChanged, perform: { value in
                                print("app them changed")
                                if appThemChanged {
                                    appThemChanged = false
                                }
                                
                            })
                        
                        ProfilePageView(isAppThemChanged: $appThemChanged, hideTabbar: $shouldHideTabbar)
                            .tag(Tab.Profile)
                            .tabItem {
                                TabBarItem(tab: .Profile, selected: $selectedTab)
                            }
                    }
                    .background(Color(Constants.kSecondary))
                    
//                    if !shouldHideTabbar {
                       HStack {
                            ForEach(tabs, id: \.self) {tab in
                                Spacer()
                                
                                TabBarItem(tab: tab, selected: $selectedTab)
                                
                                Spacer()
                            }
                        }
                        .padding (.top, 5)
                        .padding(.bottom, 5)
                        .frame (maxWidth: .infinity)
                        .background(Color(Constants.kSecondary))
                        .clipShape(RoundedRectangle(cornerRadius: 15))
                        .padding(.horizontal)
                        .hide(if: shouldHideTabbar)
//                    }
                    
                })
                .ignoresSafeArea()
                .padding(.bottom, 1)
            }
        
        
    }
}

#Preview {
    AppView()
}

struct TabBarItem: View {
    @State var tab: Tab
    @Binding var selected: Tab
    
    var body: some View{
        ZStack{
            Button {
                withAnimation(.spring()) {
                    selected = tab
                }
            } label: {
                HStack{
                    Image(systemName: tab.rawValue)
                        .resizable ()
                        .frame(width: 20, height: 20)
                        .bold()
                        .foregroundStyle(tab == selected ? Color(Constants.kSecondary) : Color(Constants.kPrimary))
                    if selected == tab{
                        Text(tab.tabName)
                            .font(.custom(Constants.mainFont, size: 15))
                            .bold()
                            .foregroundStyle(tab == selected ? Color(Constants.kSecondary) : Color(Constants.kPrimary))
                    }
                }
                .padding(.vertical, 10)
                .padding(.horizontal, 15)
                .background(
                    tab == selected ? Color(Constants.kPrimary) : Color(Constants.kSecondary)
                )
                .clipShape(Capsule())
            }
        }
    }
}
