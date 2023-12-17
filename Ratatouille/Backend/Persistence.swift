//
//  Persistence.swift
//  Ratatouille
//
//  Created by klifton Cheng stu on 4/11/23.
//

import Foundation
import SwiftUI


// GoalPersistence --------------------------------------------------------
//// final class just means no more child classes
//final class GoalManager: ObservableObject {
//    
//    @Published var goals: [Goal] = [] {
//        didSet {
//            save()
//        }
//    }
//    
//    init() {
//        load()
//    }
//    
//    @Published var searchText = ""
//    @Published var sortOption: SortOption = .none
//    @Published var filterOption: FilterOption = .showCurrent // Default to show current goals only
////    @Published var showCurrentGoalsOnly: Bool = false // Default to show current goals only
//    
//    var filteredAndSortedGoals: Binding<[Goal]> {
//        
//        Binding (
//            get: {
//                var filteredGoals = self.goals
//                
//                if !self.searchText.isEmpty {
//                    filteredGoals = filteredGoals.filter {
//                        $0.title.localizedCaseInsensitiveContains(self.searchText) ||
//                        $0.habitTitle.localizedCaseInsensitiveContains(self.searchText)
//                    }
//                }
//                
////                DispatchQueue.main.async {
//                    switch self.sortOption {
//                    case .ascending:
//                        filteredGoals.sort { $0.deadline < $1.deadline }
//                    case .descending:
//                        filteredGoals.sort { $0.deadline > $1.deadline }
//                    case .none:
//                        break
//                    }
////                }
//                
//                switch self.filterOption {
//                case .showAll:
//                    return filteredGoals
//                case .showPast:
//                    return filteredGoals.filter { $0.isGoalCompleted }
//                case .showCurrent:
//                    return filteredGoals.filter { !$0.isGoalCompleted }
//                }
////                if self.showCurrentGoalsOnly {
////                    return filteredGoals.filter { !$0.isGoalCompleted }
////                } else {
////                    return filteredGoals
////                }
//                
////                return filteredGoals
//            },
//            set: {
//                self.goals = $0
//            }
//        )
//    }
//    
//    
//    func getArchiveURL() -> URL {
//        let plistName = "Goals.plist"
//        let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
//        
//        return documentsDirectory.appendingPathComponent(plistName)
//    }
//    
//    func save() {
//        let archiveURL = getArchiveURL()
//        let propertyListEncoder = PropertyListEncoder()
//        let encodedGoals = try? propertyListEncoder.encode(goals)
//        try? encodedGoals?.write(to: archiveURL, options: .noFileProtection)
//    }
//    
//    func load() {
//        let archiveURL = getArchiveURL()
//        let propertyListDecoder = PropertyListDecoder()
//        
//        if let retrievedGoalData = try? Data(contentsOf: archiveURL),
//           let goalsDecoded = try? propertyListDecoder.decode([Goal].self, from: retrievedGoalData) {
//            goals = goalsDecoded
//        }
//    }
//    
//    func loadSampleData() {
//        goals = Goal.sampleGoals
//    }
//    
//    func deleteGoal(_ goal: Goal) {
//        // Implement deletion logic here
//        // For instance, if you're storing goals in an array:
//        if let index = goals.firstIndex(where: { $0.id == goal.id }) {
//            goals.remove(at: index)
//        }
//    }
//}

final class GoalManager: ItemManager {
    @Published var items: [Goal] = [] { didSet { write() } }
    static var shared: GoalManager = .init()
    static var saveLocation: FileSystem.FileName = .goalManager
    // numberofcompletedgoals variable
    @Published var numberOfCompletedGoals: Int {
        didSet {
            UserDefaults.standard.set(numberOfCompletedGoals, forKey: "numberOfCompletedGoals")
        }
    }
    
    init() {
        self.numberOfCompletedGoals = UserDefaults.standard.integer(forKey: "numberOfCompletedGoals")
        read()
    }
    
    
    
    
    func deleteGoal(_ goal: Goal) {
        if let index = items.firstIndex(where: { $0.id == goal.id }) {
            items.remove(at: index)
        }
    }
    
    // during DEBUG only
//    func loadSampleData() {
//        items = Goal.sampleGoals
//    }
    
    @Published var searchText = ""
    @Published var sortOption: SortOption = .none
    @Published var filterOption: FilterOption = .showCurrent // Default to show current goals only
    
