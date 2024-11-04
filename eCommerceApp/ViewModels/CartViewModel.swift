//
//  CardViewModel.swift
//  eCommerceApp
//
//  Created by Sarvar Qosimov on 23/01/24.
//

import Foundation

class CartViewModel: ObservableObject {
    var mananger = DataMananger()
    @Published var savedFurnituries: [Furniture] = []
    var totalPrice = 0
    
    func fetchSavedFurnitures(){
        totalPrice = 0
        
        mananger.fetchFurnituries { [weak self] furnitures in
            guard let self = self else { return }
            
            savedFurnituries = furnitures.filter({
                if $0.isSaved {
                    self.totalPrice += $0.price
                }
                
                return $0.isSaved
            })
        }
    }
    
    func unsaveFurniture(ID: Int){
        mananger.doUnsaved(ID)
        savedFurnituries = savedFurnituries.filter({ $0.id != ID })
    }
    
    func removeAllFromCart(){
        savedFurnituries.forEach { savedFurniture in
            mananger.doUnsaved(savedFurniture.id)
        }
        
        savedFurnituries.removeAll()
    }
    
}
