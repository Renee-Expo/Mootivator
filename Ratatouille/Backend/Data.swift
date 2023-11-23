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
    case duck
    case cat
    case dog
    case giraffe
    
    var asString: String {
        switch self {
        case .duck      : return "duck"
        case .cat       : return "cat"
        case .dog       : return "dog"
        case .giraffe   : return "giraffe"
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

//enum DayChosen {
//    case monday, tuesday, wednesday, thursday, friday, saturday, sunday
//}

struct Goal: Identifiable, Codable {
    var id = UUID ()
    
    var title : String
    var habitTitle : String
    var deadline : Date
    var frequencyOfHabits : String // why string?
    var frequency : Array<String>
    var selectedFrequencyIndex : Int
    
    var selectedAnimal : Animal
    var motivationalQuote : String // does the motivational quote change?
    
    var selectedDailyDeadline : Date // is this a time?
    var selectedFixedDeadline : Date // date + time ?
    
    var numberOfTimesPerWeek : Double  = 1.0 // can be computed from frequency
    var numberOfTimesPerMonth : Double = 1.0 // can be computed from frequency
    var days : Array<String>   // I would prefer to use an enum or set
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
    
 /*
    var mondayChosen : Bool     // really inefficient section.
    var tuesdayChosen : Bool
    var wednesdayChosen : Bool
    var thursdayChosen : Bool
    var fridayChosen : Bool
    var saturdayChosen : Bool
    var sundayChosen : Bool
*/
}
//enum Day: String, CaseIterable, Codable{
//    case monday, tuesday, wednesday, thurday, friday, saturday, sunday
//}

extension Goal {
    
    static let sampleGoals: [Goal] = [
//        Goal(goalEntered: "Get A for Math", deadline: Date(), habitEntered: "Do one Math practice paper daily", selectedAnimal: 1, frequency: <#T##Array<String>#>, motivationalQuote: "You've got this", selectedFrequencyIndex: <#T##Int#>, selectedDailyDeadline: <#T##Date#>, numberOfTimesPerWeek: 1, numberOfTimesPerMonth: 4,  selectedFixedDeadline: Date()),
//        Goal(goalEntered: "Lead a healthier life", deadline: <#T##Date#>, habitEntered: "Run 2km", selectedAnimal: 2, frequency: <#T##Array<String>#>, motivationalQuote: <#T##String#>, selectedFrequencyIndex: <#T##Int#>, selectedDailyDeadline: <#T##Date#>, numberOfTimesPerWeek: Double, numberOfTimesPerMonth: Double, selectedFixedDeadline: <#T##Date#>)
    ]
    
}

var autonomy: Double = 0 // not sure if this will/can be used
class UserMetaData : Identifiable, Codable { // for Gradual Autonomy
    // code here
}
