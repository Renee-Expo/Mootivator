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
//    @State private var goalAnimalKind: AnimalKind = .cat
//    @State var goalAnimalEmotion: Emotion = .neutral
//    @Binding var title: String
//    @Binding var selectedAnimal: Int
//    @Binding var deadline: Date
//    @Binding var isGoalCompleted: Bool
//    @Binding var numberOfCompletedGoals : Int
    @Binding var goal : Goal
//    @Binding var goalAnimalEmotion: Animal.emotion
    var body: some View {
        
        VStack {
            Image("\(goal.selectedAnimal.kind.image)" + "\(goal.selectedAnimal.emotion.text)")
                    .resizable()
                    .scaledToFit()
                    .padding()
                Text("Have you achieved your goal: \(goal.title)?")
                    .padding()
                
                VStack {
                    Button {
                        showYesScreen = true
                        goal.isGoalCompleted = true
                        goalManager.numberOfCompletedGoals += 1
                        print("number of goals: \(goalManager.numberOfCompletedGoals)")
                    } label: {
                        Text("Yes")
                            .buttonStyle(.borderedProminent)
                            .fontWeight(.bold)
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
                            .buttonStyle(.borderedProminent)
                            .fontWeight(.bold)
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
            VStack(spacing: 10) {
                Image(systemName: "trophy") //placeholder
                    .font(.system(size: 200))
                    .foregroundColor(Color("AccentColor"))
                    .padding()
                Text("Good Job!")
                    .font(.title)
                    .fontWeight(.medium)
                    .padding(.top)
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
                .buttonStyle(.borderedProminent)
                .fontWeight(.bold)
                .padding()
                .frame(width: 200, height: 50)
                .foregroundColor(.white)
                .background(Color("AccentColor"))
                .cornerRadius(8)
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
            Text("No worries! You can continue with this goal until you achieve it!")
                .font(.title)
                .fontWeight(.bold)
                .multilineTextAlignment(.center)
                .padding()
            Button("Go to Home") {
                withAnimation {
//                    presentationMode.wrappedValue.dismiss()
                    redirectToHome = true
                }
            }
            .buttonStyle(.borderedProminent)
            .fontWeight(.bold)
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
        let goal = Goal(title: "Sample Title", habit: Habit(habitTitle: "Sample Habit", selectedFrequencyIndex: Habit.frequency.daily, selectedDailyDeadline: Date(), completedDates: []), selectedAnimal: Animal(name: "Name of Animal", kind: .cow), motivationalQuote: "imagine the motivational quote",deadline: Date())
        
        GoalCompletionView(goal: .constant(goal))
        .environmentObject(GoalManager())
    }
}
