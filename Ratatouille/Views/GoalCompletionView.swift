//

//  GoalCompletionView.swift

//  Ratatouille

//

//  Created by Kaveri Mi on 21/11/23.

//

import SwiftUI

struct GoalCompletionView: View {
    @EnvironmentObject var goalManager: GoalManager
    @State private var showGoalCompletionView = false
    @State private var showConfirmationScreen = true
    @State private var showYesScreen = false
    @State private var showNoScreen = false
    @Binding var title: String
    @Binding var selectedAnimal: Int
    @Binding var deadline: Date
    @State var isGoalCompleted: Bool //not sure if this works bc it's not private var
    @Binding var numberOfCompletedGoals : Int
    var body: some View {
        
        VStack {
            if showGoalCompletionView{
                Image("\(selectedAnimal)")
                    .resizable()
                    .scaledToFit()
                    .padding()
                Text("Have you achieved your goal: \(title)?")
                    .padding()
                
                VStack {
                    Button {
                        showYesScreen = true
                        isGoalCompleted = true
                        numberOfCompletedGoals = numberOfCompletedGoals + 1
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
                        isGoalCompleted = false
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
        .onAppear{
            if Date() >= deadline {
                // If the current date is greater than or equal to the target date, show the content
                //            withAnimation {
                showGoalCompletionView = true
                //            }
            }
        }
        
    }
}

struct YesScreen: View {
    @State private var redirectToHome = false
    @State private var showConfirmationScreen = true
    var isGoalCompleted: Bool
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    var body: some View {
        VStack {
            Image(systemName: "checkmark.circle") //placeholder
                .font(.system(size: 100))
            Text("Yay, you did it!")
                .font(.title)
                .fontWeight(.bold)
                .padding()
            
            Button("Go to Home") {
                presentationMode.wrappedValue.dismiss()
                redirectToHome = true
                showConfirmationScreen = false
            }
            .padding()
            .frame(width: 200, height: 50)
            .foregroundColor(.white)
            .background(Color("AccentColor"))
            .cornerRadius(8)
        }
        
        .fullScreenCover(isPresented: $redirectToHome) {
            HomeView(habitTitle: .constant(""), title: .constant(""))
            
        }
    }
}

struct NoScreen: View {
    
    @State private var redirectToHome = false
    var isGoalCompleted: Bool
    @State private var showConfirmationScreen = true
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    var body: some View {
        
        VStack {
            Image(systemName: "xmark.circle")
                .foregroundColor(.red)
                .font(.system(size: 100))
            Text("Try again!")
                .font(.title)
                .fontWeight(.bold)
                .padding()
            Button("Go to Home") {
                presentationMode.wrappedValue.dismiss()
                redirectToHome = true
                showConfirmationScreen = false
            }
            .padding()
            .frame(width: 200, height: 50)
            .foregroundColor(.white)
            .background(Color("AccentColor"))
            .cornerRadius(8)
        }
        .fullScreenCover(isPresented: $redirectToHome) {
            HomeView(habitTitle: .constant(""), title: .constant(""))
        }
    }
}

struct GoalCompletionView_Previews: PreviewProvider {
    static var previews: some View {
        GoalCompletionView(title: .constant("Sample Goal"), selectedAnimal: .constant(0), deadline: .constant(Date()), isGoalCompleted: false, numberOfCompletedGoals: .constant(0))
            .environmentObject(GoalManager())
    }
}

