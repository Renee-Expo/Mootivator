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
    @State private var showHabitCompletionView = false
    @Binding var habitTitle : String
    @Binding var title : String
    
    var body: some View {
        NavigationView {
            VStack {
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
                    
                    // Replace ShowingAnimalSegmentedControlElement with your segmented control
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
                            showHabitCompletionView = true
                            // goalmanager.markHabitCompleted(for: selectedDate)
                        },
                        secondaryButton: .cancel(Text("No"))
                    )
                }
                NavigationLink(
                    destination:         HabitCompletionView(frequency: .constant(["Fixed", "Daily", "Weekly", "Monthly"]), selectedFrequencyIndex: .constant(0), selectedDailyDeadline:.constant(Date()), selectedFixedDeadline: .constant(Date()), isHabitCompleted: true),
                    isActive: $showHabitCompletionView
                ) {
                    EmptyView()
                }
            }
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView(habitTitle: .constant("Sample Habit Title"), title: .constant("Sample Title"))
            .environmentObject(GoalManager())
    }
}

