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
                    .frame(height: 20)
                    .cornerRadius(10)
                    .foregroundStyle(.linearGradient(colors: [Color.pink, Color.yellow, Color.green], startPoint: .leading, endPoint: .trailing))
            }
            .padding(.horizontal)
        }
    }
}

#Preview {
    AnimalEmotionElement(scale: .constant(-30))
}
