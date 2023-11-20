//
//  ShowingAnimalTabView.swift
//  Ratatouille
//
//  Created by klifton Cheng stu on 18/11/23.
//

import SwiftUI

struct ShowingAnimalTabView: View {
    
    @ObservedObject var goalItemList : GoalItemManager = .shared
    @Binding var selection : Int // controlled by a swipeGesture/Button to increment/decrement for selection of the correct animal
    
    var body: some View {
        VStack {
            Picker(selection: $selection) {
                ForEach($goalItemList.items, id: \.id ) { $goal in
                    Text(goal.title)
                }
            } label: {
                Text("no")
            }
            .pickerStyle(.segmented)
        }
    }
}


struct ShowingAnimalTabView_Previews: PreviewProvider {
    static var previews: some View {
        ShowingAnimalTabView(selection: .constant(0))
    }
}

