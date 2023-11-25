//
//  NotificationView.swift
//  Ratatouille
//
//  Created by Kaveri Mi on 20/11/23.
//

import SwiftUI
import UserNotifications


struct NotificationView: View {
    
    @EnvironmentObject var goalManager: GoalManager
    @EnvironmentObject var habitCompletionStatus: HabitCompletionStatus
    
    @AppStorage("dailyTracking") var dailyTracking = false
    @AppStorage("reminderTime") var reminderTime = Date()
    @AppStorage("habitDeadline") var habitDeadline = false
    @AppStorage("goalDeadline") var goalDeadline = false
    @AppStorage("neutralAnimal") var neutralAnimal = false
    @AppStorage("sadAnimal") var sadAnimal = false
    
    @Binding var deadline : Date
    @Binding var frequency : Array<String>
    @Binding var selectedFrequencyIndex : Int
    @Binding var selectedDailyDeadline : Date
    @Binding var selectedFixedDeadline : Date
    
    
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
            if habitDeadline {
                scheduleGoalDeadlineNotification()
            }
            if goalDeadline {
                scheduleHabitDeadlineNotification()
            }
        }
    }
    
    
    private func dateComponents(for date: Date) -> DateComponents {
            var components = Calendar.current.dateComponents([.year, .month, .day, .hour, .minute], from: date)
            components.second = 0
            return components
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
    
    private func scheduleGoalDeadlineNotification() {
        let center = UNUserNotificationCenter.current()
        
        center.removeAllPendingNotificationRequests()

        if goalDeadline {
            let goalContent = UNMutableNotificationContent()
            goalContent.title = "Goal Deadline Reminder"
            goalContent.body = "Don't forget your goal deadline!"
            
            let goalTrigger = UNCalendarNotificationTrigger(dateMatching: dateComponents(for: deadline), repeats: false)
            
            let goalRequest = UNNotificationRequest(identifier: UUID().uuidString, content: goalContent, trigger: goalTrigger)
            
            center.add(goalRequest) { error in
                if let error = error {
                    print("Error scheduling goal deadline notification: \(error.localizedDescription)")
                }
            }
        }
    }
    
    private func scheduleHabitDeadlineNotification() {
        let center = UNUserNotificationCenter.current()
        
        center.removeAllPendingNotificationRequests()

        if habitDeadline {
            let habitContent = UNMutableNotificationContent()
            habitContent.title = "Habit Deadline Reminder"
            habitContent.body = "Don't forget your habit deadline!"

            var habitTrigger: UNNotificationTrigger?

            switch frequency[selectedFrequencyIndex] {
            case "Daily":
                habitTrigger = UNCalendarNotificationTrigger(dateMatching: dateComponents(for: selectedDailyDeadline), repeats: false)
            case "Fixed":
                habitTrigger = UNCalendarNotificationTrigger(dateMatching: dateComponents(for: selectedFixedDeadline), repeats: false)
            case "Weekly":
                let endOfWeek = Calendar.current.date(bySetting: .weekday, value: 1, of: Date())!
                habitTrigger = UNCalendarNotificationTrigger(dateMatching: dateComponents(for: endOfWeek), repeats: false)
            case "Monthly":
                let endOfMonth = Calendar.current.date(byAdding: DateComponents(month: 1, day: -1), to: Date())!
                habitTrigger = UNCalendarNotificationTrigger(dateMatching: dateComponents(for: endOfMonth), repeats: false)
            default:
                break
            }

            if let habitTrigger = habitTrigger {
                let habitRequest = UNNotificationRequest(identifier: UUID().uuidString, content: habitContent, trigger: habitTrigger)

                center.add(habitRequest) { error in
                    if let error = error {
                        print("Error scheduling habit deadline notification: \(error.localizedDescription)")
                    }
                }
            }
        }
    }
    
    
    
    
}

struct NotificationView_Previews: PreviewProvider {
    static var previews: some View {
        NotificationView(deadline: .constant(Date()), frequency: .constant(["Fixed", "Daily", "Weekly", "Monthly"]), selectedFrequencyIndex: .constant(0), selectedDailyDeadline: .constant(Date()), selectedFixedDeadline: .constant(Date()))
            .environmentObject(GoalManager())
            .environmentObject(HabitCompletionStatus())
    }
}
