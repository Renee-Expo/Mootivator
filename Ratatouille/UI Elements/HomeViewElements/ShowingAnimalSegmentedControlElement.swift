//
//  ShowingAnimalTabView.swift
//  Ratatouille
//
//  Created by klifton Cheng stu on 18/11/23.
//

import SwiftUI

struct ShowingAnimalSegmentedControlElement: View {
    
    @ObservedObject var goalManager: GoalManager = .shared
    @Binding var selection : Int // controlled by a swipeGesture/Button to increment/decrement for selection of the correct animal
//    @Binding var goalItem : Goal
    
    var body: some View {
        
        VStack {
            if goalManager.items.count > 0 {
                TabView {
                    ForEach(goalManager.items, id: \.id ) { item in
                        VStack {
                            Image("\(item.selectedAnimal.kind.image)" + "\(item.selectedAnimal.emotion.text)")
                                .resizable()
                                .scaledToFit()
                                .padding(.horizontal)
                                .frame(width: 200)
                                .background(Color.accentColor)
                                .clipShape(Circle())
                                .padding(.bottom, 10)
                            Text(item.selectedAnimal.name)
                        }
                        .tabViewStyle(PageTabViewStyle())
//                        .indexViewStyle(.page(backgroundDisplayMode: .always))
//                        .pickerStyle(.segmented)
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
        ShowingAnimalSegmentedControlElement(selection: .constant(0))
            .environmentObject(GoalManager())
    }
}
