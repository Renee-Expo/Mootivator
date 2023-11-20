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
            VStack{
                Text("Welcome to (app name)!")
                    .lineLimit(1)
                    .font(.system(size: 32))
                    .multilineTextAlignment(.leading)
                    .padding()
                VStack {
                    HStack {
                        Image(systemName: "pencil")
                            .font(.system(size: 32))
                            .foregroundColor(Color("Green 2"))
                        
                        VStack(alignment: .leading) {
                            Text("Transform Goals into Achievable Habits")
                                .lineLimit(1)
                                .font(.system(size: 20))
                            
                            Text("Break down big goals into manageable habits")
                                .font(.system(size: 16))
                                .multilineTextAlignment(.leading)
                                .foregroundColor(Color(.secondaryLabel))
                        }
                    }
                    
                    HStack {
                        Image(systemName: "checkmark.circle")
                            .font(.system(size: 32))
                            .foregroundColor(Color("Green 2"))
                        
                        VStack(alignment: .leading) {
                            Text("Take Care of Your Pets")
                                .font(.system(size: 20))
                            
                            Text("Check off your habits to keep your companions happy")
                                .font(.system(size: 16))
                                .multilineTextAlignment(.leading)
                                .foregroundColor(Color(.secondaryLabel))
                        }
                    }
                    HStack {
                        Image(systemName: "checkmark.circle")
                            .font(.system(size: 32))
                            .foregroundColor(Color("Green 2"))
                        
                        VStack(alignment: .leading) {
                            Text("Transform Goals into Achievable Habits")
                                .lineLimit(1)
                                .font(.system(size: 20))
                            
                            Text("Break down big goals into manageable habits")
                                .font(.system(size: 16))
                                .multilineTextAlignment(.leading)
                                .foregroundColor(Color(.secondaryLabel))
                        }
                    }
                }
            }
                    
            
            PageView(title: "Set Goals" , subtitle: "Select when you hope to achieve this goal. Pick an animal to represent this goal! This companion will be shown on the home screen. Complete goals to unlock companions.", imageName: "goal img", showStartButton: false, showOnBoarding: $showOnBoarding)
            PageView(title: "Set Current Habits" , subtitle: "Set a manageable habit. Select how often you hope to complete this habit. Select when you hope to achieve this habit by. After achieving this habit, you may set a slightly more challenging habit to achieve. By slowly increasing the difficulty of each habit, it will be easier to achieve your final goal!", imageName: "habit img", showStartButton: false, showOnBoarding: $showOnBoarding)
            PageView(title: "Set Goals" , subtitle: "Select when you hope to achieve this goal. Pick an animal to represent this goal! This companion will be shown on the home screen. Complete goals to unlock companions.", imageName: "list.clipboard", showStartButton: true, showOnBoarding: $showOnBoarding)
                    
                }
                .tabViewStyle(PageTabViewStyle())
            }
        }

//reuseable component
struct PageView : View {
    let title: String
    let subtitle: String
    let imageName : String
    let showStartButton : Bool
    @Binding var showOnBoarding : Bool
    var body : some View {
        VStack {
            Image(systemName: imageName)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 150, height: 150)
                .padding()
            Text(title)
                .font(.system(size: 32))
                .padding()
            Text(subtitle)
                .font(.system(size: 24))
                .multilineTextAlignment(.center)
                .foregroundColor(Color(.secondaryLabel))
                .padding()
            if showStartButton{
                Button(action: {
                    showOnBoarding.toggle()
                }, label: {
                    Text("Back to home screen")
                        .frame(width: 200, height: 50 )
                        .foregroundColor(.white)
                        .background(Color("Green 2"))
                        .cornerRadius(8)
                    
                } )
            }
        }
    }
}

struct OnboardingView_Previews: PreviewProvider {
    static var previews: some View {
        let showOnBoarding = Binding.constant(true)
        OnboardingView(showOnBoarding: showOnBoarding)
    }
}
