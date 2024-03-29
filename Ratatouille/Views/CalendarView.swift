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
    @Binding var goal: Goal
    
    var body: some View {
        VStack {
            //passing selecteddate as binding
            CalendarViewRepresentable(selectedDate: $selectedDate, goal: $goal, isHabitCompleted: $isHabitCompleted, completedDates: $goal.habit.completedDates)
        }
    }
}

struct CalendarViewRepresentable: UIViewRepresentable {
    
    typealias UIViewType = FSCalendar
    //creating obj of FSCalendar to track across the view
    fileprivate var calendar = FSCalendar()
    
    @Binding var selectedDate: Date
    @Binding var goal: Goal
    @Binding var isHabitCompleted: Bool
    @Binding var completedDates: Set<String> 
//    @State private var selectedDates: [Date] = []
    
    //creates uiview that will be rendered on the ui
    func makeUIView(context: Context) -> FSCalendar {
        calendar.delegate = context.coordinator //fixed
        calendar.dataSource = context.coordinator //fixed//        calendar.appearance.selectionColor = .gray
        return calendar //fixed
    }
    
    //update state of the view
    func updateUIView(_ uiView: FSCalendar, context: Context) -> Void {
    
        
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyyMMdd"
        uiView.allowsMultipleSelection = true
        
        let completedDateKeys = goal.habit.completedDates
        for dateKey in completedDateKeys {
            if let date = formatter.date(from: dateKey) {
                uiView.select(date) // Mark the completed dates as selected
            }
        }
        
        // Assuming `previouslySelectedDates` contains previously selected dates

        let previouslySelectedDates = uiView.selectedDates.filter { date in
            !completedDateKeys.contains(formatter.string(from: date))
        }

        for date in previouslySelectedDates {
            uiView.deselect(date)
        }

        
        uiView.appearance.titleSelectionColor = .white
        uiView.appearance.subtitleSelectionColor = .white
        uiView.appearance.selectionColor =  UIColor(named: "AccentColor")
        uiView.appearance.titleDefaultColor = UIColor(named: "DynamicTextColor")
        uiView.appearance.weekdayTextColor = UIColor(named: "AccentColor")
        uiView.appearance.headerTitleColor = UIColor(named: "AccentColor")
        
        uiView.appearance.todayColor = UIColor(named: "BackgroundColors")
        uiView.appearance.titleTodayColor = UIColor(named: "DynamicTextColor")
        // Reload data to reset appearance
        // Set the current page to the current month
        let currentDate = Date()
        uiView.setCurrentPage(currentDate, animated: false)
        print(goal.habit.completedDates)
        print(completedDateKeys)
        
    }

    
    //create custom instance that is used to communicate btwn swiftui & uikitviews
    func makeCoordinator() -> Coordinator {
        Coordinator(self, selectedDate: $selectedDate, goal: $goal, calendar: calendar, isHabitCompleted: $isHabitCompleted)
    }
    
