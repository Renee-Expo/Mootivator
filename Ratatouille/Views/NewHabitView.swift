//
//  NewHabitView.swift
//  Ratatouille
//
//  Created by T Krobot on 8/12/23.
//

import SwiftUI

struct NewHabitView: View {
    @Environment(\.dismiss) var dismiss
    @ObservedObject var goalManager: GoalManager = .shared
    
    @Binding var goal : Goal
    @State private var habitTitle = ""
    @State private var selectedFrequencyIndex = Habit.frequency.daily
    @State private var selectedDailyDeadline = Date()
    @State private var numberOfTimesPerWeek = 1.0
    @State private var daysInWeek = 7
    @State private var numberOfTimesPerMonth = 1.0
    @State private var daysInMonth = 31
//    @State private var selectedFixedDeadline = Date()
//    @State private var customDates: [String: Bool] = [
//        Goal.daysOfTheWeek.monday.text: false,
//        Goal.daysOfTheWeek.tuesday.text: false,
//        Goal.daysOfTheWeek.wednesday.text: false,
//        Goal.daysOfTheWeek.thursday.text: false,
//        Goal.daysOfTheWeek.friday.text: false,
//        Goal.daysOfTheWeek.saturday.text: false,
//        Goal.daysOfTheWeek.sunday.text: false]
    @State private var dailyDaysDifference = 0
    @State private var scheduledCompletionDates: [Date] = []
    
//    var areAllTogglesOff: Bool {
//        return !customDates.values.contains(true)
//    }
    
    
    func isLastDayOfMonth() -> Bool {
            let currentDate = Date()
            let calendar = Calendar.current
            let day = calendar.component(.day, from: currentDate)
            let lastDayOfMonth = calendar.range(of: .day, in: .month, for: currentDate)?.count ?? 0

            return day == lastDayOfMonth
        }
    
    
    var body: some View {
        NavigationStack {
            List{
                Section("Current Habit") {
                    TextField("Enter a Habit", text: $habitTitle)
                    
                    Picker("Frequency", selection: $selectedFrequencyIndex) {
                        ForEach(Habit.frequency.allCases, id: \.self) { index in
                            Text(index.text)
                                .tag(index)
                        }
                    }
                    
                    
                    if selectedFrequencyIndex == .daily {
                        DatePicker("Deadline", selection: $selectedDailyDeadline, displayedComponents: [.date, .hourAndMinute])
                        
                        
                        
                    } else if selectedFrequencyIndex == .weekly {
                        VStack {
                            Text("Number of times per remaining week: \(Int(numberOfTimesPerWeek.rounded()))")
                            
                            if Calendar.current.component(.weekday, from: Date()) != 7 {
                                Slider(value: $numberOfTimesPerWeek, in: 1.0...Double(daysInWeek).rounded(.up), step: 1)
                            }
                        }
                        .onAppear {
                            let currentDay = Calendar.current.component(.weekday, from: Date())
                            daysInWeek = daysInWeek - currentDay
                            
                            // Set numberOfTimesPerWeek to 1 only on Saturdays
                            if currentDay == 7 {
                                numberOfTimesPerWeek = 1
                            }
                        }
                    } else if selectedFrequencyIndex == .monthly {
                        VStack {
                            Text("Number of times per remaining month: \(Int(numberOfTimesPerMonth.rounded(.up)))")
                            if !isLastDayOfMonth(){
                                Slider(value: $numberOfTimesPerMonth, in: 1...Double(daysInMonth), step: 1)
                            }
                        }
                        .onAppear {
                            // Calculate the number of days left in the current month
                            if let lastDayOfMonth = Calendar.current.range(of: .day, in: .month, for: Date())?.count {
                                daysInMonth = lastDayOfMonth - Calendar.current.component(.day, from: Date()) + 1
                            }
                            if isLastDayOfMonth() {
                                        numberOfTimesPerMonth = 1
                                    }
                        }
//                    } else if selectedFrequencyIndex == .custom {
//                        HStack {
//
//                            Toggle("M", isOn: Binding<Bool>( get: {customDates[Goal.daysOfTheWeek.monday.text]!},  set: { customDates[Goal.daysOfTheWeek.monday.text] = $0} ))
//                            Toggle("T",   isOn: Binding<Bool>( get: {customDates[Goal.daysOfTheWeek.tuesday.text]!},  set: { customDates[Goal.daysOfTheWeek.tuesday.text] = $0} ))
//                            Toggle("W", isOn: Binding<Bool>( get: {customDates[Goal.daysOfTheWeek.wednesday.text]!},  set: { customDates[Goal.daysOfTheWeek.wednesday.text] = $0} ))
//                            Toggle("T",  isOn: Binding<Bool>( get: {customDates[Goal.daysOfTheWeek.thursday.text]!},  set: { customDates[Goal.daysOfTheWeek.thursday.text] = $0} ))
//                            Toggle("F",    isOn: Binding<Bool>( get: {customDates[Goal.daysOfTheWeek.friday.text]!},  set: { customDates[Goal.daysOfTheWeek.friday.text] = $0} ))
//                            Toggle("S",  isOn: Binding<Bool>( get: {customDates[Goal.daysOfTheWeek.saturday.text]!},  set: { customDates[Goal.daysOfTheWeek.saturday.text] = $0} ))
//                            Toggle("S",    isOn: Binding<Bool>( get: {customDates[Goal.daysOfTheWeek.sunday.text]!},  set: { customDates[Goal.daysOfTheWeek.sunday.text] = $0} ))
//                        }
//                        .toggleStyle(.button)
//
                    }
//                    if selectedFrequencyIndex != .daily {
//                        DatePicker("Deadline", selection: $selectedFixedDeadline, displayedComponents: [.date, .hourAndMinute])
//                    }
                }
                Button {
                    
                    if selectedFrequencyIndex == .daily {
                        let currentDate = Date()
                        var currentDateComponent = Calendar.current.dateComponents([.year, .month, .day], from: currentDate)
                        
                        while let currentDate = Calendar.current.date(from: currentDateComponent), currentDate <= selectedDailyDeadline {
                            scheduledCompletionDates.append(currentDate)
                            currentDateComponent.day! += 1
                        }
                        
                    } /*else if selectedFrequencyIndex == .custom {
                        
                    }*/
                    
                    
                    dailyDaysDifference = Calendar.current.dateComponents([.day], from: Date(), to: selectedDailyDeadline).day ?? 0
                    let newHabit = createNewHabit(title: habitTitle, selectedFrequencyIndex: selectedFrequencyIndex, selectedDailyDeadline: selectedDailyDeadline, numberOfTimesPerWeek: numberOfTimesPerWeek, numberOfTimesPerMonth: numberOfTimesPerMonth, completedDates: [])
                    goal.habit = newHabit
                    goal.habit.completedDates = []
                    self.goal = goal
                    print("\(goal.habit)")
                    print("completed dates of current goal: \(goal.habit.completedDates)")
                    //                    print (dailyDaysDifference)
//                    goalManager.items.append(Goal(title: title,
//                                                  habitTitle: habitTitle,
//                                                  selectedFrequencyIndex: selectedFrequencyIndex,
//                                                  selectedAnimal: selectedAnimal,
//                                                  motivationalQuote: motivationalQuote,
//                                                  selectedDailyDeadline: selectedDailyDeadline,
//                                                  numberOfTimesPerWeek: numberOfTimesPerWeek,
//                                                  numberOfTimesPerMonth: numberOfTimesPerMonth,
//                                                  dayState: customDates,
//                                                  scheduledCompletionDates: scheduledCompletionDates,
//                                                  completedDates: [],
//                                                  deadline: deadline))
//                    print (scheduledCompletionDates)
                    
                    
                    dismiss()
                } label: {
                    Text("Save")
                        .frame(maxWidth: .infinity)
                }
                .disabled(habitTitle.isEmpty)
                
            }
        }
    }
}

struct NewHabitView_Previews: PreviewProvider {
    static var previews: some View {
        
        let goal = Goal(title: "", habit: Habit(habitTitle: "", selectedFrequencyIndex: Habit.frequency.daily, selectedDailyDeadline: Date(), completedDates: []), selectedAnimal: Animal(name: "Name of Animal", kind: .cow), motivationalQuote: "imagine the motivational quote",deadline: Date())
        
        NewHabitView(goal: .constant(goal))
    }
}
