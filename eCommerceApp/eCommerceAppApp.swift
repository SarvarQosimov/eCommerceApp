//
//  eCommerceAppApp.swift
//  eCommerceApp
//
//  Created by Sarvar Qosimov on 24/12/23.
//

import SwiftUI

@main
struct eCommerceAppApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
