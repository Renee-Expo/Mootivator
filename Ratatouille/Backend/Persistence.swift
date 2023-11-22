//
//  Persistence.swift
//  Ratatouille
//
//  Created by klifton Cheng stu on 4/11/23.
//

import Foundation
import SwiftUI

// GoalPersistence --------------------------------------------------------
// final class just means no more child classes
final class GoalManager: ObservableObject {
    
    @Published var goals: [Goal] = [] {
        didSet {
            save()
        }
    }
    
    init() {
        load()
    }
    
    func getArchiveURL() -> URL {
        let plistName = "Goals.plist"
        let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        
        return documentsDirectory.appendingPathComponent(plistName)
    }
    
    func save() {
        let archiveURL = getArchiveURL()
        let propertyListEncoder = PropertyListEncoder()
        let encodedGoals = try? propertyListEncoder.encode(goals)
        try? encodedGoals?.write(to: archiveURL, options: .noFileProtection)
    }
    
    func load() {
        let archiveURL = getArchiveURL()
        let propertyListDecoder = PropertyListDecoder()
        
        if let retrievedGoalData = try? Data(contentsOf: archiveURL),
           let goalsDecoded = try? propertyListDecoder.decode([Goal].self, from: retrievedGoalData) {
            goals = goalsDecoded
        }
    }
    
    func loadSampleData() {
        goals = Goal.sampleGoals
    }
}
