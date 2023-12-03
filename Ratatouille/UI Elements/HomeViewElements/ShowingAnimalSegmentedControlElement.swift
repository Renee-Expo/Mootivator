//
//  ShowingAnimalTabView.swift
//  Ratatouille
//
//  Created by klifton Cheng stu on 18/11/23.
//

import SwiftUI

struct ShowingAnimalSegmentedControlElement: View {
    
    @ObservedObject var goalManager: GoalManager = .shared
    @Environment(\.colorScheme) var colorScheme
    //    @Binding var selection : Int // controlled by a swipeGesture/Button to increment/decrement for selection of the correct animal
    //    @Binding var goalItem : Goal
    
    var body: some View {
//        var colorInverted = (colorScheme == .dark ? Color.black : Color.white)
        ZStack {
            Color("BackgroundColors")
                .edgesIgnoringSafeArea(.all)
            VStack {
                if goalManager.items.count > 0 {
                    TabView {
                        ForEach($goalManager.items, id: \.id ) { $item in
                            ScrollView {
                                AnimalEmotionElement(goal: item)
                                VStack(alignment: .center) {
                                    Text("\(item.title)")
                                        .font(.system(.title2))
                                        .fontWeight(.heavy)
                                    Text("\(item.habitTitle)")
                                        .fontWeight(.medium)
                                }
    //                                .clipShape(Circle())
                                VStack {
                                    Image("\(item.selectedAnimal.kind.image)" + "\(item.selectedAnimal.emotion.text)")
                                        .resizable()
                                        .scaledToFit()
                                        .padding(.horizontal)
        //                                .frame(width: 200)
                                        .background(Color("BackgroundColors"))
                                    Text(item.selectedAnimal.name)
                                    Text("\(item.motivationalQuote)")
                                        .font(.footnote)
                                        .fontWeight(.medium)
                                        .padding(10)
                                }
    //                                .padding(.leading, 100)
    //                                .padding( )
    //                                .multilineTextAlignment(.trailing)
                                
    //                            Spacer()
                                RoundedRectangle(cornerRadius: 30)
                                    .frame(width: 400, height: 350)
                                    .foregroundColor(.white)
                                    .overlay(
                                CalendarView(selectedDate: Date(), goal: $item)
                                    .scaledToFit()
                                    .frame(width: 300, height: 300)
                                    .padding()
                                )
                                
    //                            HStack {
    //                                Spacer()
    //                                Text("\(item.motivationalQuote)")
    //                                    .font(.footnote)
    //                                    .fontWeight(.medium)
    //                                    .padding(.bottom, 200)
    //                                    .padding(.leading, 100)
    //                                    .padding( )
    //                                    .multilineTextAlignment(.trailing)
    //                            }
                            }
                            .scrollIndicators(.never)
                            .frame(width: 400)
                        }
                    }
                    .tabViewStyle(PageTabViewStyle())
                    .indexViewStyle(.page(backgroundDisplayMode: .never))
                    .padding()
                    .scaledToFill()
                    .overlay {
                        VStack {
                            Spacer()
    //                        Rectangle()
    //                           .fill(.linearGradient(Gradient(colors: [colorInverted, colorInverted, .clear]), startPoint: .bottom, endPoint: .top))
    //                            .frame(height: 50)
    //                            .scaledToFill()
                        }
                    }
                } else {
                    Text("You have no current goals!")
                }
            }
        }
    }
}

struct ShowingAnimalSegmentedControlElement_Previews: PreviewProvider {
    static var previews: some View {
        ShowingAnimalSegmentedControlElement()
    }
}
