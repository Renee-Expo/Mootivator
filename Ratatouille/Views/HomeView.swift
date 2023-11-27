import SwiftUI

struct HomeView: View {
    
    @EnvironmentObject var goalManager: GoalManager
    @Environment(\.colorScheme) var colorScheme
    
    let chevronWidth : Double = 15
    @State var indexItem : Int = 0
    @State var selectedDate : Date = Date()
    @State private var showMarkHabitCompletionAlert = false
    @State private var showHabitCompletionView = false
    @Binding var habitTitle : String
    @Binding var title : String
    @State var dailyHabitCompletionStatus: [Date: Bool] = [:]
    @State var dailyHabitCompleted: [Date: Bool] = [:]
    @Binding var goalAnimalKind : AnimalKind
    @Binding var goalAnimalEmotion: Animal.emotion
    @State var animalEmotionScale: Double = 0.0
    @Binding var motivationalQuote : String
    //@Binding var selectedAnimal: Animal = Animal(name: "", kind: .cow)
    
    var body: some View {
        NavigationView {
            VStack {
                Text("\(motivationalQuote)")
                    .font(.system(size: 24))
                    .fontWeight(.medium)
                
                AnimalEmotionElement(scale: $animalEmotionScale, animalEmotionScale: $animalEmotionScale) // Use $animalEmotionScale here
//                    .padding()
                //Text("\(Animal.name)")

                
                HStack {
                    Button {
                        indexItem = indexItem%goalManager.goals.count - 1
                    } label: {
                        Image(systemName: "chevron.compact.left")
                            .resizable()
                            .scaledToFit()
                            .frame(width: chevronWidth)
                    }
                    
                    // Replace ShowingAnimalSegmentedControlElement with your segmented control
                    ShowingAnimalSegmentedControlElement(selection: $indexItem, emotion: $goalAnimalEmotion)
                        .frame(width: 200)
                        .scaledToFit()
                    
//                    Image("\(goalAnimalKind.image)" + "\(goalAnimalEmotion.text)")
//                        .resizable()
//                        .scaledToFit()
//                        .padding()
                    
                    Button {
                        indexItem = indexItem%goalManager.goals.count + 1
                    } label: {
                        Image(systemName: "chevron.compact.right")
                            .resizable()
                            .scaledToFit()
                            .frame(width: chevronWidth)
                    }
                }
                .padding(.horizontal)
                
                VStack (alignment: .leading){
                    Text("\(title)")
                        .font(.system(size: 24))
                        .fontWeight(.heavy)
                        .offset(x: -90, y: 20)
                    Text("\(habitTitle)")
                        .font(.system(size: 20))
                        .fontWeight(.medium)
                        .offset(x: -90, y: 20)
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
                            dailyHabitCompleted[selectedDate] = true
                            updateAnimalEmotion(habitCompletionStatus: true)
//                            habitCompletionStatus.save()
                            // TODO: Some foreground colour thing
                            //                                .foregroundColor(.green)
                            
                        },
                        secondaryButton: .cancel(Text("No"))
                    )
                }
            }
//            .onChange(of: $goalManager.goals[indexItem].isGoalCompleted.wrappedValue) { statusItem in
//                updateAnimalEmotion(habitCompletionStatus: statusItem)
//            }
        }
    }
    
    func updateAnimalEmotion(habitCompletionStatus: Bool) {
        let step: Double = 1.0 // Change this value based on how much the arrow should move for each completion
        
        if habitCompletionStatus == true {
            // Move arrow to the right
            if animalEmotionScale < 2 * step {
                animalEmotionScale += step
            }
        } else {
            // Move arrow to the left
            if animalEmotionScale > -2 * step {
                animalEmotionScale -= step
            }
        }
        
        // Update animal emotion based on arrow position
        updateAnimalEmotion()
    }
    
    func updateAnimalEmotion() {
        let maxScale: Double = 2.0
        let minScale: Double = -2.0
        
        // Determine animal emotion based on arrow position
        if animalEmotionScale >= maxScale {
            // Move to sad face
            goalAnimalEmotion = .sad
        } else if animalEmotionScale <= minScale {
            // Move to happy face
            goalAnimalEmotion = .happy
        } else {
            // Move to neutral face
            goalAnimalEmotion = .neutral
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView(habitTitle: .constant("Sample Habit Title"), title: .constant("Sample Title"), goalAnimalKind: .constant(AnimalKind.cow), goalAnimalEmotion: .constant(Animal.emotion.happy), motivationalQuote: .constant("Sample Motivational Quote"))
            .environmentObject(GoalManager())
    }
}
