//
//  CircleView.swift
//  Ratatouille
//
//  Created by T Krobot on 24/11/23.
//


import SwiftUI

struct CircleView: View {
    var body: some View {
        VStack(spacing: 20){
            ZStack {
                Circle()
                    .stroke(Color(.systemGray4), lineWidth: 20)
                Circle()
                    .trim(from: 0, to: 0.55)
                    .stroke(Color.blue, lineWidth: 20)
            }
            .frame(width: 200, height: 200)

            Path() { path in
                path.addArc(
                    center: CGPoint(x: 100, y: 100),
                    radius: 90,
                    startAngle: Angle(degrees: 0.0),
                    endAngle: Angle(degrees: 360 * 0.55),
                    clockwise: false)
            }
            .stroke(Color.blue, lineWidth: 20)
            .frame(width: 200, height: 200)

        }
        Spacer()
    }
}

struct CircleView_Previews: PreviewProvider {
    static var previews: some View {
        CircleView()
    }
}
