//
//  NotificationView.swift
//  Ratatouille
//
//  Created by Kaveri Mi on 20/11/23.
//

import SwiftUI
import UserNotifications

struct NotificationView: View {
    
    @ObservedObject var goalManager: GoalManager = .shared
    
    @AppStorage("dailyTracking") var dailyTracking = false
    @AppStorage("reminderTime") var reminderTime = Date()
    @AppStorage("habitDeadline") var habitDeadline = false
    @AppStorage("goalDeadline") var goalDeadline = false
    @AppStorage("neutralAnimal") var neutralAnimal = false
    @AppStorage("sadAnimal") var sadAnimal = false
    
    @Binding var goal: Goal
    
    var body: some View {
        NavigationStack {
            Form {
                Section {
                    Toggle("Daily tracking reminder", isOn: $dailyTracking)
                    if dailyTracking {
                        DatePicker("Reminder time", selection: $reminderTime, displayedComponents: [.hourAndMinute])
                            .onChange(of: reminderTime) { _ in
                                scheduleDailyNotification()
                            }
                    }
                }
                
                Section {
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

            // Schedule animal emotion notifications based on toggle state
            if neutralAnimal {
                scheduleAnimalEmotionNotification(emotion: Emotion.neutral)
            }

            if sadAnimal {
                scheduleAnimalEmotionNotification(emotion: Emotion.sad)
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
    
    private func scheduleGoalDeadlineNotification() {
        let center = UNUserNotificationCenter.current()
        
        center.removeAllPendingNotificationRequests()

        if goalDeadline {
            let goalContent = UNMutableNotificationContent()
            goalContent.title = "Goal Deadline Reminder"
            goalContent.body = "Don't forget your goal deadline!"
            
            let goalTrigger = UNCalendarNotificationTrigger(dateMatching: dateComponents(for: goal.deadline), repeats: false)
            
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
            habitContent.body = "Your deadline for \(goal.habitTitle) is reaching soon. Remember check in to complete it today!"

            var habitTrigger: UNNotificationTrigger?

            switch goal.selectedFrequencyIndex {
            case .daily:
                habitTrigger = UNCalendarNotificationTrigger(dateMatching: dateComponents(for: goal.selectedDailyDeadline), repeats: false)
//            case .custom:
//                habitTrigger = UNCalendarNotificationTrigger(dateMatching: dateComponents(for: goal.selectedFixedDeadline), repeats: false)
            case .weekly:
                let endOfWeek = Calendar.current.date(bySetting: .weekday, value: 1, of: Date())!
                habitTrigger = UNCalendarNotificationTrigger(dateMatching: dateComponents(for: endOfWeek), repeats: false)
            case .monthly:
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
    
    private func dateComponents(for date: Date) -> DateComponents {
        var components = Calendar.current.dateComponents([.year, .month, .day, .hour, .minute], from: date)
        components.second = 0
        return components
    }
    
    private func scheduleAnimalEmotionNotification(emotion: Emotion) {
        guard emotion != .happy else {
            // Skip scheduling notification for happy emotion
            return
        }

        let center = UNUserNotificationCenter.current()

        let content = UNMutableNotificationContent()
        content.title = "\(goal.selectedAnimal.name) is feeling \(emotion.text)..."
        content.body = "Your animal is feeling \(emotion.text). Quick, complete your habit!!"

        // Use the selected animal's emotion to determine the appropriate image or other content
        // Modify this part based on your actual implementation for handling animal emotions

        // Use different identifiers for neutral and sad notifications
        let identifier = emotion == .neutral ? "NeutralAnimalNotification" : "SadAnimalNotification"

        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false)  // Adjust the time interval as needed

        let request = UNNotificationRequest(identifier: identifier, content: content, trigger: trigger)

        center.add(request) { error in
            if let error = error {
                print("Error scheduling animal emotion notification: \(error.localizedDescription)")
            }
        }
    }
}

struct NotificationView_Previews: PreviewProvider {
    static var previews: some View {
        
        let goal = Goal(title: "Sample Title", habitTitle: "Sample Habit Title", selectedFrequencyIndex: Goal.frequency.daily, selectedAnimal: Animal(name: "Name of Animal", kind: .cow), motivationalQuote: "imagine the motivational quote", selectedDailyDeadline: Date(), selectedFixedDeadline: Date(), completedDates: [], deadline: Date())
        
        return NavigationStack {
            NotificationView(goal: .constant(goal))
        }
    }
}
