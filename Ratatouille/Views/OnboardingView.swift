//
//  OnboardingView.swift
//  Ratatouille
//
//  Created by klifton Cheng stu on 18/11/23.
//

import SwiftUI

struct OnboardingView : View {
    @Binding var showOnBoarding : Bool
    var body: some View {
        TabView {
            VStack(){
                Text("Welcome to (app name)!")
                    .lineLimit(1)
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .multilineTextAlignment(.center)
//                    .position(x:180, y: 180)
                    .padding(.top, 50)
                    .padding(.horizontal)
                Spacer().frame(height: 100)
                VStack(alignment: .leading, spacing: 35) {
                    HStack {
                        Image(systemName: "pencil")
                            .font(.system(size: 32))
                            .foregroundColor(Color("AccentColor"))
                        
                        VStack(alignment: .leading) {
                            Text("Transform Goals into Achievable Habits")
                                .lineLimit(1)
                                .fontWeight(.medium)
                                .font(.system(size: 20))
                            
                            Text("Break down big goals into manageable habits")
                                .font(.system(size: 16))
                                .multilineTextAlignment(.leading)
                                .fontWeight(.medium)
                                .foregroundColor(Color(.secondaryLabel))
                        }
                    }
                    
                    HStack {
                        Image(systemName: "powersleep")
                            .font(.system(size: 32))
                            .foregroundColor(Color("AccentColor"))
                        
                        VStack(alignment: .leading) {
                            Text("Take Care of Your Pets")
                                .font(.system(size: 20))
                                .fontWeight(.medium)
                            
                            Text("Check off your habits to keep your companions happy")
                                .font(.system(size: 16))
                                .multilineTextAlignment(.leading)
                                .fontWeight(.medium)
                                .foregroundColor(Color(.secondaryLabel))
                        }
                    }
                    HStack {
                        Image(systemName: "checkmark.circle")
                            .font(.system(size: 32))
                            .foregroundColor(Color("AccentColor"))
                        
                        VStack(alignment: .leading) {
                            Text("Achieve Your Goals")
                                .lineLimit(1)
                                .fontWeight(.medium)
                                .font(.system(size: 20))
                            
                            Text("Slowly increase the difficulty of each habit to help achieve your final goals")
                                .font(.system(size: 16))
                                .multilineTextAlignment(.leading)
                                .fontWeight(.medium)
                                .foregroundColor(Color(.secondaryLabel))
                        }
                    }
                }
                .padding(.horizontal, 20)
                Spacer().frame(height: 100)
            }
                    
            
            PageView(title: "Set Goals",
                     subtitle: "Select when you hope to achieve this goal.\n" + "Pick an animal to represent this goal!\n" + "This companion will be shown on the home screen.\n" + "Complete goals to unlock companions.\n",
                     imageName: "goal_img",
                     showStartButton: false,
                     showGoalSheet: false,
                     showOnBoarding: $showOnBoarding)
            PageView(title: "Set Current Habits",
                     subtitle: "Set a habit frequency and target completion date.\n" + "Gradually increase difficulty after achieving each habit to make reaching your final goal easier!", imageName: "habit_img",
                     showStartButton: false,
                     showGoalSheet: false,
                     showOnBoarding: $showOnBoarding)
            PageView(title: "Motivate Yourself",
                     subtitle: "Write down a quote, word or phrase that will motivate you to complete your current habits and final goal!\n" +  "This will be shown on the home screen",
                     imageName: "motivation_img",
                     showStartButton: false,
                     showGoalSheet: true,
                     showOnBoarding: $showOnBoarding)
            PageView(title: "Completing habits",
                     subtitle: "To mark ypur habit as complete, click on the day which you had done your habit.\n" + "When you see the pop-up, click the complete button to save your progress",
                     imageName: "list.clipboard",
                     showStartButton: true,
                     showGoalSheet: false,
                     showOnBoarding: $showOnBoarding)
                    
                }
                .tabViewStyle(PageTabViewStyle())
                .indexViewStyle(.page(backgroundDisplayMode: .always))
            }
        }

//reuseable component
struct PageView : View {
    let title: String
    let subtitle: String
    let imageName : String
    let showStartButton : Bool
    let showGoalSheet : Bool
    @Binding var showOnBoarding : Bool
    @State private var showNewGoalSheet = false

    var body : some View {
        VStack(spacing: 10) {
            Image(imageName)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 400, height: 250)

            Text(title)
                .font(.title)
                .fontWeight(.medium)

            Text(subtitle)
                .font(.system(size: 20))
                .multilineTextAlignment(.leading)
                .fontWeight(.medium)
                .foregroundColor(Color(.secondaryLabel))
                .padding()

            if showStartButton {
                Button(action: {
                    showOnBoarding.toggle()
                }) {
                    Text("Back to home screen")
                        .frame(width: 200, height: 50)
                        .foregroundColor(.white)
                        .background(Color("AccentColor"))
                        .cornerRadius(8)
                }
            }

            if showGoalSheet {
                Button(action: {
                    showNewGoalSheet = true
                }) {
                    Text("Set your first goal!")
                        .frame(width: 200, height: 50)
                        .foregroundColor(.white)
                        .background(Color("AccentColor"))
                        .cornerRadius(8)
                }
                .sheet(isPresented: $showNewGoalSheet) {
                    // Define the content of the sheet here
                    Text("This is your goal-setting sheet!")
                    // Add any additional views or components you need
                }
            }
        }
        .padding(.horizontal, 5)
    }
}

struct OnboardingView_Previews: PreviewProvider {
    static var previews: some View {
        let showOnBoarding = Binding.constant(true)
        OnboardingView(showOnBoarding: showOnBoarding)
    }
}
