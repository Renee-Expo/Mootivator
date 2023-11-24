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
    
    var body: some View {
        
        NavigationStack{
            VStack{
                VStack{
                    Text("Current habit")
                    
                    Text(goal.habitTitle)
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
        GoalDetailView(goal: .constant(Goal(title: "", habitTitle: "", deadline: .now, frequency: [], selectedFrequencyIndex: 0, selectedAnimal: 0, motivationalQuote: "dkfjdkfj", selectedDailyDeadline: .now, selectedFixedDeadline: .now)))
            .environmentObject(GoalManager())
    }
}
