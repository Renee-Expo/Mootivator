////
////  AnimalEmotionElement.swift
////  Ratatouille
////
////  Created by klifton Cheng stu on 18/11/23.
////
//

import SwiftUI

struct AnimalEmotionElement: View {
    var goal : Goal
//    @Binding var scale: Double
//    @Binding var animalEmotionScale: Double
    
    var scale : Double {
        switch goal.selectedAnimal.emotion {
        case .happy     : return 180
        case .neutral   : return 0
        case .sad       : return -180
        }
    }
    
    var body: some View {
        VStack {
            Image(systemName: "arrowtriangle.down.fill")
                .resizable()
                .scaledToFit()
                .frame(width: 15)
                .offset(x: scale, y: 0)
            
            EmotionBar()
                .padding(.horizontal)
        }
    }
}

struct AnimalEmotionElement_Previews: PreviewProvider {
    static var previews: some View {
        
        let goal = Goal(title: "Sample Title", habit: Habit(title: "Sample Habit", selectedFrequencyIndex: Habit.frequency.daily, selectedDailyDeadline: Date(), completedDates: []), selectedAnimal: Animal(name: "Name of Animal", kind: .cow), motivationalQuote: "imagine the motivational quote",deadline: Date())
        
        AnimalEmotionElement(goal: goal)
    }
}

struct EmotionBar: View {
    var body: some View {
        HStack {
            Rectangle()
                .frame(height: 10)
                .cornerRadius(10)
                .foregroundStyle(.linearGradient(colors: [Color.pink, Color.yellow, Color.green], startPoint: .leading, endPoint: .trailing))
//                .overlay(
//                    HStack {
//                        Rectangle()
//                            .frame(width: 2, height: 10)
//                            .cornerRadius(10)
//                            .opacity(0.8)
//                    }
//                )
        }
    }
}
