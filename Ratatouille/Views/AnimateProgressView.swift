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
            CircularProgressView(progress: self.progress / 100)
                .animation(.linear)

            VStack {
            Text("Progress: \(progress, specifier: "%.1f")")
                Slider(value: $progress,
                       in: minProgress...maxProgress,
                       minimumValueLabel: Text("0"),
                       maximumValueLabel: Text("100")
                ) {}
            }
            .padding()

            Spacer()
        }
        .padding(20)
    }
}


struct AnimateProgressView_Previews: PreviewProvider {
    static var previews: some View {
        AnimateProgressView()
    }
}
