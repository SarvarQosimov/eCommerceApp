//
//  ContentView.swift
//  eCommerceApp
//
//  Created by Sarvar Qosimov on 24/12/23.
//

import SwiftUI

struct ContentView: View {
    @State var currentTab: Tab = .Home
    @State var updateView = false
    @State var isCardViewPresented = false
    @State var backToHome = false
    @StateObject var updateMananger = UpdateMananger()
    
    init() {
        let appearance = UITabBarAppearance()
        appearance.backgroundColor = UIColor(Color.ColorByAppThemColor(.white))
        UITabBar.appearance().standardAppearance = appearance
    }
    
    var body: some View {
        AppView()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

enum Tab: String, CaseIterable {
    case Home = "house"
    case Search = "magnifyingglass.circle"
    case Notifications = "bell"
    case Cart = "bag"
    case Profile = "person"
    
    var tabName: String {
        switch self {
        case .Home:
            return "Home"
        case .Search:
            return "Search"
        case .Notifications:
            return "Notifications"
        case .Cart:
            return "Cart"
        case .Profile:
            return "Profile"
        }
    }
    
}


//        TabView(selection: $currentTab) {
//            //home
//            HomePageView()//updateManager: updateMananger)
//                .tabItem {
//                    Image(systemName: Tab.Home.rawValue)
//                    Text(Tab.Home.tabName)
//                }
//                .tag(Tab.Home)
//
//            //search
//            SearchPageView(filtrModel: FiltrModel())
//                .tabItem {
//                    Image(systemName: Tab.Search.rawValue)
//                    Text(Tab.Search.tabName)
//                }
//                .tag(Tab.Search)
//
//            //Cart
//
//            Text("e")
//                .tabItem {
//                    Image(systemName: Tab.Cart.rawValue)
//                    Text(Tab.Cart.tabName)
//                }
//                .tag(Tab.Cart)
//                .onAppear(perform: {
//                    isCardViewPresented = true
//                })
//                .fullScreenCover(isPresented: $isCardViewPresented, content: {
//                    CartOfProductsView(backPressed:  $isCardViewPresented)
//                })
//                .onChange(of: isCardViewPresented, perform: { value in
//                    print("onChange content view da")
//                    self.currentTab = .Search
//                })
//
//            //Profile
//            ProfilePageView(isAppThemChanged: $updateView)
//                .tabItem {
//                    Image(systemName: Tab.Profile.rawValue)
//                    Text(Tab.Profile.tabName)
//                }
//                .tag(Tab.Profile)
//        }
//        .tint(Color.ColorByAppThemColor(.primary))
//        .onChange(of: updateView, perform: { _ in
//            currentTab = .Home
//        })
