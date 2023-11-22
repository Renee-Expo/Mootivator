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

enum AnimalSelection : String, Codable, CaseIterable{
    case duck = "duck"
    case cat = "cat"
    case dog = "dog"
    case giraffe = "giraffe"
}
extension AnimalSelection {
    var animalKindAsString: String {
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
    var emotion : Int
    var kind : AnimalSelection         // what type/kind/species the animal is
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
    var frequencyOfHabits : String
    var frequency : Array<String>
    var selectedFrequencyIndex : Int
    
    var selectedAnimal : Int
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
    
    static let sampleGoals = [
        Goal(goalEntered: "Get A for Math", deadline: <#T##Date#>, habitEntered: "Do one Math practice paper daily", frequencyOfHabits: <#T##String#>, selectedAnimal: 1, frequency: <#T##Array<String>#>, motivationalQuote: "You've got this", selectedFrequencyIndex: <#T##Int#>, selectedDailyDeadline: <#T##Date#>, numberOfTimesPerWeek: <#T##Int#>, numberOfTimesPerMonth: <#T##Int#>, days: <#T##Array<String>#>, selectedFixedDeadline: <#T##Date#>),
        Goal(goalEntered: "Lead a healthier life", deadline: <#T##Date#>, habitEntered: "Run 2km", frequencyOfHabits: <#T##String#>, selectedAnimal: 2, frequency: <#T##Array<String>#>, motivationalQuote: <#T##String#>, selectedFrequencyIndex: <#T##Int#>, selectedDailyDeadline: <#T##Date#>, numberOfTimesPerWeek: <#T##Int#>, numberOfTimesPerMonth: <#T##Int#>, days: <#T##Array<String>#>, selectedFixedDeadline: <#T##Date#>)
    ]
    
}

var autonomy: Double = 0 // not sure if this will/can be used
class UserMetaData : Identifiable, Codable { // for Gradual Autonomy
    // code here
}
