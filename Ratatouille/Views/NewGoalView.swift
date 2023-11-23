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
    
    @State private var goalEntered = ""
    @State private var deadline = Date()
    @State private var habitEntered = ""
    @State private var selectedAnimal: Int = 0
    @State var frequency = ["Fixed", "Daily", "Weekly", "Monthly"]
    @State var selectedDays = [String]()
    @State private var motivationalQuote = ""
    @State private var selectedFrequencyIndex = 0
    @State private var selectedDailyDeadline = Date()
    @State private var numberOfTimesPerWeek = 1.0
    @State private var numberOfTimesPerMonth = 1.0
    @State private var selectedFixedDeadline = Date()
    @State private var mondayChosen = false
    @State private var tuesdayChosen = false
    @State private var wednesdayChosen = false
    @State private var thursdayChosen = false
    @State private var fridayChosen = false
    @State private var saturdayChosen = false
    @State private var sundayChosen = false
    @State private var isButtonEnabled = false
    
    var body: some View {
        NavigationStack {
            Form {
                Section("Goal") {
                    TextField("Enter a Goal here", text: $goalEntered)
                    
                    DatePicker("Deadline", selection: $deadline, displayedComponents: [.date, .hourAndMinute])
                }
                Section("Pick an Animal") {
                    NavigationLink("Pick an animal") {
                        AnimalPickerView(selectedAnimal: $selectedAnimal)

                    }
                }
                
                
                Section("Current Habit") {
                    TextField(text: $habitEntered) {
                        Text("Enter a Habit")
                    }
                    
                    Picker("Frequency", selection: $selectedFrequencyIndex) {
                        ForEach(0..<frequency.count, id: \.self) { index in
                            Text(frequency[index])
                                .tag(index)
                        }
                    }
                    if frequency[selectedFrequencyIndex] == "Daily" {
                        DatePicker("Deadline", selection: $selectedDailyDeadline, displayedComponents: [.date, .hourAndMinute])
                    } else if frequency[selectedFrequencyIndex] == "Weekly" {
                        VStack {
                            Text("Number of times per week: \(Int(numberOfTimesPerWeek.rounded()))")
                            
                            Slider(value: $numberOfTimesPerWeek, in: 1...7, step: 1)
                        }
                    } else if frequency[selectedFrequencyIndex] == "Monthly" {
                        VStack {
                            Text("Number of times per month: \(Int(numberOfTimesPerMonth.rounded()))")
                            Slider(value: $numberOfTimesPerMonth, in: 1...31, step: 1)
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
                        
                        //                    .pickerStyle(InlinePickerStyle())
                        
                        //multi-picker isnt working, so we are using "toggle" function instead
                        
                        Toggle("Monday", isOn: $mondayChosen)
                        Toggle("Tuesday", isOn: $tuesdayChosen)
                        Toggle("Wednesday", isOn: $wednesdayChosen)
                        Toggle("Thursday", isOn: $thursdayChosen)
                        Toggle("Friday", isOn: $fridayChosen)
                        Toggle("Saturday", isOn: $saturdayChosen)
                        Toggle("Sunday", isOn: $sundayChosen)
                        
                        DatePicker("Deadline", selection: $selectedFixedDeadline, displayedComponents: [.date, .hourAndMinute])
                    }
                }
                
                Section("Write something to motivate you") {
                    TextField("You can do it!", text: $motivationalQuote)
                }
                
                
                
                Section{
                    if goalEntered.isEmpty || habitEntered.isEmpty || (frequency[selectedFrequencyIndex] == "Fixed" && !mondayChosen && !tuesdayChosen && !wednesdayChosen && !thursdayChosen && !fridayChosen && !saturdayChosen && !sundayChosen) || motivationalQuote.isEmpty {
                        Button{
                            
                        }label:{
                            Text("Save")
                        }
                        .disabled(!isButtonEnabled)
                        .frame(maxWidth: .infinity)
                    } else {
                        ZStack{
                            Color.accentColor
                            Button {
                                #warning("fix this")
//                                let newGoal = Goal(goalEntered: goalEntered, deadline: deadline, habitEntered: habitEntered, selectedAnimal: selectedAnimal, frequency: frequency, motivationalQuote: motivationalQuote, selectedFrequencyIndex: selectedFrequencyIndex, selectedDailyDeadline: selectedDailyDeadline, numberOfTimesPerWeek: Double(numberOfTimesPerWeek), numberOfTimesPerMonth: Double(numberOfTimesPerMonth), selectedFixedDeadline: selectedFixedDeadline)
//                                
//                                isButtonEnabled = true
//                                goalManager.goals.append(newGoal)
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
                
                
            }
            
        }
    }
}


struct NewGoalView_Previews: PreviewProvider {
    static var previews: some View {
        NewGoalView()
            .environmentObject(GoalManager())
    }
}
