//
//  BestBeforeApp.swift
//  BestBefore
//
//  Created by victor kabike on 2022/08/04.
//

import SwiftUI

@main
struct BestBeforeApp: App {

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(ItemViewModel())
                .preferredColorScheme(.light)
        }
    }
}
