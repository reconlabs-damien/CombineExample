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
    @State private var isCreatePresented = false
    
    private static var notificationDateFormatter:DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.timeStyle = .short
        return dateFormatter
    }()
    
    private func timeDisplyText(from notification: UNNotificationRequest) -> String {
        guard let nextTriggerDate = (notification.trigger as? UNCalendarNotificationTrigger)?.nextTriggerDate() else { return "" }
        return Self.notificationDateFormatter.string(from: nextTriggerDate)
    }
    
    @ViewBuilder
    var infoOverlayView: some View {
        switch notificationManager.authorizationStatus {
        case .authorized:
            if notificationManager.notifications.isEmpty {
                InfoOverlayView(infoMessage: "No Notifications Yet", buttonTitle: "Create", systemImageName: "plus.circle") {
                    isCreatePresented = true
                }
            }
        case .denied:
            InfoOverlayView(infoMessage: "Please Enable Notification Permission In Settings", buttonTitle: "Settings", systemImageName: "gear") {
                if let url = URL(string: UIApplication.openSettingsURLString),
                   UIApplication.shared.canOpenURL(url) {
                    UIApplication.shared.open(url, options: [:], completionHandler: nil)
                }
            }
        default:
            EmptyView()
        }
    }
    
    var body: some View {
        List {
            ForEach(notificationManager.notifications, id: \.identifier) { notification in
                HStack {
                    Text(notification.content.title)
                        .fontWeight(.semibold)
                    Text(timeDisplyText(from: notification))
                        .fontWeight(.bold)
                    Spacer()
                }
                
            }
            .onDelete(perform: delete)
            
        }
        .onReceive(NotificationCenter.default.publisher(for: UIApplication.willEnterForegroundNotification), perform: { _ in
            notificationManager.reloadAuthorizationStatus()
        })
        .listStyle(InsetGroupedListStyle())
        .overlay(infoOverlayView)
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
        .navigationBarItems(trailing: Button {
            isCreatePresented = true
        } label: {
            Image(systemName: "plus.circle")
                .imageScale(.large)
        })
        .sheet(isPresented: $isCreatePresented) {
            NavigationView {
                CreateNotificationView(notificationManager: notificationManager, isPresented: $isCreatePresented)
            }
            .accentColor(.primary)
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
    
    func createLocalNotification(title: String, hour: Int, min: Int, completion: @escaping (Error?) -> Void) {
        var dateComponents = DateComponents()
        dateComponents.hour = hour
        dateComponents.minute = min
        
        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)
        
        let notificationContent = UNMutableNotificationContent()
        notificationContent.title = title
        notificationContent.sound = .default
        notificationContent.body = "some message"
        
        let request = UNNotificationRequest(identifier: UUID().uuidString, content: notificationContent, trigger: trigger)
        
        UNUserNotificationCenter.current().add(request, withCompletionHandler: completion)
    }
    
    func deleteLocalNotifications(identifier: [String]) {
        UNUserNotificationCenter.current()
            .removePendingNotificationRequests(withIdentifiers: identifier)
    }
}

struct CreateNotificationView: View {
    @ObservedObject var notificationManager = NotificationManager()
    @Binding var isPresented: Bool
    @State private var title = ""
    @State private var date = Date()
    
    var body: some View {
        List {
            Section {
                VStack(spacing: 16) {
                    HStack {
                        TextField("Notification Title", text: $title)
                        Spacer()
                        DatePicker("", selection: $date, displayedComponents: [.hourAndMinute])
                    }
                    .padding(.vertical, 8)
                    .padding(.horizontal, 12)
                    .background(Color.white)
                    .cornerRadius(5)
                    
                    Button {
                        let dateComponents = Calendar.current.dateComponents([.hour, .minute], from: date)
                        
                        guard let hour = dateComponents.hour,
                              let min = dateComponents.minute else { return }
                        
                        notificationManager.createLocalNotification(title: title, hour: hour, min: min) { error in
                            if error == nil {
                                DispatchQueue.main.async {
                                    self.isPresented = false
                                }
                            }
                        }
                    } label: {
                        Text("Create")
                            .fontWeight(.semibold)
                            .frame(maxWidth: .infinity)
                            .contentShape(Rectangle())
                    }
                    .padding()
                    .background(Color(.systemGray5))
                    .cornerRadius(5)
                    .buttonStyle(PlainButtonStyle())
                }
                .listRowBackground(Color(.systemGroupedBackground))
            }
        }
        .listStyle(InsetGroupedListStyle())
        .onDisappear(perform: {
            notificationManager.reloadLocalNotifications()
        })
        .navigationTitle("Create")
        .navigationBarItems(trailing: Button {
            isPresented = false
        } label: {
            Image(systemName: "xmark")
                .imageScale(.large)
        })
    }
}

struct InfoOverlayView: View {
    let infoMessage:String
    let buttonTitle: String
    let systemImageName: String
    let action: () -> Void
    
    var body: some View {
        VStack {
            Text(infoMessage)
                .fontWeight(.semibold)
                .frame(maxWidth: .infinity)
                .multilineTextAlignment(.center)
            
            Button {
                action()
            } label: {
                Label(buttonTitle, systemImage: systemImageName)
                
            }
            .padding()
            .background(Color(.systemGray5))
            .cornerRadius(5)
        }.padding()
    }
}

extension Chapter14 {
    func delete(_ indexSet: IndexSet) {
        notificationManager.deleteLocalNotifications(identifier: indexSet.map{ notificationManager.notifications[$0].identifier })
        notificationManager.reloadLocalNotifications()
    }
}
