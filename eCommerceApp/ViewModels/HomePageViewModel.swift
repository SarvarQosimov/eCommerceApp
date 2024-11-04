//
//  HomePageViewModel.swift
//  eCommerceApp
//
//  Created by Sarvar Qosimov on 23/01/24.
//

import Foundation

class HomePageViewModel: ObservableObject {
    @Published var furnitures = [Furniture]()
    var mananger = DataMananger()
    
    func fetchFurnitures(){
        mananger.fetchFurnituries { furnitures in
            self.furnitures = furnitures
            print("gotted fur \(furnitures.count)")
        }
    }
}
