//
//  HabitCompletionView.swift
//  Ratatouille
//
//  Created by Kaveri Mi on 21/11/23.
//

import SwiftUI

struct HabitCompletionView: View {
    @EnvironmentObject var goalManager: GoalManager
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

struct HabitCompletionView_Previews: PreviewProvider {
    static var previews: some View {
        HabitCompletionView()
            .environmentObject(GoalManager())
    }
}
