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
//    @Binding var numberOfCompletedGoals: Int
    
    @State private var goalAnimalKind: AnimalKind = .cow
//    @State var title: String = ""
//    @State var habitTitle: String = ""
//    @State var indexItem: Int = 0
//    @State var selectedDate: Date = Date()
    @State private var showGoalDetailSheet = false
    //    @State private var showMarkHabitCompletionAlert = false
    @State private var showDeleteGoalAlert = false
//    @State private var showOverallHabitCompletionAlert = false
//    @State private var completedDates: Set<Date> = []
//    @State private var redirectToGoalView = false
    @State private var showGoalCompletionView = false
    @State private var showYesScreen = false
    @State private var showNoScreen = false
    
    @State private var targetDays : Double = 0
    
    var body: some View {
        ScrollView {
            AnimateProgressView(targetDays: $targetDays, goal: $goal)
            
            VStack(alignment: .center) {
                Text("Current habit")
                    .font(.headline)
                    .fontWeight(.bold)
                    .padding(.top, 5)
                
                
                
                Text(goal.habitTitle)
                    .font(.headline)
                    .padding(.bottom, 5)
                //                    .fontWeight(.bold)
                RoundedRectangle(cornerRadius: 30)
                    .strokeBorder(Color.black, lineWidth: 2)
                    .frame(width: 350, height: 400)
                    .foregroundColor(.white)
                    .overlay(
                        VStack {
                            CalendarView(selectedDate: Date(), goal: $goal)
                                .scaledToFit()
                                .padding()
                            HStack{
                                Spacer()
                                VStack {
                                    Text("Completed")
                                    Text("\(goal.numberOfDaysCompleted)d")
                                        .padding(.bottom)
                                    
                                }
                                
                                Spacer()
                                VStack {
                                    Text("Target")
                                    if /*(goal.selectedFrequencyIndex == .custom) || */(goal.selectedFrequencyIndex == .daily) {
                                        
                                        Text("\(goal.scheduledCompletionDates.count)d")
                                            .padding(.bottom)
                                        //                    Text("\(goal.selectedFixedDeadline - Date()) days")
                                    } else if goal.selectedFrequencyIndex == .weekly{
                                        Text ("\(Int(goal.numberOfTimesPerWeek.rounded()))d")
                                            .padding(.bottom)
                                    } else if goal.selectedFrequencyIndex == .monthly {
                                        Text ("\(Int(goal.numberOfTimesPerMonth.rounded()))d")
                                            .padding(.bottom)
                                    }
                                    
                                }
                                Spacer()
                            }
                        }

                        )
//                HStack{
//                    Spacer()
//                    VStack {
//                        Text("Completed")
//                        Text("\(goal.numberOfDaysCompleted)d")
//
//                    }
//
//                    Spacer()
//                    VStack {
//                        Text("Target")
//                        if /*(goal.selectedFrequencyIndex == .custom) || */(goal.selectedFrequencyIndex == .daily) {
//
//                            Text("\(goal.scheduledCompletionDates.count)d")
//                            //                    Text("\(goal.selectedFixedDeadline - Date()) days")
//                        } else if goal.selectedFrequencyIndex == .weekly{
//                            Text ("\(Int(goal.numberOfTimesPerWeek.rounded()))d")
//                        } else if goal.selectedFrequencyIndex == .monthly {
//                            Text ("\(Int(goal.numberOfTimesPerMonth.rounded()))d")
//                        }
//
//                    }
//                    Spacer()
//                }
                
                
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
                        showGoalCompletionView = true
                    } label: {
                        Label("Complete goal", systemImage: "checkmark.circle")
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
        
}
struct GoalDetailView_Previews: PreviewProvider {
    static var previews: some View {
        
        let goal = Goal(title: "Sample Title", habitTitle: "Sample Habit Title", selectedFrequencyIndex: Goal.frequency.daily, selectedAnimal: Animal(name: "Name of Animal", kind: .cow), motivationalQuote: "imagine the motivational quote", selectedDailyDeadline: Date(), selectedFixedDeadline: Date() + 5, completedDates: [], deadline: Date())
        
        return NavigationStack {
            GoalDetailView(goal: .constant(goal))
        }
    }
}
