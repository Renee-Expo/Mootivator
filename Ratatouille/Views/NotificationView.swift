//
//  NotificationView.swift
//  Ratatouille
//
//  Created by Kaveri Mi on 20/11/23.
//

import SwiftUI
import UIKit
import UserNotifications


struct NotificationView: View {
    
    @State private var dailyTracking = false
    @State private var reminderTime = Date()
    @State private var habitDeadline = false
    @State private var goalDeadline = false
    @State private var neutralAnimal = false
    @State private var sadAnimal = false
    
    
    var body: some View {
        NavigationStack{
            Form{
                Section{
                    Toggle("Daily tracking reminder", isOn: $dailyTracking)
                    if dailyTracking {
                        DatePicker("Reminder time", selection: $reminderTime, displayedComponents: [.hourAndMinute])
                            .onChange(of: reminderTime) { _ in
                                scheduleDailyNotification()
                            }
                    }
                }
                
                Section{
                    Toggle("Current habit deadline approached", isOn: $habitDeadline)
                    Toggle("Goal deadline approached", isOn: $goalDeadline)
                    Toggle("Animal feels neutral", isOn: $neutralAnimal)
                    Toggle("Animal feels sad", isOn: $sadAnimal)
                }
            }
            .navigationTitle("Notifications")
            
        }
        .onAppear {
            if dailyTracking {
                scheduleDailyNotification()
            }
        }
    }
    
    private func scheduleDailyNotification() {
        let center = UNUserNotificationCenter.current()
        
        center.removeAllPendingNotificationRequests()

        let content = UNMutableNotificationContent()
        content.title = "Daily Tracking Reminder"
        content.body = "Don't forget to track your daily activities!"
        
        var dateComponents = Calendar.current.dateComponents([.hour, .minute], from: reminderTime)
        dateComponents.second = 0
        
        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)
        
        let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
        
        center.add(request) { error in
            if let error = error {
                print("Error scheduling notification: \(error.localizedDescription)")
            }
        }
    }
}

struct NotificationView_Previews: PreviewProvider {
    static var previews: some View {
        NotificationView()
    }
}
