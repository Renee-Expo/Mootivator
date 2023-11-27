////
////  AnimalEmotionElement.swift
////  Ratatouille
////
////  Created by klifton Cheng stu on 18/11/23.
////
//

import SwiftUI

struct AnimalEmotionElement: View {
    @Binding var scale: Double
    @Binding var animalEmotionScale: Double
    
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
        AnimalEmotionElement(scale: .constant(0), animalEmotionScale: .constant(0))
    }
}

struct EmotionBar: View {
    var body: some View {
        HStack {
            Rectangle()
                .frame(height: 10)
                .cornerRadius(10)
                .foregroundStyle(.linearGradient(colors: [Color.pink, Color.yellow, Color.green], startPoint: .leading, endPoint: .trailing))
                .overlay(
                    HStack {
                        Rectangle()
                            .frame(width: 2, height: 10)
                            .cornerRadius(10)
                            .opacity(0.8)
                    }
                )
        }
    }
}
