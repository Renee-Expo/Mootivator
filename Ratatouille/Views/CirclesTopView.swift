//
//  CirclesTopView.swift
//  Ratatouille
//
//  Created by T Krobot on 24/11/23.
//


import SwiftUI

struct CirclesTopView: View {
    var body: some View {
        VStack() {
            CircularProgressView(progress: 0.55)

            CircularProgressView(progress: 0.85)
                .scaleEffect(0.75)

            Spacer()
        }
        .padding(20)
    }
}

struct CircularProgressView: View {
    var progress: Double

    var body: some View {
        let progressText = String(format: "%.0f%%", progress * 100)
        let purpleAngularGradient = AngularGradient(
            gradient: Gradient(colors: [
                Color(red: 200/255, green: 168/255, blue: 240/255),
                Color(red: 71/255, green: 33/255, blue: 158/255)
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

struct CirclesTopView_Previews: PreviewProvider {
    static var previews: some View {
        CirclesTopView()
    }
}
