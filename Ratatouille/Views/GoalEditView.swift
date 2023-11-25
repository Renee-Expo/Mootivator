//

//  GoalEditView.swift

//  Ratatouille

//

//  Created by Kaveri Mi on 20/11/23.

//

import SwiftUI

struct GoalEditView: View {
    @EnvironmentObject var goalManager: GoalManager
    @Binding var goal: Goal
    @State var selectedAnimal : Animal!
    var body: some View {
        NavigationStack {
            Form {
                Section("Goal") {
                    TextField("Enter a Goal here", text: $goal.title)
                    DatePicker("Deadline", selection: $goal.deadline, displayedComponents: [.date, .hourAndMinute])
                }
                
                Section("Pick an Animal") {
                    NavigationLink("Pick an animal") {
                        AnimalPickerView(selectedAnimal: $selectedAnimal)
                    }
                }
                
                // there will be an animal to redirect to Animal Picker sheet
                
                Section("Current Habit") {
                    
                    TextField(text: $goal.habitTitle) {
                        
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
                else if goal.frequency[goal.selectedFrequencyIndex] == "Weekly" {
                    VStack {
                        Text("Number of times per week: \(Int(goal.numberOfTimesPerWeek.rounded()))")
                        Slider(value: $goal.numberOfTimesPerWeek, in: 1...7, step: 1)
                    }
                }
                else if goal.frequency[goal.selectedFrequencyIndex] == "Monthly" {
                    VStack {
                        Text("Number of times per month: \(Int(goal.numberOfTimesPerMonth.rounded()))")
                        Slider(value: $goal.numberOfTimesPerMonth, in: 1...31, step: 1)
                    }
                }
                
                else if goal.frequency[goal.selectedFrequencyIndex] == "Fixed" {
                    
                    DatePicker("Deadline", selection: $goal.selectedFixedDeadline, displayedComponents: [.date, .hourAndMinute])
                }
                
                Section("Write something to motivate you") {
                    TextField("You can do it!", text: $goal.motivationalQuote)
                }
            }
        }
    }
}

struct GoalEditView_Previews: PreviewProvider {
    
    static var previews: some View {
        
        GoalEditView(goal: .constant(Goal(title: "", habitTitle: "", deadline: .now, frequency: [], selectedFrequencyIndex: 0, selectedAnimal: Animal(name: "Name of Animal", kind: .cow), motivationalQuote: "dkfjdkfj", selectedDailyDeadline: .now, selectedFixedDeadline: .now)), selectedAnimal: Animal(name: "Name of Animal", kind: .cow))
            .environmentObject(GoalManager())
        
    }
    
}
