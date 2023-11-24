//
//  GoalCompletionView.swift
//  Ratatouille
//
//  Created by Kaveri Mi on 21/11/23.
//
import SwiftUI
struct GoalCompletionView: View {
    
    @EnvironmentObject var goalManager: GoalManager
    @State private var redirectToHome = false
    @State private var showYesScreen = false
    @State private var showNoScreen = false
    @Binding var goalEntered: String
    @Binding var selectedAnimal: AnimalKind
    var isGoalCompleted: Bool
    
    var body: some View {
        VStack {
            Image("\(selectedAnimal)")
                .padding()
            
            Text("Have you achieved your goal: \(goalEntered)?")
            
            HStack {
                Button {
                    showYesScreen = true
                } label: {
                    Text("Yes")
                        .padding()
                        .frame(width: 100, height: 50)
                        .foregroundColor(.white)
                        .background(Color("AccentColor"))
                        .cornerRadius(8)
                }
                .fullScreenCover(isPresented: $showYesScreen) {
                    YesScreen()
                }
                
                Button {
                    showNoScreen = true
                } label: {
                    Text("No")
                        .padding()
                        .frame(width: 100, height: 50)
                        .foregroundColor(.white)
                        .background(Color("AccentColor"))
                        .cornerRadius(8)
                }
                .fullScreenCover(isPresented: $showNoScreen) {
                    NoScreen()
                }
            }
        }
    }
}
struct YesScreen: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    var body: some View {
        VStack {
            Text("Yay, you did it!")
                .font(.title)
                .fontWeight(.bold)
                .padding()
            
            Button("Go to Home") {
                presentationMode.wrappedValue.dismiss()
            }
            .padding()
            .frame(width: 200, height: 50)
            .foregroundColor(.white)
            .background(Color("AccentColor"))
            .cornerRadius(8)
        }
    }
}
struct NoScreen: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    var body: some View {
        VStack {
            Text("Try again!")
                .font(.title)
                .fontWeight(.bold)
                .padding()
            
            Button("Go to Home") {
                presentationMode.wrappedValue.dismiss()
            }
            .padding()
            .frame(width: 200, height: 50)
            .foregroundColor(.white)
            .background(Color("AccentColor"))
            .cornerRadius(8)
        }
    }
}
struct GoalCompletionView_Previews: PreviewProvider {
    static var previews: some View {
        GoalCompletionView(goalEntered: .constant("Sample Goal"), selectedAnimal: AnimalKind, isGoalCompleted: true)
            .environmentObject(GoalManager())
    }
}
//import SwiftUI
//
//struct GoalCompletionView: View {
//
//    @EnvironmentObject var goalManager: GoalManager
//    @State private var showConfirmationScreen = true
//    @State private var redirectToHome = false
//    @Binding var goalEntered: String
//    var isGoalCompleted: Bool
//
//    var body: some View {
//        VStack {
//            Image("HappyDuck")
//                .padding()
//
//            Text("Have you achieved your goal: \(goalEntered)?")
//
//            Button {
//                showConfirmationScreen = false
//                isGoalCompleted = true
//            } label: {
//                Text("Yes")
//                    .padding()
//                    .frame(width: 200, height: 50)
//                    .foregroundColor(.white)
//                    .background(Color("AccentColor"))
//                    .cornerRadius(8)
//            }
//            .fullScreenCover(isPresented: $redirectToHome) {
//                HomeView()
//            }
//
//            Button {
//                showConfirmationScreen = false
//                isGoalCompleted = false
//            } label: {
//                Text("No")
//                    .padding()
//                    .frame(width: 200, height: 50)
//                    .foregroundColor(.white)
//                    .background(Color("AccentColor"))
//                    .cornerRadius(8)
//            }
//        }
//    }
//}
//
//                                       VStack {
//                                           Image(systemName: isGoalCompleted ? "checkmark.circle":"xmark.circle")
//                                               .foregroundColor(Color(isGoalCompleted ? "AccentColor":"red"))
//                                               .font(.system(size: 100))
//                                               .padding()
//                                           Text(isGoalCompleted ? "Goal Complete!  Well done!":"Goal incomplete")
//                                               .font(.system(size: 24))
//                                               .fontWeight(.medium)
//
//                                           Text(isGoalCompleted ? "Keep up the good work!":"It’s ok! Try again, you’ve got this!")
//                                               .font(.system(size: 24))
//                                               .multilineTextAlignment(.center)
//                                               .fontWeight(.medium)
//                                               .padding()
//
//                                           Button {
//                                               redirectToHome = true
//                                           } label: {
//                                               Text("Go to Home")
//                                                   .padding()
//                                                   .frame(width: 200, height: 50)
//                                                   .foregroundColor(.white)
//                                                   .background(Color("AccentColor"))
//                                                   .cornerRadius(8)
//                                           }
//                                           .fullScreenCover(isPresented: $redirectToHome, content: {
//                                               HomeView()
//                                           })
//                                           .padding()
//                                       }
//                                   }
//                               }
//
//                               struct GoalCompletionView_Previews: PreviewProvider {
//                static var previews: some View {
//                    GoalCompletionView(isGoalCompleted: true)
//                        .environmentObject(GoalManager())
//                }
//            }
//
//
