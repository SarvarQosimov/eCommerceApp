//
//  FiltrModel.swift
//  eCommerceApp
//
//  Created by Sarvar Qosimov on 29/01/24.
//

import Foundation

class FiltrModel: Equatable {
    static func == (lhs: FiltrModel, rhs: FiltrModel) -> Bool {
        return false
    }
    
    var priceType: PriceType = .all
    var manufacture: String = "Barchasi"
    var categories: [String] = []
    
    init(priceType: PriceType = .all, manufacture: String = "Barchasi", categories: [String] = []) {
        self.priceType = priceType
        self.manufacture = manufacture
        self.categories = categories
    }
}

