//
//  ShowingAnimalTabView.swift
//  Ratatouille
//
//  Created by klifton Cheng stu on 18/11/23.
//

import SwiftUI

struct ShowingAnimalSegmentedControlElement: View {
    
    @ObservedObject var goalItemList : GoalItemManager = .shared
    @Binding var selection : Int // controlled by a swipeGesture/Button to increment/decrement for selection of the correct animal
    
    var body: some View {
        VStack {
            Picker(selection: $selection) {
                ForEach($goalItemList.items, id: \.id ) { $goal in
                    Text(goal.title)
                }
            } label: {
                Text("Segmented Control")
            }
            .pickerStyle(.segmented)
        }
    }
}

#Preview {
    ShowingAnimalSegmentedControlElement(selection: .constant(0))
}
