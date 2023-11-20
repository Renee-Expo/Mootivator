//
//  Goal.swift
//  Ratatouille
//
//  Created by Kaveri Mi on 19/11/23.
//

import Foundation

struct Goal: Identifiable, Codable{
    
    var id = UUID ()
    var goalName = String()
    var currentHabit = String()
    
}
