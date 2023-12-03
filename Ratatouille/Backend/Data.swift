//
//  Data.swift
//  Ratatouille
//
//  Created by klifton Cheng stu on 18/11/23.
//

import Foundation
// not to be published, texting data
//var textData : GoalItem = .init(title: "Hi", animal: Animal(name: "fluffy the ferst", emotion: 0, kind: ))
// ---------------------------------

let numberOfGoalsNeeded = [0, 2, 4, 6, 8, 10, 13, 16, 20, 25]

enum SortOption: String, CaseIterable {
    case none = "Show All"
    case ascending = "Sort by Deadline (Ascending)"
    case descending = "Sort by Deadline (Descending)"
}

enum FilterOption {
    case showAll, showCurrent, showPast
}

enum AnimalKind : Codable, CaseIterable {
    case cow
    case sheep
    case chicken
    case goat
    case pig
    case horse
    case dog
    case rabbit
    case cat
    case duck
//    case none
    
    var asString: String {
        switch self {
        case .cow : return "cow"
        case .sheep : return "sheep"
        case .chicken : return "chicken"
        case .goat : return "goat"
        case .pig : return "pig"
        case .horse : return "horse"
        case .dog : return "dog"
        case .rabbit : return "rabbit"
        case .cat : return "cat"
        case .duck : return "duck"
//        case .none: return "NONE"
        }
    }
    
    var image: String {
        switch self{
        case .cow : return "Cow_"
        case .sheep : return "Sheep_"
        case .chicken : return "Chicken_"
        case .goat : return "Goat_"
        case .pig : return "Pig_"
        case .horse : return "Horse_"
        case .dog : return "Dog_"
        case .rabbit : return "Rabbit_"
        case .cat : return "Cat_"
        case .duck : return "Duck_"
//        case .none: return "NONE_"
        }
    }
}

struct Animal : Identifiable, Codable, Hashable {
    var id = UUID()
    
    var name : String
    var kind : AnimalKind         // what type/kind/species the animal is
    var emotion = Emotion.neutral
}

enum Emotion {
    case happy
    case neutral
    case sad
    
    var text : String {
        switch self {
        case .happy     : return "Happy"
        case .neutral   : return "Neutral"
        case .sad       : return "Sad"
        }
    }
}

// Enum Emotion conform to Codable
extension Emotion: Codable {
    
    enum Key: CodingKey {
        case rawValue
    }
    
    enum CodingError: Error {
        case unknownValue
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: Key.self)
        let rawValue = try container.decode(Int.self, forKey: .rawValue)
        switch rawValue {
        case 0:
            self = .happy
        case 1:
            self = .neutral
        case 2:
            self = .sad
        default:
            throw CodingError.unknownValue
        }
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: Key.self)
        switch self {
        case .happy:
            try container.encode(0, forKey: .rawValue)
        case .neutral:
            try container.encode(1, forKey: .rawValue)
        case .sad:
            try container.encode(2, forKey: .rawValue)
        }
    }
    
}

struct Goal: Identifiable, Codable, Hashable {
    var id = UUID ()
    
    var title : String
    var habitTitle : String
    //    var frequencyOfHabits : String // why string?
//    var frequency : Array<String>
    enum frequency : Codable, CaseIterable, Hashable {
        case custom
        case daily
        case weekly
        case monthly
        
        var text : String {
            switch self {
            case.custom     : return "Custom"
            case.daily      : return "Daily"
            case.weekly     : return "Weekly"
            case.monthly    : return "Monthly"
            }
        }
    }
    var selectedFrequencyIndex : Self.frequency
    
    var selectedAnimal : Animal
    //    var selectedAnimal : Int
    var motivationalQuote : String
    
    var selectedDailyDeadline : Date
    var selectedFixedDeadline : Date
    
    var numberOfTimesPerWeek : Double  = 1.0
    var numberOfTimesPerMonth : Double = 1.0
    // special usage
    enum daysOfTheWeek : Codable, CaseIterable {
        case monday
        case tuesday
        case wednesday
        case thursday
        case friday
        case saturday
        case sunday
        
        var text : String {
            switch self {
            case .monday : return "Monday"
            case .tuesday : return "Tuesday"
            case .wednesday : return "Wednesday"
            case .thursday : return "Thursday"
            case .friday : return "Friday"
            case .saturday : return "Saturday"
            case .sunday : return "Sunday"
            }
        }
    }
    var dayState : [String: Bool] = [
        daysOfTheWeek.monday.text       : false,
        daysOfTheWeek.tuesday.text      : false,
        daysOfTheWeek.wednesday.text    : false,
        daysOfTheWeek.thursday.text     : false,
        daysOfTheWeek.friday.text       : false,
        daysOfTheWeek.saturday.text     : false,
        daysOfTheWeek.sunday.text       : false
    ]
    
    var scheduledCompletionDates: [Date] = []
    var isGoalCompleted : Bool = false
    var numberOfDaysCompleted : Int { completedDates.count } // computed properties {}
    var dailyHabitCompleted: Bool = false
    var completedDates: Set<String> //of habit
    var deadline : Date
    var startDate : Date = Date()
    
}


extension Goal {
    
