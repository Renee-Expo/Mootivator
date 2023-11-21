//
//  NewGoalView.swift
//  Ratatouille
//
//  Created by Kaveri Mi on 19/11/23.
//

import SwiftUI

struct NewGoalView: View {
    
    @State private var goalEntered = ""
    @State private var deadline = Date()
    @State private var habitEntered = ""
    @State private var frequencyOfHabits = ""
    @State private var selectedAnimal: Int = 0
    @State var frequency = ["Fixed", "Daily", "Weekly", "Monthly"]
    @State var selectedDays = [String]()
    @State private var motivationalQuote = ""
    @State private var selectedFrequencyIndex = 0
    @State private var selectedDailyDeadline = Date()
    @State private var numberOfTimesPerWeek = 1.0
    @State private var numberOfTimesPerMonth = 1.0
    var days = ["Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday", "Sunday"]
    @State private var selectedFixedDeadline = Date()
    @State private var isSaveButtonDisabled = true
        
    @Binding var sourceArray: [Goal]
    
    var body: some View {
        NavigationStack {
            Form {
                Section("Goal") {
                    TextField("Goals", text: $goalEntered)
                    
                    DatePicker("Deadline", selection: $deadline, displayedComponents: [.date, .hourAndMinute])
                }
                Section("Pick an Animal") {
                    NavigationLink("Pick an animal") {
                        AnimalPickerView()
//                        AnimalPickerView(selection: $selectedAnimal)
                    }
                }

                //there will be an animal to redirect to Animal Picker sheet


                Section("Current Habit") {
                    TextField(text: $habitEntered) {
                        Text("Habit")
                    }
                }
                Picker("Frequency", selection: $selectedFrequencyIndex) {
                    ForEach(0..<frequency.count) { index in
                        Text(frequency[index])
                            .tag(index)
                    }
                }

                if frequency[selectedFrequencyIndex] == "Daily" {
                    DatePicker("Deadline", selection: $selectedDailyDeadline, displayedComponents: [.date, .hourAndMinute])
                } else if frequency[selectedFrequencyIndex] == "Weekly" {
                    VStack {
                        Text("Number of times per week: \(numberOfTimesPerWeek)")
                        Slider(value: $numberOfTimesPerWeek, in: 1...7)
                    }
                } else if frequency[selectedFrequencyIndex] == "Monthly" {
                    VStack {
                        Text("Number of times per month: \(numberOfTimesPerMonth)")
                        Slider(value: $numberOfTimesPerMonth, in: 1...31)
                    }
                } else if frequency[selectedFrequencyIndex] == "Fixed" {
//                    Picker("Days", selection: $selectedDays) {
//                        ForEach(days, id: \.self) {  day in
//                            Text(day)
//                        }
//                    }
                    
//                    MultiSelectPickerView(days: days, selectedDays: $selectedDays)
//                                .onChange(of: days) {
//                                    print(days)
//                                }
                    
                    .pickerStyle(InlinePickerStyle())
                }

                DatePicker("Deadline", selection: $selectedFixedDeadline, displayedComponents: [.date, .hourAndMinute])

                Section("Write something to motivate you") {
                    TextField("You can do it!", text: $motivationalQuote)
                }
            }
        }
        
    }
}


struct NewGoalView_Previews: PreviewProvider {
    static var previews: some View {
        NewGoalView(sourceArray: .constant([]))
    }
}
