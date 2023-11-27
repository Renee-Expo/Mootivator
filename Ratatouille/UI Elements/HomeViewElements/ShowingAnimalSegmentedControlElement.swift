//
//  ShowingAnimalTabView.swift
//  Ratatouille
//
//  Created by klifton Cheng stu on 18/11/23.
//

import SwiftUI

struct ShowingAnimalSegmentedControlElement: View {
    
    @EnvironmentObject var goalItemList : GoalManager
    @Binding var selection : Int // controlled by a swipeGesture/Button to increment/decrement for selection of the correct animal
//    @Binding var goalItem : Goal
    
    var body: some View {
        VStack {
            //            Picker(selection: $selection) {
            ForEach($goalItemList.goals, id: \.id ) { $goal in
                VStack {
                    //                        Text(goal.selectedAnimal.name) // this should be navigation title on homeview
                    Image("\(goalItemList.goals[selection].selectedAnimal.kind.image)" + "\(Animal.emotion.self)")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 200)
                        .padding()
                }
            }
//            } label: {
//                Text("Segmented Control")
//            }
            .pickerStyle(.segmented)

        }
    }
}

struct ShowingAnimalSegmentedControlElement_Previews: PreviewProvider {
    static var previews: some View {
        ShowingAnimalSegmentedControlElement(selection: .constant(0))
            .environmentObject(GoalManager())
    }
}
