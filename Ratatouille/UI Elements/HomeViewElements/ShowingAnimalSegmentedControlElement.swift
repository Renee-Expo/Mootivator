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
            if goalItemList.goals.count > 1 {
                TabView {
                    ForEach($goalItemList.goals, id: \.id ) { _ in
                        VStack {
                            Image("\(goalItemList.goals[selection].selectedAnimal.kind.image)" + "\(emotion.text)")
                                .resizable()
                                .scaledToFit()
                                .padding(.horizontal)
                                .frame(width: 200)
                                .background(Color.accentColor)
                                .clipShape(Circle())
                                .padding(.bottom, 10)
                            Text(goalItemList.goals[selection].selectedAnimal.name)
                        }
                    }
                }
                .tabViewStyle(PageTabViewStyle())
                .indexViewStyle(.page(backgroundDisplayMode: .automatic))
                .scaledToFill()
            } else {
                Text("You have no current goals!")
            }
        }
    }
}

struct ShowingAnimalSegmentedControlElement_Previews: PreviewProvider {
    static var previews: some View {
        ShowingAnimalSegmentedControlElement(selection: .constant(0), emotion: .constant(Animal.emotion.sad))
            .environmentObject(GoalManager())
    }
}