    var filteredAndSortedGoals: Binding<[Goal]> {
        
        Binding (
            get: {
                var filteredGoals = self.items
                
                if !self.searchText.isEmpty {
                    filteredGoals = filteredGoals.filter {
                        $0.title.localizedCaseInsensitiveContains(self.searchText) ||
                        $0.habit.habitTitle.localizedCaseInsensitiveContains(self.searchText)
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
                
                switch self.filterOption {
                case .showAll:
                    return filteredGoals
                case .showPast:
                    return filteredGoals.filter { $0.isGoalCompleted }
                case .showCurrent:
                    return filteredGoals.filter { !$0.isGoalCompleted }
                }
            },
            set: {
                self.items = $0
            }
        )
    }
}

final class UnlockedAnimalManager: ItemManager {
    @Published var items: [AnimalKind] = [] { didSet { write() } }
    static var shared: UnlockedAnimalManager = .init()
    static var saveLocation: FileSystem.FileName = .unlockedAnimalManager
    
    init() {
        read()
    }
}

// new persistence code
// thanks to @KaiTheRedNinja
// github:  https://github.com/KaiTheRedNinja

protocol ItemManager: ObservableObject {
    associatedtype T: Codable
    
    static var shared: Self { get }
    static var saveLocation: FileSystem.FileName { get }
    var items: [T] { get set }
}

extension ItemManager {
    func write() {
//        print("WRITING")
        FileSystem.write(items, to: Self.saveLocation)
    }
    
    func read() {
//        print("READING")
        if let items = FileSystem.read([T].self, from: Self.saveLocation) {
            self.items = items
        } else {
            self.items = []
        }
    }
}


enum FileSystem {
    enum FileName {
        
        // add new cases to add new files
        case goalManager
        case unlockedAnimalManager
        
        var fileName: String {
            
            // change filenames here
            switch self {
            case .goalManager: return "GoalManager"
            case .unlockedAnimalManager: return "UnlockedAnimalManager"
                
            }
        }
    }

    /// Reads a type from a file
    static func read<T: Decodable>(_ type: T.Type, from file: FileName) -> T? {
        let filename = getDocumentsDirectory().appendingPathComponent(file.fileName)
        if let data = try? Data(contentsOf: filename) {
            if let values = try? JSONDecoder().decode(T.self, from: data) {
                return values
            }
        }

        return nil
    }

    /// Writes a type to a file
    static func write<T: Encodable>(_ value: T, to file: FileName, error onError: @escaping (Error) -> Void = { _ in }) {
        var encoded: Data

        do {
            encoded = try JSONEncoder().encode(value)
        } catch {
            onError(error)
            return
        }

        let filename = getDocumentsDirectory().appendingPathComponent(file.fileName)
        if file.fileName.contains("/") {
            try? FileManager.default.createDirectory(atPath: filename.deletingLastPathComponent().path,
                                                     withIntermediateDirectories: true,
                                                     attributes: nil)
        }
        do {
            try encoded.write(to: filename)
            return
        } catch {
            // failed to write file – bad permissions, bad filename,
            // missing permissions, or more likely it can't be converted to the encoding
            onError(error)
        }
    }

    /// Checks if a file exists at a path
    static func exists(file: FileName) -> Bool {
        let path = getDocumentsDirectory().appendingPathComponent(file.fileName)
        return FileManager.default.fileExists(atPath: path.relativePath)
    }

    /// Returns the URL of the path
    static func path(file: FileName) -> URL {
        getDocumentsDirectory().appendingPathComponent(file.fileName)
    }

    /// Gets the documents directory
    static func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
//        Log.info("Documents directory at \(paths[0])")
        return paths[0]
    }
}

public extension URL {
    /// The attributes of a url
    var attributes: [FileAttributeKey: Any]? {
        do {
            return try FileManager.default.attributesOfItem(atPath: path)
        } catch let error as NSError {
            print("FileAttribute error: \(error)")
        }
        return nil
    }

    /// The file size of the url
    var fileSize: UInt64 {
        return attributes?[.size] as? UInt64 ?? UInt64(0)
    }

    /// The file size of the url as a string
    var fileSizeString: String {
        return ByteCountFormatter.string(fromByteCount: Int64(fileSize), countStyle: .file)
    }

    /// The date of creation of the file
    var creationDate: Date? {
        return attributes?[.creationDate] as? Date
    }
}

public extension Array {
    func mergedWith(other: [Element],
                    isSame: (Element, Element) -> Bool,
                    isBefore: (Element, Element) -> Bool) -> [Element] {
        let mergedArray = self + other
        let sortedArray = mergedArray.sorted(by: isBefore)
        var result: [Element] = []

        for element in sortedArray {
            if !result.contains(where: { isSame($0, element) }) {
                result.append(element)
            }
        }

        return result
    }

    mutating func mergeWith(other: [Element],
                            isSame: (Element, Element) -> Bool,
                            isBefore: (Element, Element) -> Bool) {
        self = mergedWith(other: other, isSame: isSame, isBefore: isBefore)
    }
}


// Color Conform To codable
// thanks to @brunowernimont -> twitter
// Code at: http://brunowernimont.me/howtos/make-swiftui-color-codable

#if os(iOS)
import UIKit
#elseif os(watchOS)
import WatchKit
#elseif os(macOS)
import AppKit
#endif

fileprivate extension Color {
    #if os(macOS)
    typealias SystemColor = NSColor
    #else
    typealias SystemColor = UIColor
    #endif
    
    var colorComponents: (red: CGFloat, green: CGFloat, blue: CGFloat, alpha: CGFloat)? {
        var r: CGFloat = 0
        var g: CGFloat = 0
        var b: CGFloat = 0
        var a: CGFloat = 0
        
        #if os(macOS)
        SystemColor(self).getRed(&r, green: &g, blue: &b, alpha: &a)
        // Note that non RGB color will raise an exception, that I don't now how to catch because it is an Objc exception.
        #else
        guard SystemColor(self).getRed(&r, green: &g, blue: &b, alpha: &a) else {
            // Pay attention that the color should be convertible into RGB format
            // Colors using hue, saturation and brightness won't work
            return nil
        }
        #endif
        
        return (r, g, b, a)
    }
}

extension Color: Codable {
    enum CodingKeys: String, CodingKey {
        case red, green, blue
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let r = try container.decode(Double.self, forKey: .red)
        let g = try container.decode(Double.self, forKey: .green)
        let b = try container.decode(Double.self, forKey: .blue)
        
        self.init(red: r, green: g, blue: b)
    }

    public func encode(to encoder: Encoder) throws {
        guard let colorComponents = self.colorComponents else {
            return
        }
        
        var container = encoder.container(keyedBy: CodingKeys.self)
        
        try container.encode(colorComponents.red, forKey: .red)
        try container.encode(colorComponents.green, forKey: .green)
        try container.encode(colorComponents.blue, forKey: .blue)
    }
}

