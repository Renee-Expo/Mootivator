//
//  HabitCompletionView.swift
//  Ratatouille
//
//  Created by Kaveri Mi on 21/11/23.
//

import SwiftUI


struct HabitCompletionView: View {
    @EnvironmentObject var goalManager: GoalManager
    @State private var showHabitCompletionView = false
    @Binding var frequency : Array<String>
    @Binding var selectedFrequencyIndex : Int
    @Binding var selectedDailyDeadline : Date
    @Binding var selectedFixedDeadline : Date
    var isHabitCompleted: Bool
    var body: some View {
        VStack {
            if showHabitCompletionView{
                Image(systemName: isHabitCompleted ? "checkmark.circle":"xmark.circle")
                    .foregroundColor(Color(isHabitCompleted ? "AccentColor":"red"))
                    .font(.system(size: 100))
                Text(isHabitCompleted ? "Habit Complete!  Well done!":"Habit incomplete")
                    .font(.system(size: 24))
                    .fontWeight(.medium)
                    .padding()
                Text(isHabitCompleted ? "Keep up the good work!":"It’s ok! Try again, you’ve got this! You may now set the same habit or set a new one!")
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
        }
        
    }
}

struct HabitCompletionView_Previews: PreviewProvider {
    static var previews: some View {
        HabitCompletionView(frequency: .constant(["Fixed", "Daily", "Weekly", "Monthly"]), selectedFrequencyIndex: .constant(0), selectedDailyDeadline:.constant(Date()), selectedFixedDeadline: .constant(Date()), isHabitCompleted: true)
            .environmentObject(GoalManager())
    }
}
