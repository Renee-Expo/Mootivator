//
//  HabitCompletionView.swift
//  Ratatouille
//
//  Created by Kaveri Mi on 21/11/23.
//

import SwiftUI


struct HabitCompletionView: View {
    @Environment(\.dismiss) var dismiss
    @ObservedObject var goalManager: GoalManager = .shared
    
    @Binding var goal: Goal
//    @State private var showHabitCompletionView = false
    @State private var showNewHabitSheet = false
    @Binding var isHabitCompleted : Bool
    @Binding var showHabitCompletionView: Bool
    
//    @Binding var frequency : Array<String>
//    @Binding var selectedFrequencyIndex : Goal.frequency
//    @Binding var selectedDailyDeadline : Date
//    @Binding var selectedFixedDeadline : Date
//    @Binding var numberOfDaysCompleted : Int
//    @Binding var completedDates: [Date]
//    @Binding var scheduledCompletionDates: [Date]

    
    var body: some View {
        VStack {
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
                
                Button{
                    print("Button shown")
                    withAnimation {
    //                    presentationMode.wrappedValue.dismiss()
                        showNewHabitSheet = true
                    }
//                    showHabitCompletionView = false
                    } label: {
                        Text("Set new habit")
                            .buttonStyle(.borderedProminent)
                            .fontWeight(.bold)
                            .padding()
                            .frame(width: 200, height: 50)
                            .foregroundColor(.white)
                            .background(Color("AccentColor"))
                            .cornerRadius(8)
                    }
                    .sheet(isPresented: $showNewHabitSheet){
                            NewHabitView(goal: $goal)
                    }
            }
//        .fullScreenCover(isPresented: $showNewHabitSheet) {
//            NewHabitView(goal: $goal)
//        }

            
//        .onAppear{
//            let currentDate = Date()
//            if (/*goal.selectedFrequencyIndex == .custom
//                && */currentDate >= goal.selectedFixedDeadline)
//                || (goal.selectedFrequencyIndex == .daily && Date() >= goal.selectedDailyDeadline) {
//                showHabitCompletionView = true
//            } else if goal.selectedFrequencyIndex == .weekly {
//                // Check if the current date is the next Monday
//                if let nextSunday = Calendar.current.nextDate(after: Date(), matching: DateComponents(weekday: 1), matchingPolicy: .nextTime),
//                   Calendar.current.isDate(Date(), equalTo: nextSunday, toGranularity: .day) {
//                    showHabitCompletionView = true
//                }
//            } else if goal.selectedFrequencyIndex == .monthly {
//                // Check if the current date is the last day of the month
//                if let lastDayOfMonth = Calendar.current.date(byAdding: DateComponents(month: 1, day: -1), to: Date()),
//                   Calendar.current.isDate(Date(), equalTo: lastDayOfMonth, toGranularity: .day) {
//                    showHabitCompletionView = true
//                }
//            }
//            
//            let targetDays = calculateTargetDays(for: goal)
//            
//            if (/*goal.selectedFrequencyIndex == .custom
//                &&*/ goal.scheduledCompletionDates.allSatisfy({ goal.completedDates.contains($0.rawValue)}))
//                || (goal.selectedFrequencyIndex == .daily
//                    && goal.scheduledCompletionDates.allSatisfy({ goal.completedDates.contains($0.rawValue) }))
//                || (goal.selectedFrequencyIndex == .weekly
//                    && Double(goal.numberOfDaysCompleted) >= goal.numberOfTimesPerWeek)
//                || (goal.selectedFrequencyIndex == .monthly
//                    && Double(goal.numberOfDaysCompleted) >= goal.numberOfTimesPerMonth) {
//                isHabitCompleted = true
//            } else {
//                isHabitCompleted = false
//            }
//
//            
//        }
        
    }
}

struct HabitCompletionView_Previews: PreviewProvider {
    static var previews: some View {
        
        let goal = Goal(title: "Sample Title", habit: Habit(title: "Sample Habit", selectedFrequencyIndex: Habit.frequency.daily, selectedDailyDeadline: Date(), completedDates: []), selectedAnimal: Animal(name: "Name of Animal", kind: .cow), motivationalQuote: "imagine the motivational quote",deadline: Date())
        
        return NavigationStack{
            
            HabitCompletionView(goal: .constant(goal), isHabitCompleted: .constant(false), showHabitCompletionView: .constant(false))
                .environmentObject(GoalManager())
        }
    }
}
