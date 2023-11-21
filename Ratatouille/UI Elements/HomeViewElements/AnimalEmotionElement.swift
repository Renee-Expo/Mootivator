//
//  AnimalEmotionElement.swift
//  Ratatouille
//
//  Created by klifton Cheng stu on 18/11/23.
//

import SwiftUI

struct AnimalEmotionElement: View {
    
    @Binding var scale : Double
    
    var body: some View {
        VStack {
            Image(systemName: "arrowtriangle.down.fill")
                .resizable()
                .scaledToFit()
                .frame(width: 15)
                .offset(x: scale, y: 0)
            HStack {
                Rectangle()
                    .frame(height: 10)
                    .cornerRadius(10)
                    .foregroundStyle(.linearGradient(colors: [Color.pink, Color.yellow, Color.green], startPoint: .leading, endPoint: .trailing))
            }
            .overlay(content: {
                HStack {
                    Rectangle()
                        .frame(width: 2, height: 10)
                        .cornerRadius(10)
                        .opacity(0.8)
                }
            })
            .padding(.horizontal)
        }
    }
}

struct AnimalEmotionElement_Previews: PreviewProvider {
    static var previews: some View {
        AnimalEmotionElement(scale: .constant(-30))
    }
}
