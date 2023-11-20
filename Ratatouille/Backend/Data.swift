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

struct GoalItem : Identifiable, Codable{
    var id = UUID()
    
    var title : String
    var animal : Animal
}

var autonomy: Double = 0 // not sure if this will/can be used
class UserMetaData : Identifiable, Codable { // for Gradual Autonomy
    // code here
}
