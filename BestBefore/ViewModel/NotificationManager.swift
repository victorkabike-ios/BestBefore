//
//  NotificationManager.swift
//  BestBefore
//
//  Created by victor kabike on 2022/08/11.
//

import Foundation
import UserNotifications

class NotificationManager: ObservableObject {
    static  let instance = NotificationManager()
    @Published private(set) var notifications: [UNNotificationRequest] = []
    @Published private(set) var authorizationStatus: UNAuthorizationStatus?
    
    func reloadAuthorizationStatus(){
        UNUserNotificationCenter.current().getNotificationSettings { settings in
            DispatchQueue.main.async {
                self.authorizationStatus = settings.authorizationStatus
            }
        }
    }
    func requestAuthorization(){
        let options:UNAuthorizationOptions = [.alert , .sound , .badge]
        UNUserNotificationCenter.current().requestAuthorization(options: options){ isgranted, error in
            if let error = error{
                print("Error : \(error)")
            } else{
                DispatchQueue.main.async {
                    self.authorizationStatus = isgranted ? .authorized : .denied
                }
            }
        }
    }
    
    func reloadLocalNotifications(){
        UNUserNotificationCenter.current().getPendingNotificationRequests { notifications in
            DispatchQueue.main.async {
                self.notifications = notifications
            }
        }
    }

    func scheduleNotification(title: String ,expirationDate: Date, time: Date ,emoji: String) {
        let notificationId = UUID().uuidString
        let content = UNMutableNotificationContent()
        content.title = title
        content.subtitle = expirationDate.formatted(date: .numeric, time: .omitted)
        content.body = emoji
        content.sound = .default
        
        // Calendar
        let calendar = Calendar.current
        let  weekday = calendar.component(.weekday, from: expirationDate)
        let day = calendar.component(.day, from: expirationDate)
        let hour = calendar.component(.hour, from: time)
        let min = calendar.component(.minute, from: time)
        var component = DateComponents()
        component.weekday = weekday
        component.day = day
        component.hour = hour
        component.minute = min
        //Time
        let trigger  = UNCalendarNotificationTrigger(dateMatching: component, repeats: true)
        
        //Request
        let request = UNNotificationRequest(identifier: notificationId, content: content, trigger: trigger)
        
        UNUserNotificationCenter.current().add(request)
        
    }
    
    func deleteLocalNotification(identifier: [String]){
        UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: identifier)
    }
    
}
