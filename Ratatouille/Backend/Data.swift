//
//  Data.swift
//  Ratatouille
//
//  Created by klifton Cheng stu on 18/11/23.
//

import Foundation
var autonomy: Double = 0

class UserMetaData : Identifiable, Codable { // for Gradual Autonomy
    // code here
}

enum AnimalSelection : Codable {
    case duck, cat, dog, giraffe
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
