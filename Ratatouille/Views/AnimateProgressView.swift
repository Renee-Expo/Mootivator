//
//  AnimateProgressView.swift
//  Ratatouille
//
//  Created by T Krobot on 24/11/23.
//

import SwiftUI

struct AnimateProgressView: View {

    var targetDays: Int
    var daysCompleted: Int
    var progress: Double {
        guard targetDays > 0 else { return 0 }
        let percentage = Double(daysCompleted) / Double(targetDays)
        return min(percentage, 1.0)
    }

    var body: some View {
        VStack() {
            CircularProgressView(progress: self.progress)
//                .animation(.linear)
                .padding()

            Spacer()
        }
        .padding(10)
    }
}

struct CircularProgressView: View {
    var progress: Double

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
                .trim(from: 0, to: CGFloat(self.progress))
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
        AnimateProgressView(targetDays: 30, daysCompleted: 10)
    }
}
