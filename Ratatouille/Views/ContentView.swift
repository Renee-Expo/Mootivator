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
//    @State var showOnBoarding : Bool = true
    @AppStorage("numberOfCompletedGoals") var numberOfCompletedGoals : Int = 0
    @ObservedObject var goalManager: GoalManager = .shared
    @ObservedObject var unlockedAnimalManager : UnlockedAnimalManager = .shared
    
    @State var isActive = false
    @State var goalItemCompletion : Goal = 
    Goal(title: "Sample Title", habitTitle: "Sample Habit Title", selectedFrequencyIndex: Goal.frequency.daily, selectedAnimal: Animal(name: "Name of Animal", kind: .cow), motivationalQuote: "imagine the motivational quote", selectedDailyDeadline: Date(), selectedFixedDeadline: Date(), completedDates: [], deadline: Date())
    
    var body: some View {
        VStack {
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
                //            NotificationView(goal: .constant(Goal(title: "Sample Title", habitTitle: "Sample Habit Title", completedDates: [], deadline: Date(), selectedFrequencyIndex: Goal.frequency.custom, selectedAnimal: Animal(name: "Name of Animal", kind: .cow), motivationalQuote: "imagine the motivational quote", selectedDailyDeadline: Date(), selectedFixedDeadline: Date())))
                //                .tabItem{
                //                    Text("Notifications")
                //                    Image(systemName: "bell.fill")
                //                }
            }
            .navigationDestination(isPresented: $isActive) {
                HabitCompletionView(goal: $goalItemCompletion)
            }
            .fullScreenCover(isPresented: $showOnBoarding) {
                OnboardingView(showOnBoarding: $showOnBoarding)
            }
            .onAppear {
                // check permissions for notifications
                //            UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) { success, error in
                //                if success {
                //                    print("All set!")
                //                } else if let error = error {
                //                    print(error.localizedDescription)
                //                }
                //            }
                
                for animalKind in AnimalKind.allCases {
                    let numberInText = numberOfGoalsNeeded[AnimalKind.allCases.firstIndex(of: animalKind)!]
                    let isUnlocked = numberOfCompletedGoals >= numberInText
                    
                    // update the persisted unlocked animals
                    if (isUnlocked && (!(unlockedAnimalManager.items.contains(animalKind))) ) {
                        unlockedAnimalManager.items.append(animalKind)
                    }
                }
                for goal in goalManager.items {
                    showCompletions(goal: goal)
                }
            }
            .onChange(of: goalManager.items, perform: { newValues in
                for animalKind in AnimalKind.allCases {
                    let numberInText = numberOfGoalsNeeded[AnimalKind.allCases.firstIndex(of: animalKind)!]
                    let isUnlocked = numberOfCompletedGoals >= numberInText
                    
                    // update the persisted unlocked animals
                    if (isUnlocked && (!(unlockedAnimalManager.items.contains(animalKind))) ) {
                        unlockedAnimalManager.items.append(animalKind)
                    }
                }
                for goal in newValues {
                    showCompletions(goal: goal)
                }
            })
        }
    }
    
    //show habitcompletion?
    func showCompletions(goal: Goal) {
        // Set the specific time you want to navigate to the new view (e.g., 12pm)
        var triggerTime = Calendar.current.dateComponents([.hour, .minute], from: goal.deadline)
        triggerTime.second = 0
        
        // Calculate the delay until the specified time
        if let fireDate = Calendar.current.date(from: triggerTime) {
            let delay = fireDate.timeIntervalSinceNow
            
            // Use DispatchQueue to execute code after the delay
            DispatchQueue.main.asyncAfter(deadline: .now() + delay) {
                self.navigateToDestination(goal: goal)
            }
        }
    }
    
    private func navigateToDestination(goal: Goal) {
        // Set isActive to true to trigger the NavigationLink
        isActive = true
        goalItemCompletion = goal
        print("redirected to HabitCompletionView of \(goal.title)")
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()

    }
}
