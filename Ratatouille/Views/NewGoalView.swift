//
//  NewGoalView.swift
//  Ratatouille
//
//  Created by Kaveri Mi on 19/11/23.
//
import SwiftUI

struct NewGoalView: View {
    
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var goalManager: GoalManager
    
    @State private var title = ""
    @State private var deadline = Date()
    @State private var habitTitle = ""
    
    //    @State var selectedAnimalKind: AnimalKind = .cow
    //    @State var frequency = ["Custom", "Daily", "Weekly", "Monthly"]
    //    @State var selectedDays = [String]()
    @State var selectedAnimal: Animal = Animal(name: "", kind: .cow)
    @Binding var unlockedAnimals: [AnimalKind]
    @State private var motivationalQuote = ""
    @State private var selectedFrequencyIndex = Goal.frequency.custom
    @State private var selectedDailyDeadline = Date()
    @State private var numberOfTimesPerWeek = 1.0
    @State private var daysInWeek = 7
    @State private var numberOfTimesPerMonth = 1.0
    @State private var daysInMonth = 31
    @State private var selectedFixedDeadline = Date()
    @Binding var customDates : [String: Bool]
    var areAllTogglesOff: Bool {
        return !customDates.values.contains(true)
    }
    //    @State private var mondayChosen = false
    //    @State private var tuesdayChosen = false
    //    @State private var wednesdayChosen = false
    //    @State private var thursdayChosen = false
    //    @State private var fridayChosen = false
    //    @State private var saturdayChosen = false
    //    @State private var sundayChosen = false
    //    @State private var isButtonEnabled = true
    //    @Binding var isAnimalSelected: Bool
    
