//
//  eCommerceAppApp.swift
//  eCommerceApp
//
//  Created by Sarvar Qosimov on 24/12/23.
//

import SwiftUI
import Firebase

@main
struct eCommerceAppApp: App {
    
    init() {
        FirebaseApp.configure()
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
