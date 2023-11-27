//
//  HabitCompletionStatus.swift
//  Ratatouille
//
//  Created by rgs on 25/11/23.
//
import SwiftUI

class HabitCompletionStatus: ObservableObject {
    @Published var dailyHabitCompleted: [Date: Bool] = [:]

    func getArchiveURL() -> URL {
        let plistName = "HabitCompletionStatus.plist"
        let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!

        return documentsDirectory.appendingPathComponent(plistName)
    }

    func save() {
        let archiveURL = getArchiveURL()
        let propertyListEncoder = PropertyListEncoder()
        let encodedData = try? propertyListEncoder.encode(dailyHabitCompleted)
        try? encodedData?.write(to: archiveURL, options: .noFileProtection)
    }

    func load() {
        let archiveURL = getArchiveURL()
        let propertyListDecoder = PropertyListDecoder()

        if let retrievedData = try? Data(contentsOf: archiveURL),
           let dataDecoded = try? propertyListDecoder.decode([Date: Bool].self, from: retrievedData) {
            dailyHabitCompleted = dataDecoded
        }
    }
}
//
