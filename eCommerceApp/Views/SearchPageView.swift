//
//  SearchPageView.swift
//  eCommerceApp
//
//  Created by Sarvar Qosimov on 24/01/24.
//

import SwiftUI

struct SearchPageView: View {
    @State var searchTF = ""
    @State var isPresented = false
    @State var filtrModel = FiltrModel()
    @State var showDetailView = false
    
    @Binding var hideTabbar: Bool
    
    @ObservedObject var searchPageVM = SearchPageViewModel()
    
    var body: some View {
        print("search page updated fully")
        
        return NavigationStack {
            ZStack {
                Color.ColorByAppThemView(.white)
                    .ignoresSafeArea()
                
                VStack {
                    TitleAndTextFieldView()
                    
                    SearchedItemsList()
                }
            }
        }
        .task {
            searchPageVM.fetchFurnitures()
        }
    }
    
    //MARK: - TitleAndTextFieldView
    @ViewBuilder func TitleAndTextFieldView() -> some View {
        HStack {
            Text("Istalgan jihozni qidiring")
                .font(.custom("American Typewriter", size: 25))
                .foregroundColor(Color.ColorByAppThemColor(.black))
            
            Image(systemName: "magnifyingglass")
                .resizable()
                .frame(width: 25, height: 25)
                .foregroundColor(Color.ColorByAppThemColor(.black))
                .bold()
        }
        
        HStack {
            TextField("     Mebel nomini kiriting !!!", text: $searchTF)
                .frame(height: 50)
                .background(Color(Constants.kSecondary))
                .cornerRadius(17)
                .font(.custom(Constants.mainFont, size: 17))
                .overlay (
                    RoundedRectangle(cornerRadius: 15)
                        .stroke(Color(Constants.kPrimary), lineWidth: 3)
                )
                .padding(.horizontal, 5)
                .onChange(of: searchTF, perform: { newText in
                    searchPageVM.searchWithText(text: newText)
                })
             
            Image("filtrIcon")
                .resizable()
                .frame(width: 45, height: 45)
                .background(.white)
                .cornerRadius(15)
                .onTapGesture {
                    isPresented = true
                }
                .sheet(isPresented: $isPresented, content: {
                        FiltrPageView(filtrModel: $filtrModel, isSheetPresented: $isPresented)
                })
                .onChange(of: filtrModel, perform: { value in
                    searchPageVM.filtrModel = filtrModel
                    searchPageVM.filtr()
                })
        }
        .padding(.horizontal)
    }
    
    @ViewBuilder func SearchedItemsList() -> some View {
        ZStack {
            Color.ColorByAppThemView(.white)
                .ignoresSafeArea()
            
            List(searchPageVM.searchingFurnitures) { searchingFurniture in
                NavigationLink {
                    FurnitureDetailView(furniture: searchingFurniture)
                } label: {
                    SavedProductView(
                        deletingItemID: .constant(0),
                        savedProduct: searchingFurniture,
                        isDeleteAble: false
                    )
                    .listRowBackground(Color.ColorByAppThemView(.white))
                }
            }
            .listStyle(PlainListStyle())
            .listRowSpacing(5)
            .padding(.leading)
        }

    }
    
}


#Preview {
    SearchPageView(filtrModel: FiltrModel(), hideTabbar: .constant(false))
}
    
//struct SearchedItemsList: View {
//    @ObservedObject var searchPageVM = SearchPageViewModel()
//    @Binding var shouldHideTabbar: Bool
//    
//    var body: some View {
//        ZStack {
//            Color.ColorByAppThemView(.white)
//                .ignoresSafeArea()
//            
//            List(searchPageVM.searchingFurnitures) { searchingFurniture in
//                NavigationLink {
//                    FurnitureDetailView(furniture: searchingFurniture)
//                } label: {
//                    SavedProductView(
//                        deletingItemID: .constant(0),
//                        savedProduct: searchingFurniture,
//                        isDeleteAble: false
//                    )
//                    .listRowBackground(Color.ColorByAppThemView(.white))
//                }
//            }
//            .listStyle(PlainListStyle())
//            .listRowSpacing(5)
//            .padding(.leading)
//        }
//        
//    }
//}


// remove if do not need

//struct ExtractedView: View {
//    @ObservedObject var searchPageVM = SearchPageViewModel()
//    var hideTabbar: ( () -> Void )
//    
//    init(hideTabbar: @escaping ( () -> Void )) {
//        self.hideTabbar = hideTabbar
//        searchPageVM.fetchFurnitures()
//    }
//    
//    var body: some View {
//        List(searchPageVM.searchingFurnitures) { searchingFurniture in
//            NavigationLink {
//                FurnitureDetailView(furniture: searchingFurniture)
//            } label: {
//                SavedProductView(savedProduct: searchingFurniture, isDeleteAble: false)
//                    .listRowBackground(Color.ColorByAppThemView(.white))
//                    .listRowBackground(Color.ColorByAppThemView(.white))
//            }
//        }
//        .listStyle(PlainListStyle())
//        .listRowSpacing(15)
//        .padding(.leading)
//    }
//}
