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
    /*
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
     */

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
                    } // um are you only going to set 2 unlocked? cuz the user will never be able to unlock more...
                    TextField("Name your animal", text: $goal.selectedAnimal.name)
                }
                
                // there will be an animal to redirect to Animal Picker sheet
                
                Section("Current Habit") {
                    
                    TextField(text: $goal.habitTitle) {
                        Text("Enter a Habit")
                    }
                    
                    Picker("Frequency", selection: $goal.selectedFrequencyIndex) {
                        ForEach(Goal.frequency.allCases, id: \.self) { index in
                            Text(index.text)
                                .tag(index)
                        }
                    }
                }
                
                if goal.selectedFrequencyIndex == .daily {
                    DatePicker("Deadline", selection: $goal.selectedDailyDeadline, displayedComponents: [.date, .hourAndMinute])
                }
                else if goal.selectedFrequencyIndex == .weekly {
                    VStack {
                        Text("Number of times per week: \(Int(goal.numberOfTimesPerWeek.rounded()))")
                        Slider(value: $goal.numberOfTimesPerWeek, in: 1...7, step: 1)
                    }
                }
                else if goal.selectedFrequencyIndex == .monthly {
                    VStack {
                        Text("Number of times per month: \(Int(goal.numberOfTimesPerMonth.rounded()))")
                        Slider(value: $goal.numberOfTimesPerMonth, in: 1...31, step: 1)
                    }
                }
                
                else if goal.selectedFrequencyIndex == .custom {
                    
                    DatePicker("Deadline", selection: $goal.selectedFixedDeadline, displayedComponents: [.date, .hourAndMinute])
                }
                
                Section("Write something to motivate you") {
                    TextField("You can do it!", text: $goal.motivationalQuote)
                }
                
                //                        Button {
                if (goal.title.isEmpty ||
                    goal.habitTitle.isEmpty ||
                    goal.selectedFrequencyIndex == .custom
                    && !(goal.dayState[Goal.daysOfTheWeek.wednesday.text] ?? false)
                    && !(goal.dayState[Goal.daysOfTheWeek.tuesday.text] ?? false)
                    && !(goal.dayState[Goal.daysOfTheWeek.wednesday.text] ?? false)
                    && !(goal.dayState[Goal.daysOfTheWeek.thursday.text] ?? false)
                    && !(goal.dayState[Goal.daysOfTheWeek.friday.text] ?? false)
                    && !(goal.dayState[Goal.daysOfTheWeek.saturday.text] ?? false)
                    && !(goal.dayState[Goal.daysOfTheWeek.sunday.text] ?? false)
                    || (goal.motivationalQuote.isEmpty)
                ) {
//
//                    Button {
//                        goalManager.goals.append(.init(title: goal.title,
//                                                       habitTitle: goal.habitTitle,
//                                                       deadline: goal.deadline,
//                                                       selectedFrequencyIndex: goal.selectedFrequencyIndex,
//                                                       selectedAnimal: goal.selectedAnimal, motivationalQuote: goal.motivationalQuote,
//                                                       selectedDailyDeadline: goal.selectedDailyDeadline,
//                                                       selectedFixedDeadline: goal.selectedFixedDeadline))
//                    } label: {
//                        Text("Save")
//                            .frame(maxWidth: .infinity)
//                    }
                    
                    
                    
                    Button {
                        if let index = goalManager.goals.firstIndex(where: { $0.id == goal.id }) {
                            goalManager.goals[index] = goal
                        } else {
                            goalManager.goals.append(goal)
                        }
                        presentationMode.wrappedValue.dismiss()
                    } label: {
                        Text("Save")
                    }
                    .frame(maxWidth: .infinity)
                    
                    //Button {
//                        // does this work???
////                        goal.daysOfTheWeek.tuesday.state = true
//
//                    } label: {
//                        Text("Save")
//                    }
////                    .disabled(!isButtonEnabled)
//                    .frame(maxWidth: .infinity)
                        
//Handle the case where the button should be disabled
                } else {
                    ZStack{
                        Color.accentColor
                        Button {
//                            isButtonEnabled = true
//                            let newGoal = Goal(
//                                title: title,
//                                habitTitle: habitTitle,
//                                deadline: deadline,
//                                frequency: frequency,
//                                selectedFrequencyIndex: selectedFrequencyIndex,
//                                selectedAnimal: Animal(name: "", kind: selectedAnimalKind),
//                                motivationalQuote: motivationalQuote,
//                                selectedDailyDeadline: selectedDailyDeadline,
//                                selectedFixedDeadline: selectedFixedDeadline,
//                                numberOfTimesPerWeek: Double(numberOfTimesPerWeek),
//                                numberOfTimesPerMonth: Double(numberOfTimesPerMonth)
//                            )
                            
//                            goalManager.goals.append(newGoal)
                            presentationMode.wrappedValue.dismiss()
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

struct GoalEditView_Previews: PreviewProvider {
    
    static var previews: some View {
        
        GoalEditView(goal: .constant(Goal(title: "", habitTitle: "", deadline: .now, selectedFrequencyIndex: Goal.frequency.custom, selectedAnimal: Animal(name: "Name of Animal", kind: .cow), motivationalQuote: "", selectedDailyDeadline: .now, selectedFixedDeadline: .now)), selectedAnimalKind: .cow)
            .environmentObject(GoalManager())
        
    }
    
}
