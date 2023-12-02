//
//  GoalDetailView.swift
//  Ratatouille
//
//  Created by Kaveri Mi on 19/11/23.
//
import SwiftUI

struct GoalDetailView: View {
    
    @Environment(\.presentationMode) var presentationMode
    @ObservedObject var goalManager: GoalManager = .shared
    
    @Binding var goal: Goal
    @Binding var numberOfDaysCompleted : Int
    
    @State var title: String = ""
    @State var habitTitle: String = ""
    @State var indexItem: Int = 0
    @State var selectedDate: Date = Date()
    @State private var showGoalDetailSheet = false
    //    @State private var showMarkHabitCompletionAlert = false
    @State private var showDeleteGoalAlert = false
    @State private var showOverallHabitCompletionAlert = false
    @State private var completedDates: Set<Date> = []
    @State private var redirectToGoalView = false
    
    var body: some View {
        let targetDays = calculateTargetDays(for: goal)
        
        ScrollView {
            AnimateProgressView(targetDays: calculateTargetDays(for: goal), numberOfDaysCompleted: $numberOfDaysCompleted)
            
            VStack(alignment: .leading) {
                Text("Current habit")
                    .font(.headline)
                    .fontWeight(.bold)
                
                HStack {
                    Text("\(numberOfDaysCompleted) days remaining")
                }
                HStack {
                    Text("Target --> something")
                    //                    Text("\(goal.selectedFixedDeadline - Date()) days")
                }
                
                Text(goal.habitTitle)
                    .font(.headline)
                    .fontWeight(.bold)
                
                CalendarView(selectedDate: Date(), numberOfDaysCompleted: $numberOfDaysCompleted, goal: Goal(title: "Sample Title", habitTitle: "Sample Habit Title", completedDates: [], deadline: Date(), selectedFrequencyIndex: Goal.frequency.custom, selectedAnimal: Animal(name: "Name of Animal", kind: .cow), motivationalQuote: "imagine the motivational quote", selectedDailyDeadline: Date(), selectedFixedDeadline: Date()))
                    .scaledToFit()
                    .padding()
                
                
                
                //                DatePicker(selection: $selectedDate, displayedComponents: .date) {
                //                    Text("Select a date")
                //                }
                //                .datePickerStyle(.graphical)
                //                .onChange(of: selectedDate) { _ in
                //                    showMarkHabitCompletionAlert = true
                //                }
                //                            .alert("Load sample data? Warning: this cannot be undone.", isPresented: $showOverallHabitCompletionAlert) {
                //                                Button("OK", role: .cancel) {
                //
                //                                }
                //                            }
                
                
                //                HStack {
                //                    Spacer()
                //                    //                        VStack {
                //                    //                            Text("Completed")
                //                    //                            Text("\(numberOfDaysCompleted)d")
                //                    //                                .fontWeight(.bold)
                //                    //                                .padding(1)
                //                    //                        }
                //                        .padding(5)
                //
                //                    VStack {
                //                        Text("Target")
                //                        //                                        Text("\(targetDays)d")
                //                            .fontWeight(.bold)
                //                            .padding(1)
                //                    }
                //                    .padding(5)
                //                    Spacer()
                ////                }
                //            }
                //            .padding(.horizontal)
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
                    self.presentationMode.wrappedValue.dismiss() // basically like dismissing the sheetview, same concept.
                    
                }
                Button("Cancel") {}
            }
            .sheet(isPresented: $showGoalDetailSheet) {
                NavigationView {
                    GoalEditView(goal: $goal)
                }
            }
        }
    }
    
    struct GoalDetailView_Previews: PreviewProvider {
        static var previews: some View {
            
            let goal = Goal(title: "Sample Title", habitTitle: "Sample Habit Title", completedDates: [], deadline: Date(), selectedFrequencyIndex: Goal.frequency.custom, selectedAnimal: Animal(name: "Name of Animal", kind: .cow), motivationalQuote: "imagine the motivational quote", selectedDailyDeadline: Date(), selectedFixedDeadline: Date() + 5)
            
            return NavigationStack {
                GoalDetailView(goal: .constant(goal), numberOfDaysCompleted: .constant(0))
            }
        }
    }
    
}
