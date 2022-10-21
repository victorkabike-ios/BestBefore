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
        NavigationView{
            ZStack{
                Color.white.ignoresSafeArea(.all)
                VStack(alignment: .leading){
                    Text("Notifications")
                        .font(.largeTitle)
                    List{
                        ForEach(notificationManager.notifications, id: \.identifier){ notification in
                            HStack( spacing: 10){
                                HStack{
                                    Text(notification.content.body)
                                    VStack(alignment: .leading){
                                        Text(notification.content.title)
                                            .font(.headline)
                                            .foregroundColor(.primary)
                                        Text("Expired by \(notification.content.subtitle)")
                                            .font(.subheadline)
                                            .foregroundColor(.red)
                                    }
                                }.padding()
                                
                            }
                            .frame(maxWidth: .infinity,alignment: .leading)
                            .frame(height: 75)
                            .background {
                                RoundedRectangle(cornerRadius: 10)
                                    .fill(Color.gray.opacity(0.1))
                            }
                        }.onDelete(perform: deleteNotification)
                        
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
                .onAppear {
                    notificationManager.reloadLocalNotifications()
                }
            }
        }
    }
}
extension Notifications {
    func deleteNotification(_ indexSet: IndexSet){
        notificationManager.deleteLocalNotification(identifier: indexSet.map {
            notificationManager.notifications[$0].identifier
        })
        notificationManager.reloadLocalNotifications()
    }
}

struct Notifications_Previews: PreviewProvider {
    static var previews: some View {
        Notifications()
    }
}
