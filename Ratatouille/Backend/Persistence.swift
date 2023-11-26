//
//  Persistence.swift
//  Ratatouille
//
//  Created by klifton Cheng stu on 4/11/23.
//

import Foundation
import SwiftUI

enum SortOption: String, CaseIterable {
    case none = "Show All"
    case ascending = "Sort by Deadline (Ascending)"
    case descending = "Sort by Deadline (Descending)"
}


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
    
    @Published var searchText = ""
    @Published var sortOption: SortOption = .none
    
    var filteredAndSortedGoals: Binding<[Goal]> {
        
        Binding (
            get: {
                var filteredGoals = self.goals
                
                if !self.searchText.isEmpty {
                    filteredGoals = filteredGoals.filter {
                        $0.title.localizedCaseInsensitiveContains(self.searchText) ||
                        $0.habitTitle.localizedCaseInsensitiveContains(self.searchText)
                    }
                }
                
                switch self.sortOption {
                case .ascending:
                    filteredGoals.sort { $0.deadline < $1.deadline }
                case .descending:
                    filteredGoals.sort { $0.deadline > $1.deadline }
                case .none:
                    break
                }
                
                return filteredGoals
            },
            set: {
                self.goals = $0
            }
        )
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
    
    func deleteGoal(_ goal: Goal) {
        // Implement deletion logic here
        // For instance, if you're storing goals in an array:
        if let index = goals.firstIndex(where: { $0.id == goal.id }) {
            goals.remove(at: index)
        }
    }
}
