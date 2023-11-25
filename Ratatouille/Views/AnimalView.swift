//
//  AnimalView.swift
//  Ratatouille
//
//  Created by Kaveri Mi on 20/11/23.
//

import SwiftUI

struct AnimalView: View {
    @EnvironmentObject var goalManager: GoalManager
    @Binding var numberOfCompletedGoals: Int
    private let adaptiveColumns = [
        GridItem(.adaptive(minimum: 170))
    ]
    
    @State private var numberOfGoalsNeeded = [0, 2, 4, 6, 8, 10, 13, 16, 20, 25]
    
    var body: some View {
        NavigationView {
            ScrollView(.vertical) {
                Spacer(minLength: 20)
                Text ("Number of completed goals: \(numberOfCompletedGoals)")
                    .font(.system(size: 20))
                    .bold()
                
                LazyVGrid(columns: adaptiveColumns, spacing: 20) {
                    ForEach(AnimalKind.allCases.indices, id: \.self) { index in
                        let animalKind = AnimalKind.allCases[index]
                        let numberInText = numberOfGoalsNeeded[index]
                        let isUnlocked = numberOfCompletedGoals >= numberInText
                        
                        VStack{
                            ZStack {
                                RoundedRectangle(cornerRadius: 8)
                                    .stroke(Color.black, lineWidth: 2)
                                    .frame(width: 150, height: 150)
                                    .opacity(isUnlocked ? 1.0 : 0.5)
                                
                                Image("\(animalKind.image)" + "Happy")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 150, height: 150)
                                    .opacity(isUnlocked ? 1.0 : 0.5)
                                
                                Image (systemName: "lock.fill")
                                    .font(.system(size: 45))
                                    .opacity(isUnlocked ? 0.0 : 1.0)
                                
                            }
                            Text("Complete \(numberInText) goals to unlock")
                                .foregroundColor(.black)
                                .font(.system(size: 12))
                                .bold()
                                .padding(.top, 5)
                                .opacity(index == 0 ? 0.0 : 1.0)
                        }
                    }
                }
                .padding()
            }
            .navigationTitle("Animals")
        }
    }
}


struct AnimalView_Previews: PreviewProvider {
    static var previews: some View {
        AnimalView(numberOfCompletedGoals: .constant(0))
            .environmentObject(GoalManager())
    }
}

