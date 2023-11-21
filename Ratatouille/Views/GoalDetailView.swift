//
//  GoalDetailView.swift
//  Ratatouille
//
//  Created by Kaveri Mi on 19/11/23.
//

import SwiftUI

struct GoalDetailView: View {
    
    @Binding var goal: Goal
    @State private var showGoalDetailSheet = false
    
    var body: some View {
        
        NavigationStack{
            List{
            }
            .navigationTitle($goal.goalEntered)
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
                GoalEditView ()
            }
            
        }
        
    }
}

struct GoalDetailView_Previews: PreviewProvider {
    static var previews: some View {
        GoalDetailView(goal: .constant(Goal()))
    }
}
