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
    @EnvironmentObject var habitCompletionStatus: HabitCompletionStatus
    
    @State private var title = ""
    @State private var deadline = Date()
    @State private var habitTitle = ""
    
    @State var selectedAnimalKind: AnimalKind = .cow
//    @State var frequency = ["Custom", "Daily", "Weekly", "Monthly"]
//    @State var selectedDays = [String]()
    @State private var motivationalQuote = ""
    @State private var selectedFrequencyIndex = Goal.frequency.custom
    @State private var selectedDailyDeadline = Date()
    @State private var numberOfTimesPerWeek = 1.0
    @State private var daysInWeek = 7 // should this be let?
    @State private var numberOfTimesPerMonth = 1.0
    @State private var daysInMonth = 31
    @State private var selectedFixedDeadline = Date()
//    @State private var mondayChosen = false
//    @State private var tuesdayChosen = false
//    @State private var wednesdayChosen = false
//    @State private var thursdayChosen = false
//    @State private var fridayChosen = false
//    @State private var saturdayChosen = false
//    @State private var sundayChosen = false
//    @State private var isButtonEnabled = false
//    @Binding var isAnimalSelected: Bool
    
    var body: some View {
        Form {
            
            Section("Goal") {
                TextField("Enter a Goal here", text: $title)
                
                DatePicker("Deadline", selection: $deadline, displayedComponents: [.date, .hourAndMinute])
            }
            
            Section("Pick an Animal") {
                NavigationLink("Pick an animal") {
                    AnimalPickerView(selectedAnimalKind: $selectedAnimalKind, unlockedAnimals: [.cow, .sheep])
                }
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
                    /*
                    HStack {
                        Toggle("Monday", isOn: goalManager.dayState[Goal.daysOfTheWeek.monday.text])
                        Toggle("Tuesday", isOn: goalManager.dayState[Goal.daysOfTheWeek.tuesday.text])
                        Toggle("Wednesday", isOn: goalManager.dayState[Goal.daysOfTheWeek.wednesday.text])
                        Toggle("Thursday", isOn: goalManager.dayState[Goal.daysOfTheWeek.thursday.text])
                        Toggle("Friday", isOn: goalManager.dayState[Goal.daysOfTheWeek.friday.text])
                        Toggle("Saturday", isOn: goalManager.dayState[Goal.daysOfTheWeek.saturday.text])
                        Toggle("Sunday", isOn: goalManager.dayState[Goal.daysOfTheWeek.sunday.text])
                    }
                    .toggleStyle(CheckboxToggleStyle())
                     */
                    
                    DatePicker("Deadline", selection: $selectedFixedDeadline, displayedComponents: [.date, .hourAndMinute])
                }
            }
            
            Section("Write something to motivate you") {
                TextField("You can do it!", text: $motivationalQuote)
            }
            
            //                Section{
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


struct NewGoalView_Previews: PreviewProvider {
    static var previews: some View {
        NewGoalView()
            .environmentObject(GoalManager())
            .environmentObject(HabitCompletionStatus())
    }
}