    static let sampleGoals: [Goal] = [
        
        .init(title: "Get A for Math", habitTitle: "Do one Math practice paper Daily", selectedFrequencyIndex: Goal.frequency.custom, selectedAnimal:  Animal(name: "fluffy the first", kind: .cow), motivationalQuote: "You'll never do a whole lot unless you're brave enough to try", selectedDailyDeadline: Date(), selectedFixedDeadline: Date(), completedDates: ["20231101"], deadline: Date()),
        
            .init(title: "Lead a healthier Life", habitTitle: "Exercise", selectedFrequencyIndex: Goal.frequency.custom, selectedAnimal:  Animal(name: "fluffy the second", kind: .duck, emotion: Emotion.happy), motivationalQuote: "If you're not positive energy, you're negative energy", selectedDailyDeadline: Date(), selectedFixedDeadline: Date(), completedDates: ["20231101"], deadline: Date()),
        
            .init(title: "Submit Homework On time", habitTitle: "Do Homework according to plan", selectedFrequencyIndex: Goal.frequency.custom, selectedAnimal:  Animal(name: "fluffy the third", kind: .cat, emotion: Emotion.sad), motivationalQuote: "motiovational quotes need to be long...Lorem ipsum dolor sit amet, consectetur adipiscing elit. Ut in massa quis erat viverra porta. Nulla dictum consequat augue et tempor. Etiam nisl risus, gravida in tellus sit amet, posuere porta risus. Ut nec sollicitudin ante. Mauris pulvinar neque tellus, vitae pharetra est porttitor ac. Aenean nec ullamcorper nisl, ac venenatis nunc. Cras ultricies, urna nec porta suscipit, velit elit blandit enim, vel mollis ligula massa nec felis. Quisque cursus urna dolor, id tempus orci porta non. Aliquam viverra, sapien nec consequat pharetra, lorem metus tempus nisi, eu vulputate sem metus vel sapien. Nam mattis felis et iaculis interdum. Aliquam non lorem sed mauris ornare condimentum non a augue. Nulla sed justo pulvinar, facilisis est vel, ullamcorper risus. Nullam quis elit non turpis aliquet tincidunt. Cras vulputate convallis lorem, eget bibendum justo tempor dapibus. Ut feugiat dolor elit, vel interdum urna tristique sed. Aenean faucibus auctor ex, sit amet vulputate ex tempus sit amet.", selectedDailyDeadline: Date(), selectedFixedDeadline: Date(), completedDates: ["20231101"], deadline: Date())



    ]
    
}

func calculateTargetDays(for goal: Goal) -> Double {
    // Assuming you have access to goal's frequency and other relevant data

    let currentDate = Date()
    let calendar = Calendar.current
    
    // Function to check if a date falls within a week
    func isInCurrentWeek(_ date: Date) -> Bool {
        return calendar.isDate(date, equalTo: currentDate, toGranularity: .weekOfYear)
    }
    
    // Function to check if a date falls within a month
    func isInCurrentMonth(_ date: Date) -> Bool {
        return calendar.isDate(date, equalTo: currentDate, toGranularity: .month)
    }
    
    var targetDays : Double = 0.0
    
    switch goal.selectedFrequencyIndex {
    case .daily:
        
        if let deadlineDate = calendar.date(byAdding: .day, value: 1, to: currentDate) {
            let days = calendar.dateComponents([.day], from: currentDate, to: goal.selectedDailyDeadline).day ?? 0
            targetDays += Double(max(0, days))
            
        }
    case .weekly:
        let remainingDaysInWeek = calendar.range(of: .day, in: .weekOfYear, for: currentDate)?.count ?? 0
        let remainingWeeksInMonth = calendar.range(of: .weekOfYear, in: .month, for: currentDate)?.count ?? 0
        let weeklyFrequency = goal.numberOfTimesPerWeek // Example: The user wants to achieve twice a week
        
        targetDays += Double(min(Double(remainingDaysInWeek), Double(remainingWeeksInMonth) * Double(weeklyFrequency)))
    case .monthly:
        if let startOfNextMonth = calendar.date(byAdding: DateComponents(month: 1), to: calendar.startOfDay(for: currentDate)) {
            let remainingDaysInMonth = calendar.range(of: .day, in: .month, for: startOfNextMonth)?.count ?? 0
            let remainingMonthsInYear = calendar.range(of: .month, in: .year, for: currentDate)?.count ?? 0
            let monthlyFrequency = goal.numberOfTimesPerMonth // Example: The user wants to achieve 4 times a month
            
            targetDays += Double(min(Double(remainingDaysInMonth), Double(remainingMonthsInYear) * Double(monthlyFrequency)))
        }
    case .custom:
        
        // Calculate target days for fixed frequency (e.g., specific dates selected)
        // Replace `selectedDates` with actual array of selected dates from Goal struct
        let selectedDates: [Date] = [] // Placeholder for selected dates
        for date in selectedDates {
            if date >= currentDate {
                targetDays += 1
            }
        }
    }
    print("targetDays: \(targetDays)")
    return targetDays
}





//var isAnimalSelected : Bool = false

var autonomy: Double = 0 // not sure if this will/can be used
class UserMetaData : Identifiable, Codable { // for Gradual Autonomy
    // code here
}


extension Date: RawRepresentable {              // Allows date to be added to @AppStorage
    public var rawValue: String {
        self.timeIntervalSinceReferenceDate.description
    }
    
    public init?(rawValue: String) {
        self = Date(timeIntervalSinceReferenceDate: Double(rawValue) ?? 0.0)
    }
}
 


// IMAGE INFO ------------------------
// use the animal name, then the emotion and concatenate to get full imagename from assets catalog, eg animalName: "dog_", emotion(from animal struct): .happy.text -> finalString = "dog_happy" then find filename called dog_happy

