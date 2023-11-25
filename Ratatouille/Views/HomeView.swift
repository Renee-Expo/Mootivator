//
//  HomeView.swift
//  Ratatouille
//
//  Created by klifton Cheng stu on 18/11/23.
//

import SwiftUI

struct HomeView: View {
    
    @EnvironmentObject var goalManager: GoalManager
    @Environment(\.colorScheme) var colorScheme
    
    var chevronWidth : Double = 15
    @State var indexItem : Int = 0
    @State var selectedDate : Date = Date()
    @State private var showMarkHabitCompletionAlert = false
    @State private var showHabitCompletionView = false
    @Binding var habitTitle : String
    @Binding var title : String
    @State var dailyHabitCompletionStatus: [Date: Bool] = [:]

    var body: some View {
        NavigationView {
            VStack {
                HStack {
                    Button {
                        // Move left
                    } label: {
                        Image(systemName: "chevron.compact.left")
                            .resizable()
                            .scaledToFit()
                            .frame(width: chevronWidth)
                    }
                    Spacer()
                    
                    // Replace ShowingAnimalSegmentedControlElement with your segmented control
                    ShowingAnimalSegmentedControlElement(selection: $indexItem)
                        .frame(width: 200)
                        .scaledToFit()
                    
                    Button {
                        // move right
                    } label: {
                        Image(systemName: "chevron.compact.right")
                            .resizable()
                            .scaledToFit()
                            .frame(width: chevronWidth)
                    }
                }
                .padding(.horizontal)
                
                Spacer()
                
                HStack {
                    Text("\(title)")
                        .font(.system(size: 24))
                        .fontWeight(.medium)
                }
                
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
                        title: Text("Mark \(habitTitle) as Completed?"),
                        primaryButton: .default(Text("Yes")) {
                            showHabitCompletionView = true
                            dailyHabitCompletionStatus[selectedDate] = true
                            // TODO: Some foreground colour thing
//                                .foregroundColor(.green)
                            
                        },
                        secondaryButton: .cancel(Text("No"))
                    )
                }
                NavigationLink(
                    destination:         HabitCompletionView(frequency: .constant(["Fixed", "Daily", "Weekly", "Monthly"]), selectedFrequencyIndex: .constant(0), selectedDailyDeadline:.constant(Date()), selectedFixedDeadline: .constant(Date()), isHabitCompleted: true),
                    isActive: $showHabitCompletionView
                ) {
                    EmptyView()
                }
            }
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView(habitTitle: .constant("Sample Habit Title"), title: .constant("Sample Title"))
            .environmentObject(GoalManager())
    }
}


//import SwiftUI
//
//struct HomeView: View {
//
//    @EnvironmentObject var goalManager: GoalManager
//    @Environment(\.colorScheme) var colorScheme
//
//    var chevronWidth : Double = 15
//    @State var indexItem : Int = 0
//    @State var selectedDate = Date()
//    @State private var showMarkHabitCompletionAlert = false
//    @Binding var habitTitle : String
//    @Binding var title : String
//    @Binding var isHabitCompleted : Bool
//
//    var body: some View {
//        VStack {
//            //            AnimalEmotionElement(scale: .constant(20))
//            //            Text("Metric == \(indexItem)") // for debugging
//
//            HStack {
//                Button {
//                    // Move left
//                } label: {
//                    Image(systemName: "chevron.compact.left")
//                        .resizable()
//                        .scaledToFit()
//                        .frame(width: chevronWidth)
//                }
//                Spacer()
//                // add image view here? should be segmented control
//                //                Image(systemName: "photo")
//                //                    .resizable()
//                //                    .scaledToFit()
//                //                    .padding()
//
//                ShowingAnimalSegmentedControlElement(selection: $indexItem)
//                    .frame(width: 200)
//                    .scaledToFit()
//
//                Button {
//                    // move right
//                } label: {
//                    Image(systemName: "chevron.compact.right")
//                        .resizable()
//                        .scaledToFit()
//                        .frame(width: chevronWidth)
//                }
//            }
//            .padding(.horizontal)
//
//            Spacer()
//            // Sheetview here, find a way to remove the darkening background and covering of the navigation bar
//
//            HStack {
//                Text("\(title)")
//                    .font(.system(size: 24))
//                    .fontWeight(.medium)
//            }
//
//            DatePicker(selection: $selectedDate, displayedComponents: .date) {
//                Text("Select a date")
//            }
//            .datePickerStyle(.graphical)
//            .padding(10)
//            .onTapGesture {
//                if selectedDate <= Date() {
//                    showMarkHabitCompletionAlert = true
//                }
//            }
//            .alert(isPresented: $showMarkHabitCompletionAlert) {
//                Alert(
//                    title: Text("Mark \(habitTitle) as Completed?"),
//                    primaryButton: .default(Text("Yes")) {
//                        isHabitCompleted = true
//                    },
//                    secondaryButton: .cancel(Text("No"))
//                )
//            }
//
//            .overlay(
//                Circle()
//                    .foregroundColor(isHabitCompleted ? Color.green.opacity(0.3) : Color.red.opacity(0.3))
//                    .frame(width: 30, height: 30)
//            )
//            .onChange(of: selectedDate) { _ in
//                showMarkHabitCompletionAlert = false
//            }
//
//        }
//        //        .background {
//        //            Color(.backgroundColors)
//        //                .ignoresSafeArea()
//        //        }
//    }
//}
//
//struct HomeView_Previews: PreviewProvider {
//    static var previews: some View {
//        HomeView(habitTitle: .constant("Sample Habit Title"), title: .constant("Sample Title"),isHabitCompleted: .constant(true))
//            .environmentObject(GoalManager())
//    }
//}
//
////            .datePickerStyle(.graphical)
////            .padding()
////
////            //CalendarView(selectedDate: $selectedDate, isHabitCompleted: $isHabitCompleted)
//////            .overlay(
//////                Circle()
//////                    .foregroundColor(isHabitCompleted ? Color.green.opacity(0.3) : Color.red.opacity(0.3))
//////                    .frame(width: 30, height: 30)
//////                    .position(x:UIScreen.main.bounds.width / 2, y: 250)
//////                    .onTapGesture {
//////                        if selectedDate <= Date() {
//////                        showMarkHabitCompletionAlert = true
//////                    }
//////                }
//////            )
////            .onChange(of: selectedDate) { _ in
////                showMarkHabitCompletionAlert = false
////            }
////            .alert(isPresented: $showMarkHabitCompletionAlert) {
////                Alert(
////                    title: Text("Mark \(habitTitle) as Completed?"),
////                    primaryButton: .default(Text("Yes")) {
////                        //goalmanager.markHabitCompleted(for: selectedDate)
////                    },
////                    secondaryButton: .cancel(Text("No"))
////                )
////            }
////        }
//////        .background {
//////            Color(.backgroundColors)
//////                .ignoresSafeArea()
//////        }
////    }
////}
////
////struct HomeView_Previews: PreviewProvider {
////    static var previews: some View {
////        HomeView(habitTitle: .constant("Sample Habit Title"), title: .constant("Sample Title"),isHabitCompleted: .constant(true))
////            .environmentObject(GoalManager())
////    }
////}
//
