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
            uiView.appearance.selectionColor =  UIColor(named: "AccentColor")
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
                if self.isHabitCompletedForDate(date) {
                    self.addCompletionDate(date)
//                    self.updateCalendarAppearanceForCompletionDate(date)
                }
            }))
            
            alert.addAction(UIAlertAction(title: "No", style: .cancel, handler: nil))
            
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

struct CalendarView_Previews: PreviewProvider {
    static var previews: some View {
//        let sampleHabit = Habit(
//            completedDates: ["20230101", "20230105", "20231101", "20231102"]
//        )
        
        let defaultDate = Date() // Creating a constant for the preview
        
        return CalendarView(selectedDate: defaultDate, goal: Goal(title: "Sample Title", habitTitle: "Sample Habit Title", completedDates: [], deadline: Date(), selectedFrequencyIndex: Goal.frequency.custom, selectedAnimal: Animal(name: "Name of Animal", kind: .cow), motivationalQuote: "imagine the motivational quote", selectedDailyDeadline: Date(), selectedFixedDeadline: Date()))
    }
}
