//
//  CalendarView.swift
//  Ratatouille
//
//  Created by T Krobot on 1/12/23.
//

import UIKit
import FSCalendar
import SwiftUI

struct CalendarView: View {
    @State var selectedDate = Date()
    @State var isHabitCompleted = false
    @State var progress: Double = 0
    var goal: Goal

    var body: some View {
        VStack {
            //displaying selected date
//            FormattedDate(selectedDate: selectedDate, omitTime: true)
            //passing selecteddate as binding
            CalendarViewRepresentable(selectedDate: $selectedDate, goal: goal, isHabitCompleted: $isHabitCompleted)
                .scaledToFit()
        }
    }
}

struct CalendarViewRepresentable: UIViewRepresentable {
    
    typealias UIViewType = FSCalendar
    //creating obj of FSCalendar to track across the view
    fileprivate var calendar = FSCalendar()
    
    @Binding var selectedDate: Date
    var goal: Goal
    @Binding var isHabitCompleted: Bool
    
    //creates uiview that will be rendered on the ui
    func makeUIView(context: Context) -> FSCalendar {
        calendar.delegate = context.coordinator //fixed
        calendar.dataSource = context.coordinator //fixed
//        calendar.appearance.todayColor = UIColor(displayedP3Red: 0, green: 0, blue: 0, alpha: 0)
//        calendar.appearance.titleTodayColor = .black
        calendar.appearance.selectionColor = .gray
        return calendar //fixed
    }
    
    //update state of the view
    func updateUIView (_ uiView: FSCalendar, context: Context) {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyyMMdd"
        let completedDateKeys = goal.completedDates
        uiView.allowsMultipleSelection = true
        

        for dateKey in completedDateKeys {
            if let date = formatter.date(from: dateKey) {
                uiView.select(date) // Mark the completed dates as selected
            }
        }
        if isHabitCompleted {
            uiView.appearance.titleSelectionColor = .white
            uiView.appearance.subtitleSelectionColor = .white
            uiView.appearance.selectionColor =  UIColor(named: "AccentColor")
        } else {
            uiView.appearance.titleSelectionColor = .white
            uiView.appearance.subtitleSelectionColor = .white
            uiView.appearance.selectionColor = .white
        }
        


    }


    
    //create custom instance that is used to communicate btwn swiftui & uikitviews
    func makeCoordinator() -> Coordinator {
        Coordinator(self, selectedDate: $selectedDate, goal: goal, calendar: calendar, isHabitCompleted: $isHabitCompleted)
    }

    //custom instance returned from makeCoordinator
    class Coordinator: NSObject,
          FSCalendarDelegate, FSCalendarDataSource {
        
        var selectedDate: Binding<Date>
        var completedDates: Set<String> = []
        var goal: Goal // Store the habit property
        var calendar: FSCalendar
        var parent: CalendarViewRepresentable
        var isHabitCompleted: Binding<Bool>

        init(_ parent: CalendarViewRepresentable, selectedDate: Binding<Date>, goal: Goal, calendar: FSCalendar, isHabitCompleted: Binding<Bool>) {
            self.selectedDate = selectedDate
            self.goal = goal// Assign the habit property
            self.calendar = calendar
            self.parent = parent
            self.isHabitCompleted = isHabitCompleted
            
            super.init()
            calendar.delegate = self
        }
        
        func calendar(_ calendar: FSCalendar,
                      didSelect date: Date,
                      at monthPosition: FSCalendarMonthPosition) {
            selectedDate.wrappedValue = date
            showHabitCompletionAlert(for: date)
        }
//            var parent: CalendarViewRepresentable
//
//            init(_ parent: CalendarViewRepresentable) {
//                self.parent = parent
//            }

        func calendar(_ calendar: FSCalendar, shouldSelect date: Date, at monthPosition: FSCalendarMonthPosition) -> Bool {
//            if isWeekend(date: date) {
//                return false
//            }
            return true
        }
        func calendar(_ calendar: FSCalendar,
                  imageFor date: Date) -> UIImage? {
//            if isWeekend(date: date) {
//                return UIImage(systemName: "sparkles")
//            }
            return nil
        }
        
        func showHabitCompletionAlert(for date: Date) {
            let alert = UIAlertController(title: "Habit completion",
                                          message: "Did you complete the habit for this day?",
                                          preferredStyle: .alert)
            let formatter = DateFormatter()
            _ = formatter.string(from: date)
            alert.addAction(UIAlertAction(title: "Yes", style: .default, handler: {_ in
                //update habit completion and modify appearance if the habit is completed
                self.isHabitCompleted.wrappedValue = true
                progress = Double(numberOfDaysCompleted) / Double(targetDays)
                if self.isHabitCompletedForDate(date) {
                    self.addCompletionDate(date)
//                    self.updateCalendarAppearanceForCompletionDate(date)
                }
            }))
            
            alert.addAction(UIAlertAction(title: "No", style: .cancel, handler: nil))
            self.isHabitCompleted.wrappedValue = false
            
            if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
                let rootViewController = windowScene.windows.first?.rootViewController {
                rootViewController.present(alert, animated: true, completion: nil)
            }


        }
//        private func updateCalendarAppearanceForCompletionDate(_ date: Date) {
//           let formatter = DateFormatter()
//           formatter.dateFormat = "yyyyMMdd"
//           let selectedDateKey = formatter.string(from: date)
//
//
//            print("Completed Dates: \(habit.completedDates)")
//            print("Selected Date Key: \(selectedDateKey)")
//
//           if habit.completedDates.contains(selectedDateKey) {
//               // Change the appearance when the habit is completed for the selected date
//               self.isHabitCompleted.wrappedValue = true
//               print("Habit is completed for the selected date")
//               self.parent.calendar.appearance.titleSelectionColor = .red
//               self.parent.calendar.appearance.subtitleSelectionColor = .red
//               self.parent.calendar.appearance.selectionColor = .blue
//           }
//            else {
//               // Reset appearance when the habit is not completed for the selected date
//                self.isHabitCompleted.wrappedValue = false
//               print("rhefdjk")
//               self.parent.calendar.appearance.titleSelectionColor = .white
//               self.parent.calendar.appearance.subtitleSelectionColor = .white
//               self.parent.calendar.appearance.selectionColor = .green
//           }
//       }
        private func addCompletionDate(_ date: Date) {
            let formatter = DateFormatter()
            formatter.dateFormat = "yyyyMMdd"
            let dateString = formatter.string(from: date)
            
            goal.completedDates.insert(dateString)
            // Ensure this change in the set is persisted or updated in the source of truth
        }
        
        private func isHabitCompletedForDate(_ date: Date) -> Bool {
            //add logic to check if the habit is completed for the provided date
            let formatter = DateFormatter()
            formatter.dateFormat = "yyyyMMdd"
            
            let dateString = formatter.string(from: date)
            
            return completedDates.contains(dateString)
        }
        

    }
    
    
}


