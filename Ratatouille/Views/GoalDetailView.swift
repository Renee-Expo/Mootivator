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
    //    @State private var showHabitCompletionView = false
    
    
    var body: some View {
        
        NavigationStack{
            VStack(spacing: 5){
                Text(goal.habitTitle)
                Text("Current habit")
                AnimateProgressView()
                RoundedRectangle(cornerRadius: 8)
                    .stroke(Color.black, lineWidth: 2)
                    .frame(width: 350, height: 400)
                    .foregroundColor(.white)
                    .overlay(
                        ScrollView {
                            VStack {
                                Text("Test  habit")
                                    .font(.system(size: 16))
                                    .multilineTextAlignment(.leading)
                                    .fontWeight(.bold)
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
                                        title: Text("Mark \(goal.habitTitle) as Completed?"),
                                        primaryButton: .default(Text("Yes")) {
                                            dailyHabitCompleted[selectedDate] = true
                                            habitCompletionStatus.save()
                                        },
                                        secondaryButton: .cancel(Text("No"))
                                    )
                                }
                                
                                //                                    NavigationLink(
                                //                                        destination: HabitCompletionView(frequency: .constant(["Fixed", "Daily", "Weekly", "Monthly"]), selectedFrequencyIndex: .constant(0), selectedDailyDeadline:.constant(Date()), selectedFixedDeadline: .constant(Date()), isHabitCompleted: true),
                                //                                        isActive: $showHabitCompletionView
                                //                                    ) {
                                //                                        EmptyView()
                                //                                    }
                                
                                
                            }
                        }
                    )
                    .offset(y: -20)
                
                
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
                    
                } label:{
                    Label("Delete goal", systemImage:"trash")
                        .foregroundColor(.red)
                }
            }
        }
        .sheet(isPresented: $showGoalDetailSheet){
            GoalEditView (goal: $goal)
        }
        
    }
    
}

struct GoalDetailView_Previews: PreviewProvider {
    static var previews: some View {
        let goal = Goal(title: "Sample Title", habitTitle: "Sample Habit Title", deadline: Date(), frequency: ["Daily"], selectedFrequencyIndex: 0, selectedAnimal: Animal(name: "Name of Animal", kind: .cow), motivationalQuote: "imagine the motivational quote", selectedDailyDeadline: Date(), selectedFixedDeadline: Date())
        
        let goalManager = GoalManager()
        let habitCompletionStatus = HabitCompletionStatus()
        
        return GoalDetailView(goal: .constant(goal), dailyHabitCompleted: .constant([Date: Bool]()))
            .environmentObject(goalManager)
            .environmentObject(habitCompletionStatus)
    }
}
