//
//  GoalDetailView.swift
//  Ratatouille
//
//  Created by Kaveri Mi on 19/11/23.
//
import SwiftUI

struct GoalDetailView: View {
    
    @EnvironmentObject var goalManager: GoalManager
    
    @Binding var goal: Goal
//    @Binding var dailyHabitCompleted: [Date: Bool]
    @State private var showGoalDetailSheet = false
    @Environment(\.colorScheme) var colorScheme
    var chevronWidth: Double = 15
    @State var indexItem: Int = 0
    @State var selectedDate: Date = Date()
    @State private var showMarkHabitCompletionAlert = false
    @State private var showDeleteGoalAlert = false
    @State private var showOverallHabitCompletionAlert = false
    @State var title: String = ""
    @State var habitTitle: String = ""
    @Binding var numberOfDaysCompleted : Int
    @State private var completedDates: Set<Date> = []
    
    var body: some View {
        let targetDays = calculateTargetDays(for: goal)
        
        NavigationStack{
            AnimateProgressView(targetDays: calculateTargetDays(for: goal), numberOfDaysCompleted: $numberOfDaysCompleted)
            VStack(alignment: .leading, spacing: 1){
                Text("Current habit")
                    .font(.system(size: 16))
                    .fontWeight(.bold)
                    .padding()
                RoundedRectangle(cornerRadius: 8)
                    .stroke(Color.black, lineWidth: 2)
                    .frame(width: 350, height: 350)
                    .foregroundColor(.white)
                    .overlay(
                        ScrollView {
                            VStack(alignment: .leading, spacing: 5) {
                                Text(goal.habitTitle)
                                    .font(.system(size: 16))
                                    .fontWeight(.bold)
                                    .padding()
                                DatePicker(selection: $selectedDate, displayedComponents: .date) {
                                    Text("Select a date")
                                }
                                .datePickerStyle(.graphical)
                                .padding(5)
                                .onChange(of: selectedDate) { _ in
                                    showMarkHabitCompletionAlert = true
                                }
                                .alert(isPresented: $showMarkHabitCompletionAlert) {
                                    let isDateCompleted = completedDates.contains(selectedDate)
                                    if isDateCompleted {
                                        return Alert(title: Text("Habit Already Completed"),
                                                     message: Text("You've already marked this habit as done on this date."),
                                                     dismissButton: .default(Text("OK")))
                                    } else {
                                        return Alert(
                                            title: Text("Mark Habit as Completed?"),
                                            message: Text("Are you sure you want to mark the habit as done for this date?"),
                                            primaryButton: .default(Text("Yes")) {
                                                completedDates.insert(selectedDate)
                                                // Call function to update progress bar
                                                
                                                
                                                if (goal.selectedFrequencyIndex == .weekly
                                                    && numberOfDaysCompleted == targetDays)
                                                    || (goal.selectedFrequencyIndex == .monthly
                                                        && numberOfDaysCompleted == targetDays) {
                                                    
                                                    showOverallHabitCompletionAlert = true
                                                    
                                                }
                                                
                                                
                                            },
                                            secondaryButton: .cancel(Text("No"))
                                        )
                                    }
                                }
                                .alert("Load sample data? Warning: this cannot be undone.", isPresented: $showOverallHabitCompletionAlert) {
                                    Button("OK", role: .cancel) {
                                       
                                    }
                                }
                                
                                
                                HStack {
                                    Spacer()
                                    VStack {
                                        Text("Completed")
                                        Text("\(numberOfDaysCompleted)d")
                                            .fontWeight(.bold)
                                            .padding(1)
                                    }
                                    .padding(5)
                                    
                                    VStack {
                                        Text("Target")
//                                        Text("\(targetDays)d")
                                            .fontWeight(.bold)
                                            .padding(1)
                                    }
                                    .padding(5)
                                    Spacer()
                                }
                            }
                        }
                    )
            }
        }
        .navigationTitle(goal.title)
        .toolbar {
            ToolbarItemGroup(placement: .navigationBarTrailing) {
                Button {
                    showGoalDetailSheet = true
                } label: {
                    Label("Edit goal", systemImage: "pencil")
                }
                
                Button {
                    showDeleteGoalAlert = true
                    
                } label: {
                    Label("Delete goal", systemImage: "trash")
                        .foregroundColor(.red)
                }
            }
        }
        .alert("Are you sure you would like to delete this goal?", isPresented: $showDeleteGoalAlert) {
            Button("Yes") {
                goalManager.deleteGoal(goal)
                
                NavigationLink(destination: GoalView(title: $title, habitTitle: $habitTitle, isGoalCompleted: .constant(false))) {
                    // This closure can be empty or contain a label for the link
                }
                
                
                
            }
            Button("No") {
                
            }
        }
        .sheet(isPresented: $showGoalDetailSheet) {
            NavigationView {
                GoalEditView(goal: $goal, unlockedAnimals: .constant(unlockedAnimals), customDates: .constant(customDates))
            }
        }
    }
}

struct GoalDetailView_Previews: PreviewProvider {
    static var previews: some View {
        
        let goal = Goal(title: "Sample Title", habitTitle: "Sample Habit Title", deadline: Date(), selectedFrequencyIndex: Goal.frequency.custom, selectedAnimal: Animal(name: "Name of Animal", kind: .cow), motivationalQuote: "imagine the motivational quote", selectedDailyDeadline: Date(), selectedFixedDeadline: Date())
        
        let goalManager = GoalManager()
        
        return NavigationStack {
            GoalDetailView(goal: .constant(goal), numberOfDaysCompleted: .constant(0))
                .environmentObject(goalManager)
        }
    }
}

