//
//  Data.swift
//  Ratatouille
//
//  Created by klifton Cheng stu on 18/11/23.
//

import Foundation
var autonomy: Double = 0

class userMetaData : Identifiable, Codable { // for Gradual Autonomy
    // code here
}

enum animalSelection : Codable {
    case duck, cat, dog, giraffe
}

struct animal : Identifiable, Codable {
    var id = UUID()
    
    var name : String
    var emotion : Int
    var kind : animalSelection         // what type/kind/species the animal is
}

struct goal : Identifiable, Codable{
    var id = UUID()
    
    var title : String
    var animal : animal
}
