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
    @EnvironmentObject var goalManager: GoalManager
    @EnvironmentObject var habitCompletionStatus: HabitCompletionStatus
    
    var body: some View {
        TabView {
            HomeView(habitTitle: .constant(""), title: .constant(""), goalAnimalKind: .constant(AnimalKind.cow), goalAnimalEmotion: .constant(Animal.emotion.happy))
                .tabItem {
                    Text("Home")
                    Image(systemName: "house")
                }
            GoalView(title: .constant("Sample Goal"), habitTitle: .constant("Sample Habit"), isGoalCompleted: .constant(false))
                .tabItem {
                    Text("Goals")
                    Image(systemName: "star.fill")
                }
            AnimalView(numberOfCompletedGoals: .constant(0))
                .tabItem{
                    Text("Animals")
                    Image(systemName: "pawprint.fill")
                }
            NotificationView(goal: .constant(Goal(title: "Sample Title", habitTitle: "Sample Habit Title", deadline: Date(), selectedFrequencyIndex: Goal.frequency.custom, selectedAnimal: Animal(name: "Name of Animal", kind: .cow), motivationalQuote: "imagine the motivational quote", selectedDailyDeadline: Date(), selectedFixedDeadline: Date())))
                .tabItem{
                    Text("Notifications")
                    Image(systemName: "bell.fill")
                }
        }
        .fullScreenCover(isPresented: $showOnBoarding, content: {
            OnboardingView(showOnBoarding: $showOnBoarding)
        })
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(GoalManager())
            .environmentObject(HabitCompletionStatus())
    }
}
