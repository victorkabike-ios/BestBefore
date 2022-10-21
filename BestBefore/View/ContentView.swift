//
//  ContentView.swift
//  BestBefore
//
//  Created by victor kabike on 2022/08/04.
//

import SwiftUI
import CoreData

struct ContentView: View {
    @StateObject var notificationManager = NotificationManager()
    var body: some View {
        NavigationView{
            Tab()
        }
        .onAppear {
            notificationManager.requestAuthorization()
        }
       
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
