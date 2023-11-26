//
//  GoalDetailView.swift
//  Ratatouille
//
//  Created by Kaveri Mi on 19/11/23.
//
import SwiftUI
struct GoalDetailView: View {
    
    @EnvironmentObject var goalManager: GoalManager
    @EnvironmentObject var habitCompletionStatus: HabitCompletionStatus
    
    @Binding var goal: Goal
    @Binding var dailyHabitCompleted : [Date: Bool]
    @State private var showGoalDetailSheet = false
    @Environment(\.colorScheme) var colorScheme
    var chevronWidth : Double = 15
    @State var indexItem : Int = 0
    @State var selectedDate : Date = Date()
    @State private var showMarkHabitCompletionAlert = false
    @State private var showDeleteGoalAlert = false
    @State var title: String = ""
    @State var habitTitle: String = ""
    @State var daysCompleted = 0
    @State private var completedDates: Set<Date> = []

    //    @State private var showHabitCompletionView = false
    
    
    var body: some View {
        let targetDays = calculateTargetDays(for: goal)
        
        NavigationStack{
            AnimateProgressView(targetDays: calculateTargetDays(for: goal), daysCompleted: daysCompleted)
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
                                            },
                                            secondaryButton: .cancel(Text("No"))
                                        )
                                    }
                                }
                                
                                HStack{
                                    Spacer()
                                    VStack {
                                        Text("Completed")
                                        Text("\(daysCompleted)d")
                                            .fontWeight(.bold)
                                            .padding(1)
                                        
                                    }
                                    .padding(5)
                                    
                                    
                                    VStack {
                                        Text("Target")
                                        Text("\(targetDays)d")
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
        .toolbar{
            ToolbarItemGroup(placement: .navigationBarTrailing){
                Button{
                    showGoalDetailSheet = true
                } label:{
                    Label("Edit goal", systemImage: "pencil")
                }
                
                Button{
                    goalManager.deleteGoal(goal)
                    
                } label:{
                    Label("Delete goal", systemImage:"trash")
                        .foregroundColor(.red)
                }
            }
        }
        .alert("Are you sure you would like to delete this goal?", isPresented: $showDeleteGoalAlert){
            Button("Yes"){
                goalManager.deleteGoal(goal)
                GoalView(title: $title, habitTitle: $habitTitle)
            }
            Button("No"){
                
            }
        }
        .sheet(isPresented: $showGoalDetailSheet){
            NavigationView {
                GoalEditView (goal: $goal)
            }
        }
        
    }
    
}

struct GoalDetailView_Previews: PreviewProvider {
    static var previews: some View {
        
        let goal = Goal(title: "Sample Title", habitTitle: "Sample Habit Title", deadline: Date(), frequency: ["Daily"], selectedFrequencyIndex: 0, selectedAnimal: Animal(name: "Name of Animal", kind: .cow), motivationalQuote: "imagine the motivational quote", selectedDailyDeadline: Date(), selectedFixedDeadline: Date())
        
        let goalManager = GoalManager()
        let habitCompletionStatus = HabitCompletionStatus()
        
        return NavigationStack {
            GoalDetailView(goal: .constant(goal), dailyHabitCompleted: .constant([Date: Bool]()))
                .environmentObject(goalManager)
            .environmentObject(habitCompletionStatus)
        }
    }
}
