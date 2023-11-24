//
//  HabitCompletionView.swift
//  Ratatouille
//
//  Created by Kaveri Mi on 21/11/23.
//

import SwiftUI


struct HabitCompletionView: View {
    @EnvironmentObject var goalManager: GoalManager
    var isHabitCompleted: Bool
    var body: some View {
        VStack {
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
}

struct HabitCompletionView_Previews: PreviewProvider {
    static var previews: some View {
        HabitCompletionView(isHabitCompleted: true)
            .environmentObject(GoalManager())
    }
}
