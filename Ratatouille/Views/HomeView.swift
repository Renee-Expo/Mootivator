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
    @State private var showMarkHabitCompletionAlert = false
    @Binding var habitTitle : String
    @Binding var title : String
    
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
            
            HStack {
                Text("\(title)")
                    .font(.system(size: 24))
                    .fontWeight(.medium)
            }
            
            DatePicker(selection: $selectedDate, displayedComponents: .date) {
                Text("Select a date")
            }
            .datePickerStyle(.graphical)
            .padding(10)
            .onChange(of: selectedDate) { _ in
                showMarkHabitCompletionAlert = true
            }
            .alert(isPresented: $showMarkHabitCompletionAlert) {
                Alert(
                    title: Text("Mark \(habitTitle) as Completed?"),
                    primaryButton: .default(Text("Yes")) {
                        //goalmanager.markHabitCompleted(for: selectedDate)
                    },
                    secondaryButton: .cancel(Text("No"))
                )
            }
        }
//        .background {
//            Color(.backgroundColors)
//                .ignoresSafeArea()
//        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView(habitTitle: .constant("Sample Habit Title"), title: .constant("Sample Title"))
            .environmentObject(GoalManager())
    }
}
