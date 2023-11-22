//
//  HomeView.swift
//  Ratatouille
//
//  Created by klifton Cheng stu on 18/11/23.
//

import SwiftUI

struct HomeView: View {
    
    @EnvironmentObject var goalManager: GoalManager
    @Environment(\.colorScheme) var colorScheme
    
    var chevronWidth : Double = 15
    @State var indexItem : Int = 0
    @State var selectedDate : Date = Date()
    
    var body: some View {
        VStack {
//            AnimalEmotionElement(scale: .constant(20))
//            Text("Metric == \(indexItem)") // for debugging
            
            HStack {
                Button {
                    // Move left
                } label: {
                    Image(systemName: "chevron.compact.left")
                        .resizable()
                        .scaledToFit()
                        .frame(width: chevronWidth)
                }
                Spacer()
                // add image view here? should be segmented control
//                Image(systemName: "photo")
//                    .resizable()
//                    .scaledToFit()
//                    .padding()
                
                ShowingAnimalSegmentedControlElement(selection: $indexItem)
                    .frame(width: 200)
                    .scaledToFit()
                
                Button {
                    // move right
                } label: {
                    Image(systemName: "chevron.compact.right")
                        .resizable()
                        .scaledToFit()
                        .frame(width: chevronWidth)
                }
            }
            .padding(.horizontal)
            Spacer()
            // Sheetview here, find a way to remove the darkening background and covering of the navigation bar
            DatePicker(selection: $selectedDate, displayedComponents: .date) {
                Text("Select a date")
            }
            .datePickerStyle(.graphical)
            .padding(10)
            .background()
        }
        .background {
            Color(.backgroundColors)
                .ignoresSafeArea()
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
            .environmentObject(GoalManager())
    }
}
