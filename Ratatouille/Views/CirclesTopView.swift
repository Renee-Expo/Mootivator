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

struct CirclesTopView_Previews: PreviewProvider {
    static var previews: some View {
        CirclesTopView()
    }
}
