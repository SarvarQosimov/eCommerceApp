//
//  Furniture.swift
//  eCommerceApp
//
//  Created by Sarvar Qosimov on 13/01/24.
//

import Foundation

class Furniture: Identifiable {
    let id: Int
    var name: String
    var image: String
    var price: Int
    var description: String
    var width: Int
    var length: Int
    var height: Int
    var colors: [String]
    var isSaved: Bool
    var manufacture: String
    var category: String
    
    init(id: Int, name: String, image: String, price: Int, description: String, width: Int, length: Int, height: Int, colors: [String], isSaved: Bool, manufacture: String, category: String) {
        self.id = id
        self.name = name
        self.image = image
        self.price = price
        self.description = description
        self.width = width
        self.length = length
        self.height = height
        self.colors = colors
        self.isSaved = isSaved
        self.manufacture = manufacture
        self.category = category
    }
    
    func findManufacture(_ manufacture: String) -> Manufacture {
        switch manufacture {
        case "uz": return .uz
        default: return .uz
        }
    }
    
}

var furnitureForPreview =
    Furniture(
        id: 1,
        name: "DENVER divan DENVER divan",
        image: "https://aiko.uz/wa-data/public/shop/products/69/25/2569/images/986/986.0x500.jpg",
        price: 1234567,
        description: "Компьютерный стол LIRA 2 позволит в небольшом пространстве организовать удобное место для работы. Имеет большое количество полок, что позволит вам разместить все нужные вам вещи. Изготовлен из качественных материалов: Российской стали, покрытой Турецкой полимерной краской и Российского прочного ЛДСП.",
        width: 100,
        length:  100,
        height: 100,
        colors: ["32a111", "117ca1"],
        isSaved: true,
        manufacture: "Uzbekistan",
        category: "Stul"
    )

// 32a111
// 117ca1

enum PriceType: String {
    case all = "Barchasi"
    case cheapper = "Arzonroq"
    case moreExpensive = "Qimmatroq"
}

enum FurnitureCategory: String {
    case all = "Barchasi"
    case chair = "Stul"
    case table = "Stol"
    case sofa = "Devan"
    case forChildrens = "Bolalar uchun"
    case shelf = "Javon"
    case forOffice = "Office uchun"
}

enum Manufacture: String {
    case uz = "Uzbekistan"
}

enum AppThem: String {
    case light = "light"
    case dark = "dark"
    case auto = "auto"
}
