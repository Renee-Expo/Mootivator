//
//  GoalManager.swift
//  Ratatouille
//
//  Created by Kaveri Mi on 19/11/23.
//

import Foundation
import SwiftUI

class GoalManager: ObservableObject {
    @Published var goals: [Goal] = [] {
        didSet {
            save()
        }
    }
        
    init() {
        load()
    }
    
    func getArchiveURL() -> URL {
        let plistName = "goals.plist"
        let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        
        return documentsDirectory.appendingPathComponent(plistName)
    }
    
    func save() {
        let archiveURL = getArchiveURL()
        let propertyListEncoder = PropertyListEncoder()
        let encodedGoals = try? propertyListEncoder.encode(goals)
        try? encodedGoals?.write(to: archiveURL, options: .noFileProtection)
    }
    
    func loadSampleGoals(){
//        goals = Goal.sampleGoals
    }
    
    func load() {
        let archiveURL = getArchiveURL()
        let propertyListDecoder = PropertyListDecoder()
                
        if let retrievedGoalData = try? Data(contentsOf: archiveURL),
            let goalsDecoded = try? propertyListDecoder.decode([Goal].self, from: retrievedGoalData) {
            goals = goalsDecoded
        }
    }
}