    var body: some View {
        NavigationStack {
            List{
                Section("Goal") {
                    TextField("Enter a Goal here", text: $title)
                    
                    DatePicker("Deadline", selection: $deadline, displayedComponents: [.date, .hourAndMinute])
                }
                
                Section("Pick an Animal") {
                    NavigationLink("Pick an animal") {
                        AnimalPickerView(selectedAnimalKind: $selectedAnimal.kind, unlockedAnimals: $unlockedAnimals) // help!!!
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
                            Slider(value: $numberOfTimesPerWeek, in: 1.0...7.0, step: 1)
                        }
                        .onAppear {
                            daysInWeek = daysInWeek - Calendar.current.component(.weekday, from: Date()) + 1
                        }
                        
                    } else if selectedFrequencyIndex == .monthly {
                        VStack {
                            Text("Number of times per remaining month: \(Int(numberOfTimesPerMonth.rounded()))")
                            Slider(value: $numberOfTimesPerMonth, in: 1...Double(daysInMonth), step: 1)
                        }
                        .onAppear {
                            // Calculate the number of days left in the current month
                            if let lastDayOfMonth = Calendar.current.range(of: .day, in: .month, for: Date())?.count {
                                daysInMonth = lastDayOfMonth - Calendar.current.component(.day, from: Date()) + 1
                            }
                        }
                    } else if selectedFrequencyIndex == .custom {
                        //                                            Picker("Days", selection: $selectedDays) {
                        //                                                ForEach(days, id: \.self) {  day in
                        //                                                    Text(day)
                        //                                                }
                        //                                            }
                        //                                            MultiSelectPickerView(days: days, selectedDays: $selectedDays)
                        //                                                        .onChange(of: days) {
                        //                                                            print(days)
                        //                                                        }
                        //
                        //                                            .pickerStyle(InlinePickerStyle())
                        
                        //                        multi-picker isnt working, so we are using "toggle" function instead
                        // toggle days in the week
                        
                        VStack {
                            
                            Toggle("Monday", isOn: Binding<Bool>( get: {customDates[Goal.daysOfTheWeek.monday.text]!},  set: { customDates[Goal.daysOfTheWeek.monday.text] = $0} ))
                            Toggle("Tuesday",   isOn: Binding<Bool>( get: {customDates[Goal.daysOfTheWeek.tuesday.text]!},  set: { customDates[Goal.daysOfTheWeek.tuesday.text] = $0} ))
                            Toggle("Wednesday", isOn: Binding<Bool>( get: {customDates[Goal.daysOfTheWeek.wednesday.text]!},  set: { customDates[Goal.daysOfTheWeek.wednesday.text] = $0} ))
                            Toggle("Thursday",  isOn: Binding<Bool>( get: {customDates[Goal.daysOfTheWeek.thursday.text]!},  set: { customDates[Goal.daysOfTheWeek.thursday.text] = $0} ))
                            Toggle("Friday",    isOn: Binding<Bool>( get: {customDates[Goal.daysOfTheWeek.friday.text]!},  set: { customDates[Goal.daysOfTheWeek.friday.text] = $0} ))
                            Toggle("Saturday",  isOn: Binding<Bool>( get: {customDates[Goal.daysOfTheWeek.saturday.text]!},  set: { customDates[Goal.daysOfTheWeek.saturday.text] = $0} ))
                            Toggle("Sunday",    isOn: Binding<Bool>( get: {customDates[Goal.daysOfTheWeek.sunday.text]!},  set: { customDates[Goal.daysOfTheWeek.sunday.text] = $0} ))
                            
                        }
                        //                        .toggleStyle(.button)
                        
                        //                    .toggleStyle(CheckboxToggleStyle())
                        
                        DatePicker("Deadline", selection: $selectedFixedDeadline, displayedComponents: [.date, .hourAndMinute])
                    }
                }
                
                Section("Write something to motivate you") {
                    TextField("You can do it!", text: $motivationalQuote)
                }
                
                
                
                //                if title.isEmpty || habitTitle.isEmpty || selectedAnimal.name.isEmpty || (selectedFrequencyIndex == .custom && areAllTogglesOff) || motivationalQuote.isEmpty {
                //                    isButtonEnabled = false
                //                }else{
                //                    isButtonEnabled = true
                //                }
                
                Button {
                    //                    if isButtonEnabled{
                    goalManager.goals.append(.init(title: title,
                                                   habitTitle: habitTitle,
                                                   deadline: deadline,
                                                   selectedFrequencyIndex: selectedFrequencyIndex,
                                                   selectedAnimal: selectedAnimal, motivationalQuote: motivationalQuote,
                                                   selectedDailyDeadline: selectedDailyDeadline,
                                                   selectedFixedDeadline: selectedFixedDeadline))
                    dismiss()
                    //                    }
                } label: {
                    Text("Save")
                        .frame(maxWidth: .infinity)
                }
                .disabled(title.isEmpty || habitTitle.isEmpty || selectedAnimal.name.isEmpty || (selectedFrequencyIndex == .custom && areAllTogglesOff) || motivationalQuote.isEmpty)
                
                
                //                Section {
                //                    if title.isEmpty || habitTitle.isEmpty || !isAnimalSelected || (frequency[selectedFrequencyIndex] == "Fixed" && !mondayChosen && !tuesdayChosen && !wednesdayChosen && !thursdayChosen && !fridayChosen && !saturdayChosen && !sundayChosen) || motivationalQuote.isEmpty {
                //                        Button{
                //
                //                        }label:{
                //                            Text("Save")
                //                        }
                //                        .disabled(!isButtonEnabled)
                //                        .frame(maxWidth: .infinity)
                //                    } else {
                //                        ZStack{
                //                            Color.accentColor
                //                            Button {
                //                                //#warning("fix this")
                //                                let newGoal = Goal(title: title, habitTitle: habitTitle, deadline: deadline, frequency: frequency, selectedFrequencyIndex: selectedFrequencyIndex, selectedAnimal: selectedAnimal, motivationalQuote: motivationalQuote, selectedDailyDeadline: selectedDailyDeadline, selectedFixedDeadline: selectedFixedDeadline, numberOfTimesPerWeek: Double(numberOfTimesPerWeek), numberOfTimesPerMonth: Double(numberOfTimesPerMonth))
                //
                //                                isButtonEnabled = true
                //                                goalManager.goals.append(newGoal)
                //                                dismiss()
                //                            } label: {
                //                                Text("Save")
                //                                    .foregroundColor(.white)
                //                            }
                //                            .frame(maxWidth: .infinity)
                //                            //                            .background(Color.accentColor)
                //                        }
                //                    }
                //                }
                /*
                 Section("SAVE BUTTON???") {
                 //                        Button {
                 if (title.isEmpty ||
                 habitTitle.isEmpty ||
                 (selectedFrequencyIndex == .custom
                 && !(goalManager.dayState[Goal.daysOfTheWeek.monday.text] ?? false)
                 && !(goalManager.dayState[Goal.daysOfTheWeek.monday.text] ?? false)
                 && !(goalManager.dayState[Goal.daysOfTheWeek.monday.text] ?? false)
                 && !(goalManager.dayState[Goal.daysOfTheWeek.monday.text] ?? false)
                 && !(goalManager.dayState[Goal.daysOfTheWeek.monday.text] ?? false)
                 && !(goalManager.dayState[Goal.daysOfTheWeek.monday.text] ?? false)
                 && !(goalManager.dayState[Goal.daysOfTheWeek.monday.text] ?? false))
                 || motivationalQuote.isEmpty)
                 { // if statement
                 Button {
                 // save here???
                 } label: {
                 Text("Save")
                 }
                 .frame(maxWidth: .infinity)
                 //                        .disabled(!isButtonEnabled)
                 //Handle the case where the button should be disabled
                 } else {
                 ZStack {
                 Color.accentColor
                 Button {
                 //                            isButtonEnabled = true
                 goalManager.goals.append(
                 Goal(
                 title: title,
                 habitTitle: habitTitle,
                 deadline: deadline,
                 //                                    frequency: frequency,
                 selectedFrequencyIndex: selectedFrequencyIndex,
                 selectedAnimal: Animal(name: "", kind: selectedAnimalKind),
                 motivationalQuote: motivationalQuote,
                 selectedDailyDeadline: selectedDailyDeadline,
                 selectedFixedDeadline: selectedFixedDeadline,
                 numberOfTimesPerWeek: Double(numberOfTimesPerWeek),
                 numberOfTimesPerMonth: Double(numberOfTimesPerMonth)
                 )
                 
                 if frequency[selectedFrequencyIndex] == "Daily" {
                 newGoal.scheduledCompletionDates = Array(stride(from: Date(), to: selectedDailyDeadline, by: 24 * 60 * 60))
                 } else if frequency[selectedFrequencyIndex] == "Fixed" {
                 if mondayChosen {
                 newGoal.scheduledCompletionDates += Array(stride(from: Date(), to: selectedFixedDeadline, by: 7 * 24 * 60 * 60))
                 }
                 if tuesdayChosen {
                 newGoal.scheduledCompletionDates += Array(stride(from: Date(), to: selectedFixedDeadline, by: 7 * 24 * 60 * 60))
                 }
                 if wednesdayChosen {
                 newGoal.scheduledCompletionDates += Array(stride(from: Date(), to: selectedFixedDeadline, by: 7 * 24 * 60 * 60))
                 }
                 if thursdayChosen {
                 newGoal.scheduledCompletionDates += Array(stride(from: Date(), to: selectedFixedDeadline, by: 7 * 24 * 60 * 60))
                 }
                 if fridayChosen {
                 newGoal.scheduledCompletionDates += Array(stride(from: Date(), to: selectedFixedDeadline, by: 7 * 24 * 60 * 60))
                 }
                 if saturdayChosen {
                 newGoal.scheduledCompletionDates += Array(stride(from: Date(), to: selectedFixedDeadline, by: 7 * 24 * 60 * 60))
                 }
                 if sundayChosen {
                 newGoal.scheduledCompletionDates += Array(stride(from: Date(), to: selectedFixedDeadline, by: 7 * 24 * 60 * 60))
                 }
                 
                 // Remove duplicates
                 newGoal.scheduledCompletionDates = Array(Set(newGoal.scheduledCompletionDates))
                 }
                 
                 goalManager.goals.append(newGoal)
                 dismiss()
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
                 )
                 // dismiss after adding
                 dismiss()
                 } label: {
                 Text("Save")
                 .foregroundColor(.white)
                 }
                 .frame(maxWidth: .infinity)
                 //                            .background(Color.accentColor)
                 }
                 }
                 }
                 */
            }
        }
    }
}


struct NewGoalView_Previews: PreviewProvider {
    static var previews: some View {
        NewGoalView(unlockedAnimals: .constant([.cow]), customDates: .constant([:]))
            .environmentObject(GoalManager())
    }
}

