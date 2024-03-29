//
//  AnimalView.swift
//  Ratatouille
//
//  Created by Kaveri Mi on 20/11/23.
//

import SwiftUI

struct AnimalView: View {
    
    @ObservedObject var goalManager: GoalManager = .shared
    @ObservedObject var unlockedAnimalManager : UnlockedAnimalManager = .shared
    
//    @Binding var numberOfCompletedGoals: Int
    @State var unlockedAnimals: Set<AnimalKind> = []
    
    private let adaptiveColumns = [
        GridItem(.adaptive(minimum: 170))
    ]
    
    var body: some View {
        NavigationView {
            
            ScrollView(.vertical) {
                Spacer(minLength: 20)
                Text("Number of completed goals: \(goalManager.numberOfCompletedGoals)")
                    .font(.system(size: 20))
                    .bold()
                    .onAppear{
                        print("\(goalManager.numberOfCompletedGoals)")
                    }
                LazyVGrid(columns: adaptiveColumns, spacing: 20) {
                    ForEach(AnimalKind.allCases, id: \.self) { animalKind in
                        let numberInText = numberOfGoalsNeeded[AnimalKind.allCases.firstIndex(of: animalKind)!]
                        let isUnlocked = goalManager.numberOfCompletedGoals >= numberInText
                        VStack {
                            ZStack {
                                RoundedRectangle(cornerRadius: 8)
                                    .stroke(Color.black, lineWidth: 2)
                                    .frame(width: 150, height: 150)
                                    .background(
                                        RoundedRectangle(cornerRadius: 8).opacity(isUnlocked || unlockedAnimals.contains(animalKind) ? 1.0 : 0.5).foregroundColor(.white)
                                    )

                                Image("\(animalKind.image)" + "Happy")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 150, height: 150)
                                    .opacity(isUnlocked || unlockedAnimals.contains(animalKind) ? 1.0 : 0.5)

                                Image(systemName: "lock.fill")
                                    .font(.system(size: 45))
                                    .opacity(isUnlocked ? 0.0 : 1.0)
                            
                            }
                            Text("Complete \(numberInText) goals to unlock")
                                .foregroundColor(.primary)
                                .font(.system(size: 12))
                                .bold()
                                .padding(.top, 5)
                        }
//                        .onTapGesture {
//                            if isUnlocked {
//                                unlockedAnimals.insert(animalKind)
//                            }
//                        }
                    }
                }
                .padding()
            }
            .navigationTitle("Animals")
        }
    }
//    func updateManager(isUnlocked: Bool, animalKind: AnimalKind, arrayItems: inout [AnimalKind]) -> Void{
//
//    }
}





struct AnimalView_Previews: PreviewProvider {
    static var previews: some View {
//        AnimalView(numberOfCompletedGoals: .constant(0), isAnimalUnlocked: .constant(false))
        AnimalView()
    }
}

