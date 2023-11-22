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

//enum DayChosen {
//    case monday, tuesday, wednesday, thursday, friday, saturday, sunday
//}

struct Goal: Identifiable, Codable {
    var id = UUID ()
    var goalEntered : String
    var deadline : Date
    var habitEntered : String
    var frequencyOfHabits : String
    var selectedAnimal : Int
    var frequency : Array<String>
    var motivationalQuote : String
    var selectedFrequencyIndex : Int
    var selectedDailyDeadline : Date
    var numberOfTimesPerWeek = 1.0
    var numberOfTimesPerMonth = 1.0
    var selectedFixedDeadline : Date
    var mondayChosen : Bool     // really inefficient section.
    var tuesdayChosen : Bool
    var wednesdayChosen : Bool
    var thursdayChosen : Bool
    var fridayChosen : Bool
    var saturdayChosen : Bool
    var sundayChosen : Bool
//    var dayChosen: DayChosen
    
}
//enum Day: String, CaseIterable, Codable{
//    case monday, tuesday, wednesday, thurday, friday, saturday, sunday
//}

//extension Goal {
//
//    static let sampleGoals = [
//        Goal(goalEntered: "Get A for Math", deadline: <#T##Date#>, habitEntered: "Do one Math practice paper daily", frequencyOfHabits: <#T##String#>, selectedAnimal: 1, frequency: <#T##Array<String>#>, motivationalQuote: "You've got this", selectedFrequencyIndex: <#T##Int#>, selectedDailyDeadline: <#T##Date#>, numberOfTimesPerWeek: Double, numberOfTimesPerMonth: Double,  selectedFixedDeadline: <#T##Date#>),
//        Goal(goalEntered: "Lead a healthier life", deadline: <#T##Date#>, habitEntered: "Run 2km", frequencyOfHabits: <#T##String#>, selectedAnimal: 2, frequency: <#T##Array<String>#>, motivationalQuote: <#T##String#>, selectedFrequencyIndex: <#T##Int#>, selectedDailyDeadline: <#T##Date#>, numberOfTimesPerWeek: Double, numberOfTimesPerMonth: Double, selectedFixedDeadline: <#T##Date#>)
//    ]
//
//}

var autonomy: Double = 0 // not sure if this will/can be used
class UserMetaData : Identifiable, Codable { // for Gradual Autonomy
    // code here
}
