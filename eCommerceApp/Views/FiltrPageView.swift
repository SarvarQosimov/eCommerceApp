//
//  FiltrPageView.swift
//  eCommerceApp
//
//  Created by Sarvar Qosimov on 28/01/24.
//

import SwiftUI

struct FiltrPageView: View {
    @State private var sort: Int = 0
    @State var menuIsOpened = false
    @State var selectedRegion = "Barchasi"
    @State var selectedPriceType: PriceType = .all
    @State var selectedCategories = [String]()
    @State var categories = [String]()
    
    @Binding var filtrModel: FiltrModel
    @Binding var isSheetPresented: Bool
    
    @Environment(\.presentationMode) var presentationMode
    
    var columns = [
        GridItem(.flexible(), spacing: -5),
        GridItem(.flexible(), spacing: -5),
        GridItem(.flexible(), spacing: -5),
    ]
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color.ColorByAppThemView(.white)
                    .ignoresSafeArea()
                
                VStack {
                    FiltrByPriceSectionView()
                    
                    FiltrByManufactureSectionView()
                    
                    FiltrByProductTypeSectionView()
                    
                    Spacer()
                    
                    FiltrButtonView()
                }
                .padding(.top)
                .task {
                    DataMananger.shared.fetchRurnituresCategories(language: "uz") { categories in
                        self.categories = categories
                        
                        //set initial values after getting datas form sever
                        setInitialValues()
                    }
                }
            }
        }
    }
    
    //MARK: - FiltrByPriceSectionView
    @ViewBuilder func FiltrByPriceSectionView() -> some View {
        HStack {
            Text("Narx")
                .foregroundStyle(Color.ColorByAppThemColor(.black))
                .padding(.leading)
            
            Spacer()
        }
        .padding(.leading)
        
        HStack {
            PriceButtonView(text: "Barchasi") { selectedPriceType = .all }
            
            PriceButtonView(text: "Arzonroq") { selectedPriceType = .cheapper }
            
            PriceButtonView(text: "Qimmatroq") { selectedPriceType = .moreExpensive }
        }
    }
    
    //MARK: - PriceButtonView
    @ViewBuilder func PriceButtonView(text: String, action: @escaping () -> (Void) ) -> some View {
        Button(action: { action() },
               label: {
            Text(text)
                .foregroundColor(
                    text == selectedPriceType.rawValue ? Color.ColorByAppThemColor(.white) : Color.ColorByAppThemColor(.primary)
                )
                .bold()
                .padding()
        })
        .background(
            text == selectedPriceType.rawValue ? Color.ColorByAppThemColor(.primaryOrSecondary) : Color.ColorByAppThemColor(.white)
        )
        .overlay(content: {
            RoundedRectangle(cornerRadius: 15)
                .stroke(lineWidth: 3)
        })
        .foregroundColor(Color(Constants.kSecondary))
        .cornerRadius(15)
    }
    
    //MARK: - FiltrByManufactureSectionView
    @ViewBuilder func FiltrByManufactureSectionView() -> some View {
        HStack {
            Text("Ishlab chiqarilgan davlat")
                .foregroundStyle(Color.ColorByAppThemColor(.black))
                .padding(.leading)
            
            Spacer()
        }
        .padding(.top)
        .padding(.horizontal)
        
        Menu {
            Button(action: { selectedRegion = "Barchasi" },
                   label: { Text("Barchasi") })
            
            Button(action: { selectedRegion = "Rossiya" },
                   label: { Text("Rossiya") })
            
            Button(action: { selectedRegion = "Turkiya" },
                   label: { Text("Turkiya") })
            
            Button(action: { selectedRegion = "Xitoy" },
                   label: { Text("Xitoy") })
        } label: {
            ManufactureButtonView().padding(.horizontal)
        }
        .tint(Color(Constants.kPrimary))
    }
    
    //MARK: - ManufactureButtonView
    @ViewBuilder func ManufactureButtonView() -> some View {
        HStack {
            Text(selectedRegion)
                .bold()
                .padding()
            
            Spacer()
            
            Image(systemName: "chevron.right")
                .frame(width: 25, height: 25)
                .bold()
                .padding()
        }
        .background(Color(Constants.kSecondary))
        .cornerRadius(7)
        .padding(.horizontal)
        .onTapGesture {
            menuIsOpened = true
        }
    }
    
    //MARK: - FiltrByProductTypeSectionView
    @ViewBuilder func FiltrByProductTypeSectionView() -> some View {
        HStack {
            Text("Mebel turi")
                .foregroundStyle(Color.ColorByAppThemColor(.black))
                .padding(.leading)
            
            Spacer()
        }
        .padding(.top)
        
        ProductTypeButtonView()
    }
    
    //MARK: - ProductTypeView
    @ViewBuilder func ProductTypeButtonView() -> some View {
        LazyVGrid(columns: columns, content: {
            ForEach(categories, id: \.self) { category in
                Button(action: {
                    selectedCategories.contains(category) ? removwFromSelection(category) : selectedCategories.append(category)
                }, label: {
                    Text(category)
                        .foregroundColor(
                            selectedCategories.contains(category) ? Color.ColorByAppThemColor(.white) : Color.ColorByAppThemColor(.primary)
                        )
                        .padding(.horizontal)
                })
                .foregroundColor(Color(Constants.kPrimary))
                .frame(minHeight: 33)
                .padding(.vertical, 5)
                .background(
                    selectedCategories.contains(category) ? Color.ColorByAppThemColor(.primaryOrSecondary) : Color.ColorByAppThemColor(.white)
                )
                .overlay {
                    RoundedRectangle(cornerRadius: 9)
                        .stroke(lineWidth: 3)
                        .cornerRadius(9)
                }
                .foregroundColor(Color(Constants.kSecondary))
                .cornerRadius(9)
            }
        })
        .padding(.horizontal)
    }
    
    //MARK: - FiltrButtonView
    @ViewBuilder func FiltrButtonView() -> some View {
        HStack {
            Button(action: {
                print("tozalash pressed")
                filtrModel = FiltrModel(
                    priceType: .all,
                    manufacture: "Barchasi",
                    categories: []
                )
                
                presentationMode.wrappedValue.dismiss()
            }, label: {
                Text("Tozalash")
                    .font(.custom(Constants.mainFont, size: 21))
                    .foregroundColor(.red)
                    .fontWeight(.medium)
                    .padding()
            })
            .frame(width: 125)
            .cornerRadius(15)
            
            Spacer()
            
            Button(action: {
                print("qidirish pressed")
                print("selectedCategories", selectedCategories)
                filtrModel = FiltrModel(
                    priceType: selectedPriceType,
                    manufacture: selectedRegion,
                    categories: selectedCategories
                )
                
                isSheetPresented = false
            }, label: {
                Text("Qidirish")
                    .frame(width: 150)
                    .font(.custom(Constants.mainFont, size: 25))
                    .foregroundColor(Color.ColorByAppThemColor(.white))
                    .fontWeight(.semibold)
                    .padding()
            })
            .background(Color.ColorByAppThemColor(.primary))
            .overlay {
                RoundedRectangle(cornerRadius: 15)
                    .stroke(lineWidth: 3)
            }
            .cornerRadius(15)
            .padding(.trailing)
        }
    }
    
    //MARK: - functions
    
    private func removwFromSelection(_ category: String){
        for selectedCategory in selectedCategories.enumerated() {
            if selectedCategory.element == category {
                selectedCategories.remove(at: selectedCategory.offset)
                break
            }
        }
    }
    
    private func setInitialValues(){
        selectedRegion = filtrModel.manufacture
        selectedCategories = filtrModel.categories
    }
    
}

#Preview {
    FiltrPageView(filtrModel: .constant(FiltrModel(priceType: .all, manufacture: "a", categories: [])), isSheetPresented: .constant(true))
}
