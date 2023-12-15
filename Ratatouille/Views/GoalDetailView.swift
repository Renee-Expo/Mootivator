//
//  GoalDetailView.swift
//  Ratatouille
//
//  Created by Kaveri Mi on 19/11/23.
//
import SwiftUI

struct GoalDetailView: View {
    
    @Environment(\.presentationMode) var presentationMode
    @Environment(\.colorScheme) var colorScheme
    @ObservedObject var goalManager: GoalManager = .shared
    
    @Binding var goal: Goal
    
    @State private var goalAnimalKind: AnimalKind = .cow
    @State private var showHabitCompletionView = false
    @State private var showGoalCompletionView = false
    @State var isOverallHabitCompleted : Bool = false
    //    @State var title: String = ""
    //    @State var habitTitle: String = ""
    //    @State var indexItem: Int = 0
    //    @State var selectedDate: Date = Date()
    @State private var showGoalDetailSheet = false
    //    @State private var showMarkHabitCompletionAlert = false
    @State private var showDeleteGoalAlert = false
    @State private var showHabitCompletionAlert = false
    @State private var showNewHabitSheet = false
    @State private var showYesScreen = false
    @State private var showNoScreen = false
    
    @State private var targetDays : Double = 0
    @State private var isExpanded = false
    @State private var completedHabits: [String] = ["Habit 1"]
    
    var body: some View {
        ScrollView {
            AnimateProgressView(targetDays: $targetDays, goal: $goal)
            
            VStack(alignment: .center) {
                Text("Current habit")
                    .font(.headline)
                    .fontWeight(.bold)
                
                Text(goal.habit.habitTitle)
                    .font(.headline)
                    .padding(.bottom, 5)
                //                    .fontWeight(.bold)
                RoundedRectangle(cornerRadius: 30)
                    .strokeBorder(Color.black, lineWidth: 2)
                    .frame(width: 350, height: 400)
                    .foregroundColor(Color.white)
                    .overlay(
                        VStack {
                            CalendarView(selectedDate: Date(), goal: $goal)
                                .frame(maxWidth: .infinity, maxHeight: .infinity)
                                .padding()
                            HStack {
                                Spacer()
                                VStack {
                                    Text("Completed")
                                    Text("\(goal.habit.numberOfDaysCompleted)d")
                                        .padding(.bottom)
                                    
                                }
                                
                                Spacer()
                                VStack {
                                    Text("Target")
                                    Text("\(Int(targetDays))d")
                                        .padding(.bottom)
                                    
                                }
                                Spacer()
                            }
                            Button{
                                print("Button shown")
                                showHabitCompletionAlert = true
                            } label: {
                                Text("Complete habit")
                                    .buttonStyle(.borderedProminent)
                                    .fontWeight(.bold)
                                    .foregroundColor(.white)
                                    .padding()
                                    .background(Color("AccentColor"))
                                    .cornerRadius(8)
                            }
                            .padding(.bottom)
                            .alert("Have you completed the habit: \(goal.habit.habitTitle)?", isPresented: $showHabitCompletionAlert) {
                                Button("Yes") {
                                    isOverallHabitCompleted = true
                                    showHabitCompletionView = true
                                    print("completed dates of completed habit: \(goal.habit.completedDates)")
                                }
                                Button("No") {
                                    isOverallHabitCompleted = false
                                    showHabitCompletionView = true
                                    
                                }
                            }
                            .sheet(isPresented: $showHabitCompletionView) {
                                HabitCompletionView(goal: $goal, isOverallHabitCompleted: $isOverallHabitCompleted, showHabitCompletionView: $showHabitCompletionView)
                                
                            }
                        }
                        
                    )
                    .padding()
                DisclosureGroup(
                    isExpanded: $isExpanded,
                    content: {
                        VStack(alignment: .leading) {
                            ForEach(goal.completedHabits, id: \.id) { habit in
                                ZStack(alignment: .leading) {
                                    RoundedRectangle(cornerRadius: 20)
                                        .strokeBorder(Color.black, lineWidth: 2)
                                        .background(RoundedRectangle(cornerRadius: 20).foregroundColor(.white))
                                        .frame(width: 350, height: 60)
                                    Text(habit.habitTitle)
                                        .font(.headline)
                                        .padding(.horizontal, 20)
                                        .foregroundColor(.black)
                                    
                                }
                            }
                        }
                    },
                    label: {
                        VStack(alignment: .center) {
                            Text("Completed Habits")
                                .frame(maxWidth: .infinity)
                                .multilineTextAlignment(.center)
                                .padding(.bottom)
                                .font(.headline)
                                .fontWeight(.bold)
                                .foregroundColor(.primary)
                        }
                    }
                )
                .accentColor(.black)
                .padding(.horizontal)
            }
            .padding(.horizontal)
            .navigationTitle(goal.title)
            .toolbar {
                ToolbarItemGroup(placement: .navigationBarTrailing) {
                    
                    if showButton() {
                        Button {
                            showGoalCompletionView = true
                        } label: {
                            Label("Complete goal", systemImage: "checkmark.circle")
                        }
                    }
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
                    GoalEditView(goal: $goal, workingGoal: goal)
                }
            }
            .sheet(isPresented: $showGoalCompletionView) {
                GoalCompletionView(goal: $goal)
            }
            .onAppear {
                targetDays = Double(calculateTargetDays(for: goal))
            }
            .onChange(of: goal) { newValue in
                targetDays = Double(calculateTargetDays(for: newValue))
                //                print("goal = \(goal)")
                //                print("newValue = \(newValue)")
                print("new TargetDays : \(targetDays)")
            }
            
        }
        .scrollIndicators(.never)
    }
    
    func showButton() -> Bool {
        let currentDate = Date()
        print("current date: \(currentDate)_")
        print("habit deadline: \(goal.deadline)")
        return currentDate >= goal.deadline
    }
    
    var backgroundColor: Color {
        if colorScheme == .dark {
            return Color.white // For dark mode, set it to white
        } else {
            return Color.white // For light mode, set it to white as well
        }
    }
    
}


        struct GoalDetailView_Previews: PreviewProvider {
            static var previews: some View {
                
                let goal = Goal(title: "Sample Title", habit: Habit(habitTitle: "Sample Habit", selectedFrequencyIndex: Habit.frequency.daily, selectedDailyDeadline: Date(), completedDates: []), selectedAnimal: Animal(name: "Name of Animal", kind: .cow), motivationalQuote: "imagine the motivational quote",deadline: Date())
                
                return NavigationStack {
                    GoalDetailView(goal: .constant(goal))
                }
            }
        }

