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
    @State private var showGoalDetailSheet = false
    @Environment(\.colorScheme) var colorScheme
    var chevronWidth : Double = 15
    @State var indexItem : Int = 0
    @State var selectedDate : Date = Date()
    @State private var showMarkHabitCompletionAlert = false
//    @State private var showHabitCompletionView = false
    
    
    var body: some View {
        
        NavigationStack{
            VStack{
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
                                                //goalmanager.markHabitCompleted(for: selectedDate)
//                                                showHabitCompletionView = true
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
}
struct GoalDetailView_Previews: PreviewProvider {
    static var previews: some View {
        GoalDetailView(goal: .constant(Goal(title: "", habitTitle: "", deadline: .now, frequency: [], selectedFrequencyIndex: 0, selectedAnimal: Animal(name: "Name of Animal", kind: .cow), motivationalQuote: "imagine the motivational quote", selectedDailyDeadline: .now, selectedFixedDeadline: .now)))
            .environmentObject(GoalManager())
    }
}
