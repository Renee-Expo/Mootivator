//

//  GoalCompletionView.swift

//  Ratatouille

//

//  Created by Kaveri Mi on 21/11/23.

//

import SwiftUI
import ConfettiSwiftUI

struct GoalCompletionView: View {
    @ObservedObject var goalManager: GoalManager = .shared
//    @EnvironmentObject var habitCompletionStatus: HabitCompletionStatus
//    @State private var showConfirmationScreen = true
    @State private var showYesScreen = false
    @State private var showNoScreen = false
    @State var goalAnimalKind: AnimalKind = .cat
//    @State var goalAnimalEmotion: Emotion = .neutral
//    @Binding var title: String
//    @Binding var selectedAnimal: Int
//    @Binding var deadline: Date
//    @Binding var isGoalCompleted: Bool
    @Binding var numberOfCompletedGoals : Int
    @Binding var goal : Goal
//    @Binding var goalAnimalEmotion: Animal.emotion
    var body: some View {
        
        VStack {
                Image("\(goalAnimalKind.image)" + "\(goal.selectedAnimal.emotion.text)")
                    .resizable()
                    .scaledToFit()
                    .padding()
                Text("Have you achieved your goal: \(goal.title)?")
                    .padding()
                
                VStack {
                    Button {
                        showYesScreen = true
                        goal.isGoalCompleted = true
                        numberOfCompletedGoals += 1
                        print("number of goals: \(numberOfCompletedGoals)")
                    } label: {
                        Text("Yes")
                            .padding()
                            .frame(width: 200, height: 50)
                            .foregroundColor(.white)
                            .background(Color("AccentColor"))
                            .cornerRadius(8)
                    }
                    
                    .fullScreenCover(isPresented: $showYesScreen) {
                        YesScreen(isGoalCompleted: true)
                        
                    }
                    
                    Button {
                        showNoScreen = true
                    } label: {
                        Text("No")
                            .padding()
                            .frame(width: 200, height: 50)
                            .foregroundColor(.white)
                            .background(Color("AccentColor"))
                            .cornerRadius(8)
                    }
                    
                    .fullScreenCover(isPresented: $showNoScreen) {
                        NoScreen(isGoalCompleted: false)
                    }
                }
        }
        
    }
}

struct YesScreen: View {
    @State private var redirectToHome = false
    //    @State private var showConfirmationScreen = true
    @State private var counter = 50
    var isGoalCompleted: Bool
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    var body: some View {
        ZStack {
            VStack {
                Image(systemName: "trophy") //placeholder
                    .font(.system(size: 200))
                    .foregroundColor(Color("AccentColor"))
                    .padding()
                Text("Good Job!")
                    .font(.title)
                    .fontWeight(.medium)
                    .padding()
                Text("Keep up the good work!")
                    .font(.title)
                    .fontWeight(.medium)
                    .padding()
                
                Button("Go to Home") {
                    
                    withAnimation {
//                        presentationMode.wrappedValue.dismiss()
                        redirectToHome = true
                    }
                    //                    showConfirmationScreen = false
                }
                .frame(width: 200, height: 50)
                .foregroundColor(.white)
                .background(Color("AccentColor"))
                .cornerRadius(8)
                .padding()
            }
            
            //
            //            }
            ConfettiCannon(counter: $counter)
                .onAppear {
                    withAnimation{
                        counter += 1
                    }
                }
        }
        .fullScreenCover(isPresented: $redirectToHome) {
            ContentView()
        }
        .confettiCannon(counter: $counter, num: 100, radius: 500)
    }
}
    
struct NoScreen: View {
    
    @State private var redirectToHome = false
    var isGoalCompleted: Bool
    //        @State private var showConfirmationScreen = true
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    var body: some View {
        
        VStack {
            Image(systemName: "xmark.circle")
                .font(.system(size: 200))
                .foregroundColor(.red)
                .padding()
            Text("No worries!")
                .font(.title)
                .fontWeight(.bold)
                .padding()
            Button("Go to Home") {
                withAnimation {
//                    presentationMode.wrappedValue.dismiss()
                    redirectToHome = true
                }
            }
            .padding()
            .frame(width: 200, height: 50)
            .foregroundColor(.white)
            .background(Color("AccentColor"))
            .cornerRadius(8)
        }
        .fullScreenCover(isPresented: $redirectToHome) {
            ContentView()
        }
    }
}
    
struct GoalCompletionView_Previews: PreviewProvider {
    static var previews: some View {
        
        let goal = Goal(title: "Sample Title", habitTitle: "Sample Habit Title", selectedFrequencyIndex: Goal.frequency.daily, selectedAnimal: Animal(name: "Name of Animal", kind: .cow), motivationalQuote: "imagine the motivational quote", selectedDailyDeadline: Date(), selectedFixedDeadline: Date() + 5, completedDates: [], deadline: Date())
        
        GoalCompletionView(numberOfCompletedGoals: .constant(0), goal: .constant(goal))
        .environmentObject(GoalManager())
    }
}
