//
//  Chapter14.swift
//  CombineExample
//
//  Created by Jun on 2022/04/05.
//

import SwiftUI
import UserNotifications

struct Chapter14: View {
    @StateObject private var notificationManager = NotificationManager()
    
    var body: some View {
        List(notificationManager.notifications, id:\.identifier) { notification in
            Text(notification.content.title)
                .fontWeight(.semibold)
        }
        .listStyle(InsetGroupedListStyle())
        .navigationTitle("Notifications")
        .onAppear(perform: notificationManager.reloadAuthorizationStatus)
        .onChange(of: notificationManager.authorizationStatus) { newValue in
            switch newValue {
            case .notDetermined:
                notificationManager.requestAuthorization()
            case .authorized:
                notificationManager.reloadLocalNotifications()
            default:
                break
            }
        }
    }
}

struct Chapter14_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            Chapter14()
        }
        
    }
}

final class NotificationManager: ObservableObject {
    @Published private(set) var notifications:[UNNotificationRequest] = []
    @Published private(set) var authorizationStatus:UNAuthorizationStatus?
    
    func reloadAuthorizationStatus() {
        UNUserNotificationCenter.current().getNotificationSettings { settings in
            DispatchQueue.main.async {
                self.authorizationStatus = settings.authorizationStatus
            }
        }
    }
    
    func requestAuthorization() {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) { isGranted, _ in
            DispatchQueue.main.async {
                self.authorizationStatus = isGranted ? .authorized : .denied
            }
        }
    }
    
    
    func reloadLocalNotifications() {
        UNUserNotificationCenter.current().getPendingNotificationRequests { notifications in
            DispatchQueue.main.async {
                self.notifications = notifications
            }
        }
    }
}
