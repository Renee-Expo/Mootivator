import SwiftUI

struct GoalView: View {
    @EnvironmentObject var goalManager: GoalManager
    @EnvironmentObject var habitCompletionStatus: HabitCompletionStatus
    @State private var showNewGoalSheet = false
    @State private var showConfirmAlert = false
    @Binding var title: String
    @Binding var habitTitle: String
    @State private var filters = ["Show All", "Ascending Order", "Descending Order"]
    
    
    var body: some View {
        NavigationStack {
            List(goalManager.filteredAndSortedGoals, id: \.id) { $goal in
                NavigationLink {
                    GoalDetailView(goal: $goal, dailyHabitCompleted: $habitCompletionStatus.dailyHabitCompleted)
                } label: {
                    VStack(alignment: .leading) {
                        Text(goal.title)
                        Text(goal.habitTitle)
                            .font(.footnote)
                            .foregroundStyle(.gray)
                    }
                    .padding(5)
                }
            }
            .navigationTitle("Goals")
            .toolbar {
                ToolbarItemGroup(placement: .navigationBarTrailing) {
#if DEBUG
                    Button {
                        showConfirmAlert = true
                    } label: {
                        Label("Load sample data", systemImage: "list.bullet.clipboard.fill")
                    }
#endif
                    Button {
                        showNewGoalSheet = true
                    } label: {
                        Label("Add goal", systemImage: "plus.app")
                    }
                    
                    Menu {
                        Button("Show All") {
                            goalManager.sortOption = .none
                        }
                        Button("Ascending Order") {
                            goalManager.sortOption = .ascending
                        }
                        Button ("Descending Order") {
                            goalManager.sortOption = .descending
                        }
                    } label: {
                        Label("Filter", systemImage: "line.horizontal.3.decrease.circle")
                    }
                }
            }
            .sheet(isPresented: $showNewGoalSheet) {
                NewGoalView()
            }
            .alert("Load sample data? Warning: this cannot be undone.", isPresented: $showConfirmAlert) {
                Button("Replace", role: .destructive) {
                    goalManager.loadSampleData()
                }
            }
        }
        .searchable(text: $goalManager.searchText)
        
    }
}


struct GoalView_Previews: PreviewProvider {
    static var previews: some View {
        GoalView(title: .constant("Sample Goal"), habitTitle: .constant("Sample Habit Title"))
            .environmentObject(GoalManager())
            .environmentObject(HabitCompletionStatus())
    }
}
