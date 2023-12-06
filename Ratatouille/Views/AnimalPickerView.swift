//
//  AnimalPickerView.swift
//  Ratatouille
//
//  Created by rgs on 20/11/23.
//

import SwiftUI

struct AnimalPickerView: View {
    @ObservedObject var goalManager: GoalManager = .shared
    @ObservedObject var unlockedAnimalManager : UnlockedAnimalManager = .shared
    
    @Environment(\.dismiss) var dismiss
    @Binding var selectedAnimalKind: AnimalKind
    @Binding var unlockedAnimals: [AnimalKind]

    private let adaptiveColumns = [
        GridItem(.adaptive(minimum: 170))
    ]

    var body: some View {
        ScrollView(.vertical) {
            LazyVGrid(columns: adaptiveColumns, spacing: 20) {
                ForEach(unlockedAnimalManager.items, id: \.asString) { animalKind in
                    Button {
                        selectedAnimalKind = animalKind
                    } label: {
                        ZStack {
                            RoundedRectangle(cornerRadius: 8)
                                .stroke((selectedAnimalKind == animalKind ? Color.black : Color.gray), lineWidth: 2)
                            
                            Image("\(animalKind.image)" + "Happy")
                                .resizable()
                                .scaledToFit()
                        }
                        .frame(width: 150, height: 150)
                        .opacity(selectedAnimalKind == animalKind || UnlockedAnimalManager.shared.items.contains(animalKind) ? 1.0 : 0.5)
                    }
                }
            }
            .padding()
            
            Button {
                dismiss()
            } label: {
                Text("Save")
                    .buttonStyle(.borderedProminent)
                    .fontWeight(.bold)
                    .multilineTextAlignment(.center)
                    .foregroundColor(.white)
                    .padding()
                    .background(Color("AccentColor"))
                    .cornerRadius(8)
            }
        }
        .navigationTitle("Pick your companion!")
    }
}


struct AnimalPickerPreviewWrapper: View {
    @State var selectedAnimalKind: AnimalKind = .cow
    @State var unlockedAnimals: [AnimalKind] = [.cow, .cat]
    var body: some View {
        AnimalPickerView(selectedAnimalKind: $selectedAnimalKind, unlockedAnimals: $unlockedAnimals)
    }
}

struct AnimalPickerView_Previews: PreviewProvider {
    static var previews: some View {
        AnimalPickerPreviewWrapper()
    }
}