var numberOfDaysCompleted: Int = 0
var progress: Double = 0.0
var targetDays = 0

func calculateTargetDays(for goal: Goal) -> Int {
        let currentDate = Date()
        let calendar = Calendar.current
    
        // Function to check if a date falls within a week
        func isInCurrentWeek(_ date: Date) -> Bool {
            return calendar.isDate(date, equalTo: currentDate, toGranularity: .weekOfYear)
        }
    
        // Function to check if a date falls within a month
        func isInCurrentMonth(_ date: Date) -> Bool {
            return calendar.isDate(date, equalTo: currentDate, toGranularity: .month)
        }
    
    
        switch goal.selectedFrequencyIndex {
        case .daily:
    
            if let deadlineDate = calendar.date(byAdding: .day, value: 1, to: currentDate) {
                let days = calendar.dateComponents([.day], from: currentDate, to: deadlineDate).day ?? 0
                targetDays += max(0, days)
    
            }
        case .weekly:
            let remainingDaysInWeek = calendar.range(of: .day, in: .weekOfYear, for: currentDate)?.count ?? 0
            let remainingWeeksInMonth = calendar.range(of: .weekOfYear, in: .month, for: currentDate)?.count ?? 0
            let weeklyFrequency = 2 // Example: The user wants to achieve twice a week
    
            targetDays += min(remainingDaysInWeek, remainingWeeksInMonth * weeklyFrequency)
        case .monthly:
            if let startOfNextMonth = calendar.date(byAdding: DateComponents(month: 1), to: calendar.startOfDay(for: currentDate)) {
                let remainingDaysInMonth = calendar.range(of: .day, in: .month, for: startOfNextMonth)?.count ?? 0
                let remainingMonthsInYear = calendar.range(of: .month, in: .year, for: currentDate)?.count ?? 0
                let monthlyFrequency = 4 // Example: The user wants to achieve 4 times a month
    
                targetDays += min(remainingDaysInMonth, remainingMonthsInYear * monthlyFrequency)
            }
        case .custom:
    
            // Calculate target days for fixed frequency (e.g., specific dates selected)
            // Replace `selectedDates` with actual array of selected dates from Goal struct
            let selectedDates: [Date] = [] // Placeholder for selected dates
            for date in selectedDates {
                if date >= currentDate {
                    targetDays += 1
                }
            }
        }
        
    return targetDays
}

struct CalendarView_Previews: PreviewProvider {
    static var previews: some View {
//        let sampleHabit = Habit(
//            completedDates: ["20230101", "20230105", "20231101", "20231102"]
//        )
        
        let defaultDate = Date() // Creating a constant for the preview
        
        return CalendarView(selectedDate: defaultDate, goal: Goal(title: "Sample Title", habitTitle: "Sample Habit Title", completedDates: [], deadline: Date(), selectedFrequencyIndex: Goal.frequency.custom, selectedAnimal: Animal(name: "Name of Animal", kind: .cow), motivationalQuote: "imagine the motivational quote", selectedDailyDeadline: Date(), selectedFixedDeadline: Date()))
    }
}
