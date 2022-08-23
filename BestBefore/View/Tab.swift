//
//  Tab.swift
//  BestBefore
//
//  Created by victor kabike on 2022/08/14.
//

import SwiftUI

struct Tab: View {
    @State var selectedtab = 1
    @StateObject var notificationManager = NotificationManager()
    var body: some View {
        TabView(selection: $selectedtab){
            Home()
                .tabItem {
                   Image(systemName: "clock.badge.checkmark.fill")
                }
                .tag(1)
            
            Notifications()
                .tabItem {
                    Image(systemName: "bell.fill")
                        .badge(notificationManager.notifications.count)
                }
                .tag(2)
            
            
        }
        
    }
}

struct Tab_Previews: PreviewProvider {
    static var previews: some View {
        Tab()
    }
}

