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
                    VStack{
                        Image(systemName: "square.grid.2x2.fill")
                        Text("Today")
                    }
                }
                .tag(1)
            
//            CalendarView()
//                .tabItem {
//                    VStack{
//                        Image(systemName: "calendar")
//                        Text("Calendar")
//                    }
//                }
//                .tag(2)
//                .hidden()
            
            Notifications()
                .tabItem {
                    
                    VStack {
                        Image(systemName: "bell.fill")
                            .badge(notificationManager.notifications.count)
                        Text("Notifications")
                    }
                }
                .tag(3)
            
            
        }
        .navigationBarBackButtonHidden()
        
    }
}

struct Tab_Previews: PreviewProvider {
    static var previews: some View {
        Tab()
    }
}

