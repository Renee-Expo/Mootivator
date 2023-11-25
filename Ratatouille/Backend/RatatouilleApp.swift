//
//  RatatouilleApp.swift
//  Ratatouille
//
//  Created by rgs on 4/9/23.
//

import SwiftUI

@main
struct RatatouilleApp: App {
    @StateObject private var habitCompletionStatus = HabitCompletionStatus()
        
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(GoalManager())
                .environmentObject(habitCompletionStatus)
        }
    }
}
