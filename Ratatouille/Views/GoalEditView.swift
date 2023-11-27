//

//  GoalEditView.swift

//  Ratatouille

//

//  Created by Kaveri Mi on 20/11/23.

//

import SwiftUI

struct GoalEditView: View {
    @EnvironmentObject var goalManager: GoalManager
    @Environment(\.presentationMode) var presentationMode
    @Environment(\.dismiss) var dismiss
    @Binding var goal: Goal
    @Binding var title : String
    @Binding var habitTitle : String
    @Binding var frequency : Array<String>
    @Binding var selectedFrequencyIndex : Int
    @Binding var mondayChosen : Bool
    @Binding var tuesdayChosen : Bool
    @Binding var wednesdayChosen : Bool
    @Binding var thursdayChosen : Bool
    @Binding var fridayChosen : Bool
    @Binding var saturdayChosen : Bool
    @Binding var sundayChosen : Bool
    @Binding var motivationalQuote : String
    @Binding var isButtonEnabled : Bool
    @Binding var deadline : Date
    @Binding var selectedDailyDeadline : Date
    @Binding var selectedFixedDeadline : Date
    @Binding var numberOfTimesPerWeek : Double
    @Binding var numberOfTimesPerMonth : Double
    @Binding var selectedAnimal : Animal

    @State var selectedAnimalKind = AnimalKind.cow
    var body: some View {
        NavigationStack {
            List {
                Section("Goal") {
                    TextField("Enter a Goal here", text: $goal.title)
                    DatePicker("Deadline", selection: $goal.deadline, displayedComponents: [.date, .hourAndMinute])
                }
                
                Section("Pick an Animal") {
                    NavigationLink("Pick an animal") {
                        AnimalPickerView(selectedAnimalKind: $selectedAnimalKind, unlockedAnimals: [.cow, .sheep])
                    }
                }
                
                // there will be an animal to redirect to Animal Picker sheet
                
                Section("Current Habit") {
                    
                    TextField(text: $goal.habitTitle) {
                        
                        Text("Enter a Habit")
                        
                    }
                    
                    Picker("Frequency", selection: $goal.selectedFrequencyIndex) {
                        ForEach(0..<goal.frequency.count - 1) { index in
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
                
                {
                    //                        Button {
                    if title.isEmpty || habitTitle.isEmpty ||  (frequency[selectedFrequencyIndex] == "Fixed" && !mondayChosen && !tuesdayChosen && !wednesdayChosen && !thursdayChosen && !fridayChosen && !saturdayChosen && !sundayChosen) || motivationalQuote.isEmpty {
                        Button{
                            
                        }label:{
                            Text("Save")
                        }
                        .disabled(!isButtonEnabled)
                        .frame(maxWidth: .infinity)
                        //Handle the case where the button should be disabled
                    } else {
                        ZStack{
                            Color.accentColor
                            Button {
                                isButtonEnabled = true
                                let newGoal = Goal(
                                    title: title,
                                    habitTitle: habitTitle,
                                    deadline: deadline,
                                    frequency: frequency,
                                    selectedFrequencyIndex: selectedFrequencyIndex,
                                    selectedAnimal: Animal(name: "", kind: selectedAnimalKind),
                                    motivationalQuote: motivationalQuote,
                                    selectedDailyDeadline: selectedDailyDeadline,
                                    selectedFixedDeadline: selectedFixedDeadline,
                                    numberOfTimesPerWeek: Double(numberOfTimesPerWeek),
                                    numberOfTimesPerMonth: Double(numberOfTimesPerMonth)
                                )
                                goalManager.goals.append(newGoal)
                                presentationMode.wrappedValue.dismiss()
                                //                            }
                                //                        } label: {
                                //                            Text("Save")
                                //                        }
                                //                        .disabled(!isButtonEnabled)
                                //                        .frame(maxWidth: .infinity)
                            } label: {
                                Text("Save")
                                    .foregroundColor(.white)
                            }
                            .frame(maxWidth: .infinity)
                            //                            .background(Color.accentColor)
                        }
                    }
                }
                
            }
        }
    }
}

struct GoalEditView_Previews: PreviewProvider {
    
    static var previews: some View {
        
        GoalEditView(goal: .constant(Goal(title: "", habitTitle: "", deadline: .now, frequency: [], selectedFrequencyIndex: 0, selectedAnimal: Animal(name: "Name of Animal", kind: .cow), motivationalQuote: "", selectedDailyDeadline: .now, selectedFixedDeadline: .now)), selectedAnimalKind: .cow)
            .environmentObject(GoalManager())
        
    }
    
}
