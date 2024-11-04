//
//  SearchPageViewModel.swift
//  eCommerceApp
//
//  Created by Sarvar Qosimov on 24/01/24.
//

import Foundation

class SearchPageViewModel: ObservableObject {
    @Published var searchingFurnitures = [Furniture]()
    private var allFurnitures = [Furniture]()
    let mananger = DataMananger()
    var filtrModel = FiltrModel()
    
    init(){
        fetchFurnitures()
    }
    
    func searchWithText(text key: String = "") {
        print("key:", key)
        
        searchingFurnitures = allFurnitures
        
        filtr()
        
        searchingFurnitures = searchingFurnitures.filter({
            $0.name.lowercased().contains(key.lowercased())
        })
        
        if key.isEmpty {
            searchingFurnitures = allFurnitures
        }
    }
    
    func filtr(){
        if filtrModel.manufacture != "Barchasi" {
            filtrByManufacture(filtrModel.manufacture)
        }
        
        if !filtrModel.categories.isEmpty && !filtrModel.categories.contains("Barchasi") {
            filtrByCategory(filtrModel.categories)
        }
        print("filtrModel.manufacture -> \(filtrModel.manufacture)")
    }
    
    private func filtrByManufacture(_ manufacture: String) {
        searchingFurnitures = searchingFurnitures.filter({
            $0.manufacture == filtrModel.manufacture
        })
    }
    
    private func filtrByCategory(_ categories: [String]){
        searchingFurnitures = searchingFurnitures.filter({
            filtrModel.categories.contains($0.category + "lar")
        })
    }
    
    func fetchFurnitures(){
        mananger.fetchFurnituries { [weak self] furnitures in
            guard let self = self else { return }

            searchingFurnitures = furnitures
            allFurnitures = furnitures
        }
    }
}
