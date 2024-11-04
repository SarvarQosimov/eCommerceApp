//
//  DataMananger.swift
//  eCommerceApp
//
//  Created by Sarvar Qosimov on 20/01/24.
//

import Foundation
import Firebase

class DataMananger: ObservableObject {
    static var shared = DataMananger()
    var furnitures = [Furniture]()
    private let db = Firestore.firestore()

    func fetchRurnituresCategories(language lang: String, completion: @escaping ([String]) -> Void){
        var categoriesResult = [String]()
        
        db.collection("FurnituresCategory").getDocuments { snapshot, error in
            guard let categories = snapshot?.documents else { return }
            
            for category in categories {
                categoriesResult = category["categories_uz"] as? [String] ?? []
            }
            completion(categoriesResult)
        }
        
        
        
    }
    
    func fetchFurnituries(completion: @escaping ([Furniture]) -> Void) {
        
        db.collection("Furnitures").getDocuments { snapshot, error in
            
            guard let datas = snapshot?.documents else { return }
            
            self.furnitures = []
            
            for data in datas {
                let furniture = Furniture(
                    id: data["id"] as? Int ?? 0, 
                    name: data["name"] as? String ?? "",
                    image: data["image"] as? String ?? "",
                    price: data["price"] as? Int ?? 0,
                    description: data["description"] as? String ?? "",
                    width: data["width"] as? Int ?? 100,
                    length: data["length"] as? Int ?? 100,
                    height: data["height"] as? Int ?? 100,
                    colors: data["colors"] as? [String] ?? [],
                    isSaved: data["isSaved"] as? Bool ?? false,
                    manufacture: data["manufacture"] as? String ?? "",
                    category: data["category"] as? String ?? ""
                )
                // 117ca1       32a111
                self.furnitures.append(furniture)
            }
            completion(self.furnitures)
        }
    }
    
    func doUnsaved(_ savedProductID: Int){
        var deleteItemID = ""
        
        db.collection("Furnitures").getDocuments { snapshots, error in

            guard let datas = snapshots?.documents else { return }
            
            // find item which should delete and get `documentID`
            for data in datas {
                if let id = data["id"] as? Int, id == savedProductID {
                    deleteItemID = data.documentID
                }
            }
            
            // Update only the "isSaved" field value to false
            self.db.collection("Furnitures").document(deleteItemID).updateData([
                "isSaved" : false
            ]) { error in
                if let error = error {
                    print("error in doUnsaved: ", error.localizedDescription)
                } else {
                    print("succesfullyl updated")
                }
            }
            
            
        }
        
    }
    
    func doSaved(_ savedProductID: Int){
        var deleteItemID = ""
        
        db.collection("Furnitures").getDocuments { snapshots, error in

            guard let datas = snapshots?.documents else { return }
            
            // find item which should save to card and get `documentID`
            for data in datas {
                if let id = data["id"] as? Int, id == savedProductID {
                    deleteItemID = data.documentID
                }
            }
            
            // Update only the "isSaved" field value to true
            self.db.collection("Furnitures").document(deleteItemID).updateData([
                "isSaved" : true
            ]) { error in
                if let error = error {
                    print("error in doUnsaved: ", error.localizedDescription)
                } else {
                    print("succesfullyl updated")
                }
            }
        }
    }
    
}


