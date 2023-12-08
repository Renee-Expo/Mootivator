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
    
    @State var workingGoal : Goal
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
        return !workingGoal.dayState.values.contains(true)
    }
    
    var body: some View {
        NavigationStack {
            List {
                Section("Goal") {
                    TextField("Enter a Goal here", text: $workingGoal.title)
                    DatePicker("Deadline", selection: $workingGoal.deadline, displayedComponents: [.date, .hourAndMinute])
                }
                
//                Section("Pick an Animal") {
//                    NavigationLink("Pick an animal") {
//                        AnimalPickerView(selectedAnimalKind: $selectedAnimalKind)
//                    } // um are you only going to set 2 unlocked? cuz the user will never be able to unlock more...
//                    TextField("Name your animal", text: $workingGoal.selectedAnimal.name)
//                }
                
                // there will be an animal to redirect to Animal Picker sheet
                
                Section("Current Habit") {
                    
                    TextField(text: $workingGoal.habit.title) {
                        Text("Enter a Habit")
                    }
                    
                    Picker("Frequency", selection: $workingGoal.habit.selectedFrequencyIndex) {
                        ForEach(Habit.frequency.allCases, id: \.self) { index in
                            Text(index.text)
                                .tag(index)
                        }
                    }
                    
                    
                    if workingGoal.habit.selectedFrequencyIndex == .daily {
                        DatePicker("Deadline", selection: $workingGoal.habit.selectedDailyDeadline, displayedComponents: [.date, .hourAndMinute])
                    }
                    else if workingGoal.habit.selectedFrequencyIndex == .weekly {
                        VStack {
                            Text("Number of times per week: \(Int(workingGoal.habit.numberOfTimesPerWeek.rounded()))")
                            Slider(value: $workingGoal.habit.numberOfTimesPerWeek, in: 1...7, step: 1)
                        }
                    }
                    else if workingGoal.habit.selectedFrequencyIndex == .monthly {
                        VStack {
                            Text("Number of times per month: \(Int(workingGoal.habit.numberOfTimesPerMonth.rounded()))")
                            Slider(value: $workingGoal.habit.numberOfTimesPerMonth, in: 1...31, step: 1)
                        }
                    }
                    
//                    else if workingGoal.selectedFrequencyIndex == .custom {
//                        
//                        HStack {
//                            
//                            Toggle("M", isOn: Binding<Bool>(get: { workingGoal.dayState[workingGoal.daysOfTheWeek.monday.text] ?? false }, set: { workingGoal.dayState[workingGoal.daysOfTheWeek.monday.text] = $0 }))
//                            Toggle("T", isOn: Binding<Bool>(get: { workingGoal.dayState[workingGoal.daysOfTheWeek.tuesday.text] ?? false }, set: { workingGoal.dayState[workingGoal.daysOfTheWeek.tuesday.text] = $0 }))
//                            Toggle("W", isOn: Binding<Bool>(get: { workingGoal.dayState[workingGoal.daysOfTheWeek.wednesday.text] ?? false }, set: { workingGoal.dayState[workingGoal.daysOfTheWeek.wednesday.text] = $0 }))
//                            Toggle("T", isOn: Binding<Bool>(get: { workingGoal.dayState[workingGoal.daysOfTheWeek.thursday.text] ?? false }, set: { workingGoal.dayState[workingGoal.daysOfTheWeek.thursday.text] = $0 }))
//                            Toggle("F", isOn: Binding<Bool>(get: { workingGoal.dayState[workingGoal.daysOfTheWeek.friday.text] ?? false }, set: { workingGoal.dayState[workingGoal.daysOfTheWeek.friday.text] = $0 }))
//                            Toggle("S", isOn: Binding<Bool>(get: { workingGoal.dayState[workingGoal.daysOfTheWeek.saturday.text] ?? false }, set: { workingGoal.dayState[workingGoal.daysOfTheWeek.saturday.text] = $0 }))
//                            Toggle("S", isOn: Binding<Bool>(get: { workingGoal.dayState[workingGoal.daysOfTheWeek.sunday.text] ?? false }, set: { workingGoal.dayState[workingGoal.daysOfTheWeek.sunday.text] = $0 }))
//                            
//                        }
//                        .toggleStyle(.button)
                        
//                        DatePicker("Deadline", selection: $workingGoal.selectedFixedDeadline, displayedComponents: [.date, .hourAndMinute])
//                    }
                }
                
                Section("Write something to motivate you") {
                    TextField("You can do it!", text: $workingGoal.motivationalQuote)
                }
                
                //                        Button {
                //                if (workingGoal.title.isEmpty ||
                //                    workingGoal.habitTitle.isEmpty ||
                //                    workingGoal.selectedFrequencyIndex == .custom
                //                    && !(workingGoal.dayState[workingGoal.daysOfTheWeek.wednesday.text] ?? false)
                //                    && !(workingGoal.dayState[workingGoal.daysOfTheWeek.tuesday.text] ?? false)
                //                    && !(workingGoal.dayState[workingGoal.daysOfTheWeek.wednesday.text] ?? false)
                //                    && !(workingGoal.dayState[workingGoal.daysOfTheWeek.thursday.text] ?? false)
                //                    && !(workingGoal.dayState[workingGoal.daysOfTheWeek.friday.text] ?? false)
                //                    && !(workingGoal.dayState[workingGoal.daysOfTheWeek.saturday.text] ?? false)
                //                    && !(workingGoal.dayState[workingGoal.daysOfTheWeek.sunday.text] ?? false)
                //                    || (workingGoal.motivationalQuote.isEmpty)
                //                ) {
                //
                //                    Button {
                //                        goalManager.goals.append(.init(title: workingGoal.title,
                //                                                       habitTitle: workingGoal.habitTitle,
                //                                                       deadline: workingGoal.deadline,
                //                                                       selectedFrequencyIndex: workingGoal.selectedFrequencyIndex,
                //                                                       selectedAnimal: workingGoal.selectedAnimal, motivationalQuote: workingGoal.motivationalQuote,
                //                                                       selectedDailyDeadline: workingGoal.selectedDailyDeadline,
                //                                                       selectedFixedDeadline: workingGoal.selectedFixedDeadline))
                //                    } label: {
                //                        Text("Save")
                //                            .frame(maxWidth: .infinity)
                //                    }
                
                
                
                Button {
                    
                    if workingGoal.habit.selectedFrequencyIndex == .daily {
                        workingGoal.scheduledCompletionDates = []
                        let currentDate = Date()
                        var currentDateComponent = Calendar.current.dateComponents([.year, .month, .day], from: currentDate)
                        
                        while let currentDate = Calendar.current.date(from: currentDateComponent), currentDate <= workingGoal.habit.selectedDailyDeadline {
                            workingGoal.scheduledCompletionDates.append(currentDate)
                            currentDateComponent.day! += 1
                        }
                        
                    } /*else if workingGoal.selectedFrequencyIndex == .custom {
                        
                    }*/
                    
                    if let index = goalManager.items.firstIndex(where: { $0.id == workingGoal.id }) {
                        goalManager.items[index] = workingGoal
                    } else {
                        goalManager.items.append(workingGoal)
                    }
                    goal = workingGoal
                    presentationMode.wrappedValue.dismiss()
                } label: {
                    Text("Save")
                }
                .frame(maxWidth: .infinity)
                .disabled(workingGoal.title.isEmpty || workingGoal.habit.title.isEmpty || workingGoal.selectedAnimal.name.isEmpty || /*(workingGoal.selectedFrequencyIndex == .custom && areAllTogglesOff) || */workingGoal.motivationalQuote.isEmpty)
                
                //Button {
                //                        // does this work???
                ////                        workingGoal.daysOfTheWeek.tuesday.state = true
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
        .onAppear {
            workingGoal = goal
        }
        .onDisappear {
            goal = workingGoal
        }
    }
}

struct GoalEditView_Previews: PreviewProvider {
    
    static var previews: some View {
        let goal = Goal(title: "", habit: Habit(title: "", selectedFrequencyIndex: Habit.frequency.daily, selectedDailyDeadline: Date(), completedDates: []), selectedAnimal: Animal(name: "Name of Animal", kind: .cow), motivationalQuote: "imagine the motivational quote",deadline: Date())
        
        GoalEditView(goal: .constant(goal), workingGoal: goal, selectedAnimalKind: .cow)
            .environmentObject(GoalManager())
        
    }
    
}
