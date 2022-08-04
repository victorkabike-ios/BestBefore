//
//  BestBeforeApp.swift
//  BestBefore
//
//  Created by victor kabike on 2022/08/04.
//

import SwiftUI

@main
struct BestBeforeApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
