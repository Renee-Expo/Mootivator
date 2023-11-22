//
//  Goal.swift
//  Ratatouille
//
//  Created by Kaveri Mi on 19/11/23.
//

import Foundation

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
    var numberOfTimesPerWeek : Int
    var numberOfTimesPerMonth : Int
    var days : Array<String>
    var selectedFixedDeadline : Date
    var isSaveButtonDisabled : Bool     // Save button is still work in progress
    var mondayChosen : Bool     // really inefficient section.
    var tuesdayChosen : Bool
    var wednesdayChosen : Bool
    var thursdayChosen : Bool
    var fridayChosen : Bool
    var saturdayChosen : Bool
    var sundayChosen : Bool
    
}

extension Goal {
    
    //Todo.sampleTodos
    static let sampleGoals = [
        Goal(goalEntered: "Get A for Math", habitEntered: "Do one Math practice paper daily"),
        Goal(goalEntered: "Lead a healthier life", habitEntered: "Run 2km")
    ]
    
}
