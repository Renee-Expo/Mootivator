//
//  RatatouilleApp.swift
//  Ratatouille
//
//  Created by rgs on 4/9/23.
//

import SwiftUI

@main
struct RatatouilleApp: App {
    
    @EnvironmentObject var goalManager: GoalManager
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(goalManager)
        }
    }
}
