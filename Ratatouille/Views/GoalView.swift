//
//  GoalView.swift
//  Ratatouille
//
//  Created by Kaveri Mi on 18/11/23.
//

import SwiftUI

struct GoalView: View {
    @ObservedObject var goalManager: GoalManager
    @State private var showNewGoalSheet = false
    @State private var showConfirmAlert = false
    var body: some View {
        
        
        NavigationStack{
            List($goalManager.goals){ $goal in
                NavigationLink {
                    GoalDetailView(goal: $goal)
                } label:{
                    VStack(alignment: .leading){
                        Text(goal.goalName)
                        Text(goal.currentHabit)
                            .font(.footnote)
                            .foregroundStyle(.gray)
                    }
                    .padding(5)
                    
                }
                
            }
            .navigationTitle("Goals")
            .toolbar{
                ToolbarItemGroup(placement: .navigationBarTrailing){
#if DEBUG
                    Button{
                        showConfirmAlert = true
                    } label: {
                        Label("Load sample data", systemImage: "list.bullet.clipboard.fill")
                    }
#endif
                    Button{
                        showNewGoalSheet = true
                    } label:{
                        Label("Add goal", systemImage: "plus.app")
                    }
                    
                    Button{
                        
                    } label:{
                        Label("Filter goals", systemImage:"arrow.up.arrow.down")
                    }
                }
            }
            .sheet(isPresented: $showNewGoalSheet){
                NewGoalView (sourceArray: $goalManager.goals)
            }
            .alert("Load sample data? Warning: this cannot be undone.", isPresented: $showConfirmAlert) {
                Button ("Replace", role:.destructive){
                    goalManager.loadSampleGoals()
                }
            }
        }
    }
}

struct GoalView_Previews: PreviewProvider {
    static var previews: some View {
        GoalView(goalManager: GoalManager())
    }
}
