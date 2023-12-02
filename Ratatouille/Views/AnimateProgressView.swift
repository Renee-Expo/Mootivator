//
//  AnimateProgressView.swift
//  Ratatouille
//
//  Created by T Krobot on 24/11/23.
//

import SwiftUI

struct AnimateProgressView: View {

    var targetDays: Double
//    @Binding var numberOfDaysCompleted : Int
    @Binding var goal: Goal
    @State var progress: Double = 1
    
    func calculateProgress() -> Double {
            guard targetDays > 0 else { return 0 }
            let percentage = Double(goal.numberOfDaysCompleted) / Double(targetDays)
            print("dfkhu")
            print(goal.numberOfDaysCompleted)
            return min(percentage, 1.0)
    }

    var body: some View {
        VStack() {
            withAnimation(.linear(duration: 1.0)) {
                CircularProgressView(progress: progress)
                    .onAppear{
                        progress = calculateProgress()
                    }
            }
        }
        .padding(10)
    }
}

struct CircularProgressView: View {
    @State var progress: Double

    var body: some View {
        let progressText = String(format: "%.0f%%", progress * 100)
        let purpleAngularGradient = AngularGradient(
            gradient: Gradient(colors: [
                Color("Accent Color"),
                Color(red: 52/255, green: 115/255, blue: 65/255)
            ]),
            center: .center,
            startAngle: .degrees(0),
            endAngle: .degrees(360.0 * progress))

        ZStack {
            Circle()
                .stroke(Color(.systemGray4), lineWidth: 20)
            Circle()
                .trim(from: 0, to: CGFloat(progress))
                .stroke(
                    purpleAngularGradient,
                    style: StrokeStyle(lineWidth: 20, lineCap: .round))
                .rotationEffect(Angle(degrees: -90))
                .overlay(
                    Text(progressText)
                        .font(.system(size: 56, weight: .bold, design:.rounded))
                        .foregroundColor(Color(.systemGray))
                )
        }
        .frame(width: 200, height: 200)
        .padding()
    }
}



struct AnimateProgressView_Previews: PreviewProvider {
    static var previews: some View {
        let goal = Goal(title: "Sample Title", habitTitle: "Sample Habit Title", completedDates: [], deadline: Date(), selectedFrequencyIndex: Goal.frequency.custom, selectedAnimal: Animal(name: "Name of Animal", kind: .cow), motivationalQuote: "imagine the motivational quote", selectedDailyDeadline: Date(), selectedFixedDeadline: Date())
        
        return AnimateProgressView(targetDays: 30, goal: .constant(goal))
    }
}


