//
//  AnimateProgressView.swift
//  Ratatouille
//
//  Created by T Krobot on 24/11/23.
//
import SwiftUI

struct AnimateProgressView: View {
    @State private var progress: Double = 42.0

    var minProgress = 0.0
    var maxProgress = 100.0

    var body: some View {
        VStack() {
            CircularProgressView(progress: self.progress / maxProgress)
//                .animation(.linear)

            VStack {
            Text("Progress: \(progress, specifier: "%.1f")")
//                Slider(value: $progress,
//                       in: minProgress...maxProgress,
//                       minimumValueLabel: Text("0"),
//                       maximumValueLabel: Text("100")
//                ) {}
            }
            .padding()

            Spacer()
        }
        .padding(10)
    }
}

struct FinalProgressView: View {
    @State private var progress: Double = 42.0

    var minProgress = 0.0
    var maxProgress = 100.0

    var body: some View {
        VStack() {
            CircularProgressView(progress: self.progress / 100)
//                .animation(.smooth)

            VStack {
            Text("Progress: \(progress, specifier: "%.1f")")
                Slider(value: $progress,
                       in: minProgress...maxProgress,
                       minimumValueLabel: Text("0"),
                       maximumValueLabel: Text("100")
                ) {}
            }
            .accentColor(Color(red: 200/255, green: 168/255, blue: 240/255))
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
//        .padding()
    }
}



struct AnimateProgressView_Previews: PreviewProvider {
    static var previews: some View {
        AnimateProgressView()
    }
}
