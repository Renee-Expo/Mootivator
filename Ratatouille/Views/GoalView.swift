import SwiftUI

struct GoalView: View {
    @ObservedObject var goalManager: GoalManager = .shared
    @ObservedObject var unlockedAnimalManager : UnlockedAnimalManager = .shared
    @State private var showNewGoalSheet = false
    @State private var showConfirmAlert = false

    @State private var filters = ["Show All", "Ascending Order", "Descending Order", "Current", "Past"]
    
    @State private var searchText = ""
    
    var body: some View {
        NavigationStack {
            List(goalManager.filteredAndSortedGoals, id: \.id, editActions: .all) { $goal in
                NavigationLink {
                    GoalDetailView(goal: $goal)
                } label: {
                    VStack(alignment: .leading) {
                        Text(goal.title)
                        Text(goal.habitTitle)
                            .font(.footnote)
                            .foregroundStyle(.gray)
                    }
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
                            goalManager.filterOption = .showAll
                        }
                        Button("Ascending Deadlines") {
                            goalManager.sortOption = .ascending
                        }
                        Button ("Descending Deadlines") {
                            goalManager.sortOption = .descending
                        }
                        Button ("Current") {
                            goalManager.sortOption = .none
                            goalManager.filterOption = .showCurrent
                        }

                        Button ("Past") {
                            goalManager.sortOption = .none
                            goalManager.filterOption = .showPast
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
            .searchable(text: $searchText)
            .onChange(of: searchText) { prompt in
                goalManager.searchText = prompt
            }
        }
    }
}


struct GoalView_Previews: PreviewProvider {
    static var previews: some View {
        GoalView()
            .environmentObject(GoalManager())
//            .environmentObject(HabitCompletionStatus())
    }
}
