//
//  AnimalPickerView.swift
//  Ratatouille
//
//  Created by rgs on 20/11/23.
//

import SwiftUI

struct AnimalPickerView: View {
    @State private var showNewGoalSheet = false
    @Binding var selectedAnimal: Int
    private let animals: [Int] = Array(1...10)
    private let adaptiveColumns = [
    
        GridItem(.adaptive(minimum: 170))
    ]
    var body: some View {
        NavigationView{
            ScrollView(.vertical){
                VStack{
                    ForEach(animals, id: \.self) { animals in
                        ZStack{
                            RoundedRectangle(cornerRadius: 8)
                                .stroke(Color.black, lineWidth: 2) // Outline color and width
                                .frame(width: 150, height: 150)
                        }
                    }
                }
            }
        }
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
        Button(action: {
            showNewGoalSheet = true
        }) {
            Text("Set your first goal!")
                .frame(width: 200, height: 50)
                .foregroundColor(.white)
                .background(Color("AccentColor"))
                .cornerRadius(8)
        }
        .sheet(isPresented: $showNewGoalSheet) {
            // Define the content of the sheet here
            Text("sheet")
            // Add any additional views or components you need
        }
    }
}

struct AnimalPickerView_Previews: PreviewProvider {
    static var previews: some View {
        AnimalPickerView(selectedAnimal: .constant(0))
    }
}
