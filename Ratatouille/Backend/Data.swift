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

struct Animal : Identifiable, Codable {
    var id = UUID()
    
    var name : String
    var kind : AnimalKind         // what type/kind/species the animal is
    enum emotion {
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
}
// change to Goal from Goal.swift?
struct GoalItem : Identifiable, Codable{
    var id = UUID()
    
    var title : String
    var animal : Animal
}

struct Goal: Identifiable, Codable {
    var id = UUID ()
    
    var title : String
    var habitTitle : String
    var deadline : Date
    //    var frequencyOfHabits : String // why string?
    var frequency : Array<String>
    var selectedFrequencyIndex : Int
    
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
}

extension Goal {
    
    static let sampleGoals: [Goal] = [
//        Goal(goalEntered: "Get A for Math", deadline: Date(), habitEntered: "Do one Math practice paper daily", selectedAnimal: 1, frequency: ["Monday", "Wednesday", "Friday"], motivationalQuote: "You've got this", selectedFrequencyIndex: 0, selectedDailyDeadline: Date(), numberOfTimesPerWeek: 3, numberOfTimesPerMonth: 12, selectedFixedDeadline: Date()),
//        Goal(goalEntered: "Lead a healthier life", deadline: Date(), habitEntered: "Run 2km", selectedAnimal: , frequency: ["Everyday"], motivationalQuote: "wergh", selectedFrequencyIndex: 0, selectedDailyDeadline: Date(), numberOfTimesPerWeek: 7.0, numberOfTimesPerMonth: 30.0, selectedFixedDeadline: Date())
        
        Goal(title: "Get A for Math", habitTitle: "Do one Math practice paper Daily", deadline: Date(), frequency: ["Everyday"], selectedFrequencyIndex: 0, selectedAnimal:  Animal(name: "YourAnimalName", kind: .cow), motivationalQuote: "no", selectedDailyDeadline: Date(), selectedFixedDeadline: Date()),
        
        Goal(title: "Lead a healthier Life", habitTitle: "Exercise", deadline: Date(), frequency: ["Everyday"], selectedFrequencyIndex: 0, selectedAnimal:  Animal(name: "YourAnimalName", kind: .cow), motivationalQuote: "no", selectedDailyDeadline: Date(), selectedFixedDeadline: Date())



    ]
    
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


// IMAGE CATALOG ------------------------
// use the animal name, then the emotion and concatenate to get full imagename from assets catalog, eg animalName: "dog_", emotion(from animal struct): .happy.text -> finalString = "dog_happy" then find filename called dog_happy
