//
//  AnimalPickerView.swift
//  Ratatouille
//
//  Created by rgs on 20/11/23.
//

import SwiftUI

struct AnimalPickerView: View {
    @EnvironmentObject var goalManager: GoalManager
    @Environment(\.dismiss) var dismiss
    @State private var animalImages = ["Cow_Happy", "Sheep_Happy", "Chicken_Happy", "Goat_Happy", "Dog_Happy", "Pig_Happy", "Cat_Happy", "Horse_Happy", "Duck_Happy", "Rabbit_Happy"]
    @Binding var selectedAnimal: Int
    @State private var isSaveButtonEnabled = false
    @State private var clickedButton: Int? = nil
    private let animals: [Int] = Array(1...10)
    private let adaptiveColumns = [
        GridItem(.adaptive(minimum: 170))
    ]
    
    var body: some View {
        NavigationView {
            ScrollView(.vertical) {
                LazyVGrid(columns: adaptiveColumns, spacing: 20) {
                    ForEach(animals, id: \.self) { animal in
                        Button(action: {
                            buttonTapped(animal)
                        }) {
                            ZStack {
                                RoundedRectangle(cornerRadius: 8)
                                    .stroke(Color.black, lineWidth: 2)
                                    .frame(width: 150, height: 150)
                                    .opacity(clickedButton == animal ? 0.5 : 1.0)
                                    .onTapGesture {
                                        buttonTapped(animal)
                                    }
                                Image(animalImages[animal - 1])
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 150, height: 150)
                                    .opacity(clickedButton == animal ? 0.5 : 1.0)
                            }
                        }
                    }
                }
                .padding()
                
                if let selectedAnimal = clickedButton {
                    Button(action: {
                        dismiss()
                    }) {
                        Text("Save")
                            .buttonStyle(.borderedProminent)
                            .fontWeight(.bold)
                            .multilineTextAlignment(.center)
                            .foregroundColor(.white)
                            .padding()
                            .background(Color("AccentColor"))
                            .cornerRadius(8)
                    }
                } else {
                    Button(action: {
                        
                    }) {
                        Text("Save")
                    }
                    .disabled(true)
                    .frame(maxWidth: .infinity)
                    .padding()
                }
            }
            .navigationTitle("Pick your companion!")
        }
    }
    
    func buttonTapped(_ animal: Int) {
        clickedButton = animal
        selectedAnimal = animal
        isSaveButtonEnabled = true
    }
}

struct AnimalPickerView_Previews: PreviewProvider {
    static var previews: some View {
        AnimalPickerView(selectedAnimal: .constant(0))
            .environmentObject(GoalManager())
    }
}
