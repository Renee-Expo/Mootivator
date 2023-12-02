//
//  ContentView.swift
//  Ratatouille
//
//  Created by rgs on 4/9/23.
//

import SwiftUI

// Don't code in this View, its the main holding view, so tab bars, sidebars, etc.

struct ContentView: View {
    
    @AppStorage("showOnBoarding") var showOnBoarding : Bool = true
    @AppStorage("numberOfCompletedGoals") var numberOfCompletedGoals : Int = 0
    @ObservedObject var goalManager: GoalManager = .shared
    @ObservedObject var unlockedAnimalManager : UnlockedAnimalManager = .shared
    
    var body: some View {
        TabView {
            HomeView(goalAnimalEmotion: .constant(Emotion.neutral))
                .tabItem {
                    Text("Home")
                    Image(systemName: "house")
                }
            GoalView()
                .tabItem {
                    Text("Goals")
                    Image(systemName: "star.fill")
                }
            AnimalView(numberOfCompletedGoals: numberOfCompletedGoals)
                .tabItem{
                    Text("Animals")
                    Image(systemName: "pawprint.fill")
                }
            NotificationView(goal: .constant(Goal(title: "Sample Title", habitTitle: "Sample Habit Title", completedDates: [], deadline: Date(), selectedFrequencyIndex: Goal.frequency.custom, selectedAnimal: Animal(name: "Name of Animal", kind: .cow), motivationalQuote: "imagine the motivational quote", selectedDailyDeadline: Date(), selectedFixedDeadline: Date())))
                .tabItem{
                    Text("Notifications")
                    Image(systemName: "bell.fill")
                }
        }
        .fullScreenCover(isPresented: $showOnBoarding, content: {
            OnboardingView(showOnBoarding: $showOnBoarding)
        })
        .onAppear {
            for animalKind in AnimalKind.allCases {
                let numberInText = numberOfGoalsNeeded[AnimalKind.allCases.firstIndex(of: animalKind)!]
                let isUnlocked = numberOfCompletedGoals >= numberInText
//                print("number in text: \(numberInText)")
//                print("numberOfCompletedGoals >= numberInText \(numberOfCompletedGoals >= numberInText)")
                
                // update the persisted unlocked animals
                if (isUnlocked && (!(unlockedAnimalManager.items.contains(animalKind))) ) {
                    unlockedAnimalManager.items.append(animalKind)
//                    print("It happened")
                }
            }
        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()

    }
}
