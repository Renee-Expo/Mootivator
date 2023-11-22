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
    var isSaveButtonDisabled : Bool     // Save button is still work in progress
    var mondayChosen : Bool     // really inefficient section.
    var tuesdayChosen : Bool
    var wednesdayChosen : Bool
    var thursdayChosen : Bool
    var fridayChosen : Bool
    var saturdayChosen : Bool
    var sundayChosen : Bool
//    var dayChosen: DayChosen
    
}

extension Goal {
    
    //Todo.sampleTodos
//    static let sampleGoals = [
//        Goal(goalEntered: "Get A for Math", deadline: .now, habitEntered: "Eating", frequencyOfHabits: "Weekly", selectedAnimal: 0, frequency: [], motivationalQuote: "Hello world", selectedFrequencyIndex: <#T##Int#>, selectedDailyDeadline: <#T##Date#>, selectedFixedDeadline: <#T##Date#>, isSaveButtonDisabled: <#T##Bool#>, mondayChosen: <#T##Bool#>, tuesdayChosen: <#T##Bool#>, wednesdayChosen: <#T##Bool#>, thursdayChosen: <#T##Bool#>, fridayChosen: <#T##Bool#>, saturdayChosen: <#T##Bool#>, sundayChosen: <#T##Bool#>)
//        Goal(goalEntered: "Get A for Math", habitEntered: "Do one Math practice paper daily"),
//        Goal(goalEntered: "Lead a healthier life", habitEntered: "Run 2km")
//    ] 
    
}

var autonomy: Double = 0 // not sure if this will/can be used
class UserMetaData : Identifiable, Codable { // for Gradual Autonomy
    // code here
}
