//
//  GoalEditView.swift
//  Ratatouille
//
//  Created by Kaveri Mi on 20/11/23.
//
import SwiftUI
struct GoalEditView: View {
    
    // @EnvironmentObject var goalManager: GoalManager
    @Binding var goal: Goal
    @State private var selectedAnimal = 0
    
    var body: some View {
        
        NavigationStack {
            Form {
                Section("Goal") {
                    TextField("Enter a Goal here", text: $goal.goalEntered)
                    DatePicker("Deadline", selection: $goal.deadline, displayedComponents: [.date, .hourAndMinute])
                }
                //FormStyleConfiguration
                Section("Pick an Animal") {
                    NavigationLink("Pick an animal") {
                        AnimalPickerView(selectedAnimal: $selectedAnimal)
                    }
                }
//                there will be an animal to redirect to Animal Picker sheet
                Section("Current Habit") {
                    TextField(text: $goal.habitEntered) {
                        Text("Enter a Habit")
                    }
                    Picker("Frequency", selection: $goal.selectedFrequencyIndex) {
                        ForEach(0..<goal.frequency.count) { index in
                            Text(goal.frequency[index])
                                .tag(index)
                        }
                    }
                }
                if goal.frequency[goal.selectedFrequencyIndex] == "Daily" {
                    DatePicker("Deadline", selection: $goal.selectedDailyDeadline, displayedComponents: [.date, .hourAndMinute])
                }
                
                //formstyleconfiguration
                else if goal.frequency[goal.selectedFrequencyIndex] == "Weekly" {
                    VStack {
                        Text("Number of times per week: \(Double(goal.numberOfTimesPerWeek.rounded()))")
                        Slider(value: $goal.numberOfTimesPerWeek, in: 1...7, step: 1)
                    }
                }
                //formstyleconfiguration
                else if goal.frequency[goal.selectedFrequencyIndex] == "Monthly" {
                    VStack {
                        Text("Number of times per month: \(Double(goal.numberOfTimesPerMonth.rounded()))")
                        Slider(value: $goal.numberOfTimesPerMonth, in: 1...31, step: 1)
                    }
                }
                else if goal.frequency[goal.selectedFrequencyIndex] == "Fixed" {
//                    Picker("Days", selection: $goal.selectedDays) {
//                        ForEach(goal.days, id: \.self) {  goal.day in
//                            Text(goal.day)
//                        }
//                    }
//                    MultiSelectPickerView(days: goal.days, goal.selectedDays: $goal.selectedDays)
//                                .onChange(of: goal.days) {
//                                    print(goal.days)
//                                }
//
//                    .pickerStyle(InlinePickerStyle())
                    //multi-picker isnt working, so we are using "toggle" function instead
                    Toggle("Monday", isOn: $goal.mondayChosen)
                    Toggle("Tuesday", isOn: $goal.tuesdayChosen)
                    Toggle("Wednesday", isOn: $goal.wednesdayChosen)
                    Toggle("Thursday", isOn: $goal.thursdayChosen)
                    Toggle("Friday", isOn: $goal.fridayChosen)
                    Toggle("Saturday", isOn: $goal.saturdayChosen)
                    Toggle("Sunday", isOn: $goal.sundayChosen)
                    DatePicker("Deadline", selection: $goal.selectedFixedDeadline, displayedComponents: [.date, .hourAndMinute])
                }
                Section("Write something to motivate you") {
                    TextField("You can do it!", text: $goal.motivationalQuote)
                }
            }
        }
    }
}
//struct GoalEditView_Previews: PreviewProvider {
//    static var previews: some View {
//        GoalEditView(goal: .constant(Goal()))
//    .environmentObject(GoalManager())
//    }
//}
//

