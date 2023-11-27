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
    @Binding var emotion : Animal.emotion
    
    var body: some View {
        VStack {
            Image("\(goalItemList.goals[selection].selectedAnimal.kind.image)" + "\(emotion.text)")
                .resizable()
                .scaledToFit()
                .frame(width: 200)
                .padding()
            Picker(selection: $selection) {
                ForEach($goalItemList.goals, id: \.id ) { _ in
                    Text(goalItemList.goals[selection].selectedAnimal.name)
                }
            } label: {
                Text("Segmented Control")
            }
                .pickerStyle(.segmented)
                
            }
    }
}

struct ShowingAnimalSegmentedControlElement_Previews: PreviewProvider {
    static var previews: some View {
        ShowingAnimalSegmentedControlElement(selection: .constant(0), emotion: .constant(Animal.emotion.sad))
            .environmentObject(GoalManager())
    }
}
