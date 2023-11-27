//
//  HabitCompletionView.swift
//  Ratatouille
//
//  Created by Kaveri Mi on 21/11/23.
//

import SwiftUI


struct HabitCompletionView: View {
    @EnvironmentObject var goalManager: GoalManager
    @EnvironmentObject var habitCompletionStatus: HabitCompletionStatus
    
    @Binding var goal: Goal
    @State private var showHabitCompletionView = false
    @Binding var frequency : Array<String>
    @Binding var selectedFrequencyIndex : Int
    @Binding var selectedDailyDeadline : Date
    @Binding var selectedFixedDeadline : Date
    @State var isHabitCompleted : Bool
    @Binding var numberOfDaysCompleted : Int
    @Binding var completedDates: [Date]
    @Binding var scheduledCompletionDates: [Date]

    
    var body: some View {
        VStack {
            if showHabitCompletionView{
                Image(systemName: isHabitCompleted ? "checkmark.circle":"xmark.circle")
                    .foregroundColor(isHabitCompleted ? Color("AccentColor") : Color.red)
                    .font(.system(size: 100))
                Text(isHabitCompleted ? "Habit Complete!  Well done!" : "Habit incomplete")
                    .font(.system(size: 24))
                    .fontWeight(.medium)
                    .padding()
                Text(isHabitCompleted ? "Keep up the good work!" : "It’s ok! Try again, you’ve got this! You may now set the same habit or set a new one!")
                    .font(.system(size: 24))
                    .multilineTextAlignment(.center)
                    .fontWeight(.medium)
                    .padding()
            }
            
        }
        .onAppear{
            if (frequency[selectedFrequencyIndex] == "Fixed" && Date() >= selectedFixedDeadline) ||
                (frequency[selectedFrequencyIndex] == "Daily" && Date() >= selectedDailyDeadline) {
                showHabitCompletionView = true
            } else if frequency[selectedFrequencyIndex] == "Weekly" {
                // Check if the current date is the next Monday
                if let nextSunday = Calendar.current.nextDate(after: Date(), matching: DateComponents(weekday: 1), matchingPolicy: .nextTime),
                   Calendar.current.isDate(Date(), equalTo: nextSunday, toGranularity: .day) {
                    showHabitCompletionView = true
                }
            } else if frequency[selectedFrequencyIndex] == "Monthly" {
                // Check if the current date is the last day of the month
                if let lastDayOfMonth = Calendar.current.date(byAdding: DateComponents(month: 1, day: -1), to: Date()),
                   Calendar.current.isDate(Date(), equalTo: lastDayOfMonth, toGranularity: .day) {
                    showHabitCompletionView = true
                }
            }
            
            let targetDays = calculateTargetDays(for: goal)
            
            if (frequency[selectedFrequencyIndex] == "Fixed"  && scheduledCompletionDates.allSatisfy({ completedDates.contains($0) })) || (frequency[selectedFrequencyIndex] == "Daily"  && scheduledCompletionDates.allSatisfy({ completedDates.contains($0) })) || (frequency[selectedFrequencyIndex] == "Weekly"  && numberOfDaysCompleted >= targetDays) || (frequency[selectedFrequencyIndex] == "Monthly"  && numberOfDaysCompleted >= targetDays) {
                isHabitCompleted = true
            } else {
                isHabitCompleted = false
            }

            
        }
        
    }
}

struct HabitCompletionView_Previews: PreviewProvider {
    static var previews: some View {
        
        let goal = Goal(title: "Sample Title", habitTitle: "Sample Habit Title", deadline: Date(), frequency: ["Daily"], selectedFrequencyIndex: 0, selectedAnimal: Animal(name: "Name of Animal", kind: .cow), motivationalQuote: "imagine the motivational quote", selectedDailyDeadline: Date(), selectedFixedDeadline: Date())
        
        return NavigationStack{
            
            HabitCompletionView(goal: .constant(goal), frequency: .constant(["Fixed", "Daily", "Weekly", "Monthly"]), selectedFrequencyIndex: .constant(0), selectedDailyDeadline:.constant(Date()), selectedFixedDeadline: .constant(Date()),  isHabitCompleted: false, numberOfDaysCompleted: .constant(0), completedDates: .constant([]), scheduledCompletionDates: .constant([]))
                .environmentObject(GoalManager())
                .environmentObject(HabitCompletionStatus())
        }
    }
}
