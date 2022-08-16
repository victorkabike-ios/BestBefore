//
//  Notifications.swift
//  BestBefore
//
//  Created by victor kabike on 2022/08/14.
//

import SwiftUI

struct Notifications: View {
    @StateObject var notificationManager = NotificationManager()
    var body: some View {
        NavigationStack{
            VStack(alignment: .leading){
                Text("Notifications")
                    .font(.largeTitle)
                List(notificationManager.notifications, id: \.identifier){ notification in
                    HStack{
                        Image(systemName: "clock.arrow.circlepath")
                        Text(notification.content.title)
                            .font(.headline)
                            .foregroundColor(.primary)
                    }
                    
                }
                .listStyle(.plain)
                .onAppear(perform: notificationManager.reloadAuthorizationStatus)
                .onChange(of: notificationManager.authorizationStatus) { auth in
                    switch auth{
                    case .notDetermined:
                        // request authorization
                        notificationManager.requestAuthorization()
                        break
                    case .authorized:
                        // get local notifications
                        notificationManager.reloadLocalNotifications()
                        break
                    default:
                        break
                    }
                }
            }
            .navigationTitle("Notifications")
            .padding()
        }
    }
}

struct Notifications_Previews: PreviewProvider {
    static var previews: some View {
        Notifications()
    }
}
