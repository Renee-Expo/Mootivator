//
//  AnimalView.swift
//  Ratatouille
//
//  Created by Kaveri Mi on 20/11/23.
//

import SwiftUI

struct AnimalView: View {
    
    @ObservedObject var goalManager: GoalManager = .shared
    @Binding var numberOfCompletedGoals: Int
    @State var unlockedAnimals: Set<AnimalKind> = []

    private let adaptiveColumns = [
        GridItem(.adaptive(minimum: 170))
    ]

    @State private var numberOfGoalsNeeded = [0, 2, 4, 6, 8, 10, 13, 16, 20, 25]

    var body: some View {
        NavigationView {
            ScrollView(.vertical) {
                Spacer(minLength: 20)
                Text("Number of completed goals: \(numberOfCompletedGoals)")
                    .font(.system(size: 20))
                    .bold()

                LazyVGrid(columns: adaptiveColumns, spacing: 20) {
                    ForEach(AnimalKind.allCases, id: \.self) { animalKind in
                        let numberInText = numberOfGoalsNeeded[AnimalKind.allCases.firstIndex(of: animalKind)!]
                        let isUnlocked = numberOfCompletedGoals >= numberInText

                        VStack {
                            ZStack {
                                RoundedRectangle(cornerRadius: 8)
                                    .stroke(Color.black, lineWidth: 2)
                                    .frame(width: 150, height: 150)
                                    .opacity(isUnlocked || unlockedAnimals.contains(animalKind) ? 1.0 : 0.5)

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
                                .foregroundColor(.black)
                                .font(.system(size: 12))
                                .bold()
                                .padding(.top, 5)
                        }
                        .onTapGesture {
                            if isUnlocked {
                                unlockedAnimals.insert(animalKind)
                            }
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
//        AnimalView(numberOfCompletedGoals: .constant(0), isAnimalUnlocked: .constant(false))
        AnimalView(numberOfCompletedGoals: .constant(0))
            .environmentObject(GoalManager())
    }
}