    //custom instance returned from makeCoordinator
    class Coordinator: NSObject,
                       FSCalendarDelegate, FSCalendarDataSource {
        
        var selectedDate: Binding<Date>
        var goal: Binding<Goal>/// Store the habit property
        var calendar: FSCalendar
        var parent: CalendarViewRepresentable
        var isHabitCompleted: Binding<Bool>
        
        init(_ parent: CalendarViewRepresentable, selectedDate: Binding<Date>, goal: Binding<Goal>, calendar: FSCalendar, isHabitCompleted: Binding<Bool>) {
            self.selectedDate = selectedDate
            
            self.goal = goal 
            self.calendar = calendar
            self.parent = parent
            self.isHabitCompleted = isHabitCompleted
            
            super.init()
            calendar.delegate = self
        }
        
        func calendar(_ calendar: FSCalendar, didDeselect date: Date, at monthPosition: FSCalendarMonthPosition) {
            if isHabitCompletedForDate(date) {
                deleteCompletionDate(date)

            }
        }
        func calendar(_ calendar: FSCalendar,
                      didSelect date: Date,
                      at monthPosition: FSCalendarMonthPosition) {
            selectedDate.wrappedValue = date
            if !isHabitCompletedForDate(date) {
                showHabitCompletionAlert(for: date)
            }
        }
        func showHabitCompletionAlert(for date: Date) {
            // Ensure the calendar is updated before checking if the date is in the future
            self.calendar.deselect(date)
            self.isHabitCompleted.wrappedValue = false

            // Check if the selected date is in the future
            guard date <= Date() else {
                // If the selected date is in the future, do nothing
                return
            }

            // The rest of your code for showing the habit completion alert
            let alert = UIAlertController(title: "Habit completion",
                                          message: "Did you complete the habit for this day?",
                                          preferredStyle: .alert)
            let formatter = DateFormatter()
            _ = formatter.string(from: date)
            alert.addAction(UIAlertAction(title: "Yes", style: .default, handler: { _ in
                // Update habit completion and modify appearance if the habit is completed
                if !self.isHabitCompletedForDate(date) {
                    self.addCompletionDate(date)
                }
            }))

            alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))

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
        func addCompletionDate(_ date: Date) {
            let formatter = DateFormatter()
            formatter.dateFormat = "yyyyMMdd"
            let dateString = formatter.string(from: date)
            
            goal.habit.wrappedValue.completedDates.insert(dateString)
//            goal.wrappedValue.numberOfDaysCompleted += 1
            goal.wrappedValue.selectedAnimal.emotion = updateEmotion(goal: goal.wrappedValue, increment: true)
            // Ensure this change in the set is persisted or updated in the source of truth
        }
        
        func deleteCompletionDate(_ date: Date) {
            let formatter = DateFormatter()
            formatter.dateFormat = "yyyyMMdd"
            let dateString = formatter.string(from: date)
            
            goal.habit.wrappedValue.completedDates.remove(dateString)
//            goal.wrappedValue.numberOfDaysCompleted -= 1
            goal.wrappedValue.selectedAnimal.emotion = updateEmotion(goal: goal.wrappedValue, increment: false)
        }
        
        func isHabitCompletedForDate(_ date: Date) -> Bool {
            //add logic to check if the habit is completed for the provided date
            let formatter = DateFormatter()
            formatter.dateFormat = "yyyyMMdd"
            let dateString = formatter.string(from: date)
            
            return goal.habit.wrappedValue.completedDates.contains(dateString)
        }
        
        func updateEmotion(goal: Goal, increment: Bool) -> Emotion {
            var stuff : Emotion {
                switch goal.selectedAnimal.emotion {
                case .happy     : return (increment ? .happy    : .neutral)
                case .neutral   : return (increment ? .happy    : .sad)
                case .sad       : return (increment ? .neutral  : .sad)
                }
            }
            
            return stuff
        }
        
        func calculateDatesCompleted(goal: Goal) -> Int {
            // get current date
            let formatter = DateFormatter()
            formatter.dateFormat = "yyyyMMdd"
            let today = formatter.string(from: Date()) // current date
            
            if let lastDate = goal.habit.completedDates.sorted(by: { $1 > $0 }).last {
                return Int(today)! - Int(lastDate)!
            } else {
                return 0
            }
        }
        
        
    }
    
    
}

struct CalendarView_Previews: PreviewProvider {
    static var previews: some View {
        //        let sampleHabit = Habit(
        //            completedDates: ["20230101", "20230105", "20231101", "20231102"]
        //        )
        
        let defaultDate = Date() // Creating a constant for the preview
        
        let goal = Goal(title: "Sample Title", habit: Habit(habitTitle: "Sample Habit", selectedFrequencyIndex: Habit.frequency.daily, selectedDailyDeadline: Date(), completedDates: []), selectedAnimal: Animal(name: "Name of Animal", kind: .cow), motivationalQuote: "imagine the motivational quote",deadline: Date())
        
        return CalendarView(selectedDate: defaultDate, goal: .constant(goal))
    }
}
