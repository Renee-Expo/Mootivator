//
//  NewGoalView.swift
//  Ratatouille
//
//  Created by Kaveri Mi on 19/11/23.
//
import SwiftUI

struct NewGoalView: View {
    
    @Environment(\.dismiss) var dismiss
    @ObservedObject var goalManager: GoalManager = .shared
    @ObservedObject var unlockedAnimalManager : UnlockedAnimalManager = .shared
    
    @State private var title = ""
    @State private var deadline = Date()
    @State private var habitTitle = ""
    
    @State var selectedAnimal: Animal = Animal(name: "", kind: .cow)
    @State private var motivationalQuote = ""
    @State private var selectedFrequencyIndex = Goal.frequency.custom
    @State private var selectedDailyDeadline = Date()
    @State private var numberOfTimesPerWeek = 1.0
    @State private var daysInWeek = 7
    @State private var numberOfTimesPerMonth = 1.0
    @State private var daysInMonth = 31
    @State private var selectedFixedDeadline = Date()
    @State private var customDates: [String: Bool] = [
        Goal.daysOfTheWeek.monday.text: false,
        Goal.daysOfTheWeek.tuesday.text: false,
        Goal.daysOfTheWeek.wednesday.text: false,
        Goal.daysOfTheWeek.thursday.text: false,
        Goal.daysOfTheWeek.friday.text: false,
        Goal.daysOfTheWeek.saturday.text: false,
        Goal.daysOfTheWeek.sunday.text: false]
    @State private var dailyDaysDifference = 0
    @State private var scheduledCompletionDates: [Date] = []
    var areAllTogglesOff: Bool {
        return !customDates.values.contains(true)
    }
    
    
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
                Section("Goal") {
                    TextField("Enter a Goal here", text: $title)
                    
                    DatePicker("Deadline", selection: $deadline, displayedComponents: [.date, .hourAndMinute])
                }
                
                Section("Pick an Animal") {
                    NavigationLink("Pick an animal") {
                        AnimalPickerView(selectedAnimalKind: $selectedAnimal.kind)
                    }
                    TextField("Name your animal", text: $selectedAnimal.name)
                    
                }
                
                
                
                
                Section("Current Habit") {
                    TextField("Enter a Habit", text: $habitTitle)
                    
                    Picker("Frequency", selection: $selectedFrequencyIndex) {
                        ForEach(Goal.frequency.allCases, id: \.self) { index in
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
                    } else if selectedFrequencyIndex == .custom {
                        HStack {
                            
                            Toggle("M", isOn: Binding<Bool>( get: {customDates[Goal.daysOfTheWeek.monday.text]!},  set: { customDates[Goal.daysOfTheWeek.monday.text] = $0} ))
                            Toggle("T",   isOn: Binding<Bool>( get: {customDates[Goal.daysOfTheWeek.tuesday.text]!},  set: { customDates[Goal.daysOfTheWeek.tuesday.text] = $0} ))
                            Toggle("W", isOn: Binding<Bool>( get: {customDates[Goal.daysOfTheWeek.wednesday.text]!},  set: { customDates[Goal.daysOfTheWeek.wednesday.text] = $0} ))
                            Toggle("T",  isOn: Binding<Bool>( get: {customDates[Goal.daysOfTheWeek.thursday.text]!},  set: { customDates[Goal.daysOfTheWeek.thursday.text] = $0} ))
                            Toggle("F",    isOn: Binding<Bool>( get: {customDates[Goal.daysOfTheWeek.friday.text]!},  set: { customDates[Goal.daysOfTheWeek.friday.text] = $0} ))
                            Toggle("S",  isOn: Binding<Bool>( get: {customDates[Goal.daysOfTheWeek.saturday.text]!},  set: { customDates[Goal.daysOfTheWeek.saturday.text] = $0} ))
                            Toggle("S",    isOn: Binding<Bool>( get: {customDates[Goal.daysOfTheWeek.sunday.text]!},  set: { customDates[Goal.daysOfTheWeek.sunday.text] = $0} ))
                        }
                        .toggleStyle(.button)
                        
                        
                        
                        //                    .toggleStyle(CheckboxToggleStyle())
                        
                        DatePicker("Deadline", selection: $selectedFixedDeadline, displayedComponents: [.date, .hourAndMinute])
                    }
                }
                
                Section("Write something to motivate you") {
                    TextField("You can do it!", text: $motivationalQuote)
                }
                
                
                
                Button {
                    
                    if selectedFrequencyIndex == .daily{
                        let currentDate = Date()
                        var currentDateComponent = Calendar.current.dateComponents([.year, .month, .day], from: currentDate)
                        
                        while let currentDate = Calendar.current.date(from: currentDateComponent), currentDate <= selectedDailyDeadline {
                            scheduledCompletionDates.append(currentDate)
                            currentDateComponent.day! += 1
                        }
                        
                    } else if selectedFrequencyIndex == .custom {
                        
                    }
                    
                    
                    dailyDaysDifference = Calendar.current.dateComponents([.day], from: Date(), to: selectedDailyDeadline).day ?? 0
                    //                    print (dailyDaysDifference)
                    goalManager.items.append(.init(title: title,
                                                   habitTitle: habitTitle,
                                                   selectedFrequencyIndex: selectedFrequencyIndex,
                                                   selectedAnimal: selectedAnimal, motivationalQuote: motivationalQuote,
                                                   selectedDailyDeadline: selectedDailyDeadline,
                                                   selectedFixedDeadline: selectedFixedDeadline, numberOfTimesPerWeek: numberOfTimesPerWeek, numberOfTimesPerMonth: numberOfTimesPerMonth, dayState: customDates, dailyDaysDifference: dailyDaysDifference, scheduledCompletionDates: scheduledCompletionDates))
                    print (scheduledCompletionDates)
                    
                    
                    dismiss()
                } label: {
                    Text("Save")
                        .frame(maxWidth: .infinity)
                }
                .disabled(title.isEmpty || habitTitle.isEmpty || selectedAnimal.name.isEmpty || (selectedFrequencyIndex == .custom && areAllTogglesOff) || motivationalQuote.isEmpty)
                
            }
        }
    }
}


struct NewGoalView_Previews: PreviewProvider {
    static var previews: some View {
        NewGoalView()
    }
}


