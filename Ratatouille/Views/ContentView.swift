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
    @AppStorage("numberOfCompletedGoals") var numberOfCompletedGoals : Int = 20
    @ObservedObject var goalManager: GoalManager = .shared
//    @EnvironmentObject var habitCompletionStatus: HabitCompletionStatus
    
    var body: some View {
        TabView {
            HomeView(habitTitle: .constant(""), title: .constant(""), goalAnimalKind: .constant(AnimalKind.cow), goalAnimalEmotion: .constant(Emotion.happy), motivationalQuote: .constant(""))
                .tabItem {
                    Text("Home")
                    Image(systemName: "house")
                }
            GoalView(title: .constant("Sample Goal"), habitTitle: .constant("Sample Habit"), isGoalCompleted: .constant(false))
                .tabItem {
                    Text("Goals")
                    Image(systemName: "star.fill")
                }
            AnimalView(numberOfCompletedGoals: $numberOfCompletedGoals)
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
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(GoalManager())
    }
}
