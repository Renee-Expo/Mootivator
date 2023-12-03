//

//  GoalEditView.swift

//  Ratatouille

//

//  Created by Kaveri Mi on 20/11/23.

//

import SwiftUI

struct GoalEditView: View {
    @ObservedObject var goalManager: GoalManager = .shared
    @ObservedObject var unlockedAnimalManager : UnlockedAnimalManager = .shared
    
    @Environment(\.presentationMode) var presentationMode
    @Environment(\.dismiss) var dismiss
    
    @Binding var goal: Goal
//    @Binding var unlockedAnimals: [AnimalKind]
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
    //
    //    @Binding var customDates : [String: Bool]
    
    @State var selectedAnimalKind = AnimalKind.cow
    var areAllTogglesOff: Bool {
        return !goal.dayState.values.contains(true)
    }
    
    var body: some View {
        NavigationStack {
            List {
                Section("Goal") {
                    TextField("Enter a Goal here", text: $goal.title)
                    DatePicker("Deadline", selection: $goal.deadline, displayedComponents: [.date, .hourAndMinute])
                }
                
//                Section("Pick an Animal") {
//                    NavigationLink("Pick an animal") {
//                        AnimalPickerView(selectedAnimalKind: $selectedAnimalKind)
//                    } // um are you only going to set 2 unlocked? cuz the user will never be able to unlock more...
//                    TextField("Name your animal", text: $goal.selectedAnimal.name)
//                }
                
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
                        
                        HStack {
                            
                            Toggle("M", isOn: Binding<Bool>(get: { goal.dayState[Goal.daysOfTheWeek.monday.text] ?? false }, set: { goal.dayState[Goal.daysOfTheWeek.monday.text] = $0 }))
                            Toggle("T", isOn: Binding<Bool>(get: { goal.dayState[Goal.daysOfTheWeek.tuesday.text] ?? false }, set: { goal.dayState[Goal.daysOfTheWeek.tuesday.text] = $0 }))
                            Toggle("W", isOn: Binding<Bool>(get: { goal.dayState[Goal.daysOfTheWeek.wednesday.text] ?? false }, set: { goal.dayState[Goal.daysOfTheWeek.wednesday.text] = $0 }))
                            Toggle("T", isOn: Binding<Bool>(get: { goal.dayState[Goal.daysOfTheWeek.thursday.text] ?? false }, set: { goal.dayState[Goal.daysOfTheWeek.thursday.text] = $0 }))
                            Toggle("F", isOn: Binding<Bool>(get: { goal.dayState[Goal.daysOfTheWeek.friday.text] ?? false }, set: { goal.dayState[Goal.daysOfTheWeek.friday.text] = $0 }))
                            Toggle("S", isOn: Binding<Bool>(get: { goal.dayState[Goal.daysOfTheWeek.saturday.text] ?? false }, set: { goal.dayState[Goal.daysOfTheWeek.saturday.text] = $0 }))
                            Toggle("S", isOn: Binding<Bool>(get: { goal.dayState[Goal.daysOfTheWeek.sunday.text] ?? false }, set: { goal.dayState[Goal.daysOfTheWeek.sunday.text] = $0 }))
                            
                        }
                        .toggleStyle(.button)
                        
                        DatePicker("Deadline", selection: $goal.selectedFixedDeadline, displayedComponents: [.date, .hourAndMinute])
                    }
                }
                
                Section("Write something to motivate you") {
                    TextField("You can do it!", text: $goal.motivationalQuote)
                }
                
                //                        Button {
                //                if (goal.title.isEmpty ||
                //                    goal.habitTitle.isEmpty ||
                //                    goal.selectedFrequencyIndex == .custom
                //                    && !(goal.dayState[Goal.daysOfTheWeek.wednesday.text] ?? false)
                //                    && !(goal.dayState[Goal.daysOfTheWeek.tuesday.text] ?? false)
                //                    && !(goal.dayState[Goal.daysOfTheWeek.wednesday.text] ?? false)
                //                    && !(goal.dayState[Goal.daysOfTheWeek.thursday.text] ?? false)
                //                    && !(goal.dayState[Goal.daysOfTheWeek.friday.text] ?? false)
                //                    && !(goal.dayState[Goal.daysOfTheWeek.saturday.text] ?? false)
                //                    && !(goal.dayState[Goal.daysOfTheWeek.sunday.text] ?? false)
                //                    || (goal.motivationalQuote.isEmpty)
                //                ) {
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
                    
                    if goal.selectedFrequencyIndex == .daily{
                        goal.scheduledCompletionDates = []
                        let currentDate = Date()
                        var currentDateComponent = Calendar.current.dateComponents([.year, .month, .day], from: currentDate)
                        
                        while let currentDate = Calendar.current.date(from: currentDateComponent), currentDate <= goal.selectedDailyDeadline {
                            goal.scheduledCompletionDates.append(currentDate)
                            currentDateComponent.day! += 1
                        }
                        
                    } else if goal.selectedFrequencyIndex == .custom {
                        
                    }
                    
                    if let index = goalManager.items.firstIndex(where: { $0.id == goal.id }) {
                        goalManager.items[index] = goal
                    } else {
                        goalManager.items.append(goal)
                    }
                    presentationMode.wrappedValue.dismiss()
                } label: {
                    Text("Save")
                }
                .frame(maxWidth: .infinity)
                .disabled(goal.title.isEmpty || goal.habitTitle.isEmpty || goal.selectedAnimal.name.isEmpty || (goal.selectedFrequencyIndex == .custom && areAllTogglesOff) || goal.motivationalQuote.isEmpty)
                
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
                //                } else {
                //                    ZStack{
                //                        Color.accentColor
                //                        Button {
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
                //                            presentationMode.wrappedValue.dismiss()
                //                        } label: {
                //                            Text("Save")
                //                                .foregroundColor(.white)
                //                        }
                //                        .frame(maxWidth: .infinity)
                //                            .background(Color.accentColor)
                //                    }
                //                }
                
            }
        }
    }
}

struct GoalEditView_Previews: PreviewProvider {
    
    static var previews: some View {
        
        let goal = Goal(title: "", habitTitle: "", selectedFrequencyIndex: Goal.frequency.custom, selectedAnimal: Animal(name: "", kind: .cow), motivationalQuote: "", selectedDailyDeadline: .now, selectedFixedDeadline: .now, dayState: [:], completedDates: [], deadline: .now)
        
        GoalEditView(goal: .constant(goal), selectedAnimalKind: .cow)
            .environmentObject(GoalManager())
        
    }
    
}
