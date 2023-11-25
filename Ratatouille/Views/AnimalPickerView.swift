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
    @Binding var selectedAnimalKind: AnimalKind // only returns Animal.kind
    //    @Binding var isAnimalSelected: Bool
    //    @State private var clickedButton: Bool? = nil
    //    private let animals: [Int] = Array(1...10) // may not need?
    private let adaptiveColumns = [
        GridItem(.adaptive(minimum: 170))
    ]
    
    var body: some View {
        NavigationView {
            ScrollView(.vertical) {
                LazyVGrid(columns: adaptiveColumns, spacing: 20) {
                    ForEach(AnimalKind.allCases, id: \.self) { animalKind in
                        Button {
                            selectedAnimalKind = animalKind
                        } label: {
                            //                            if animalKind != .none {
                            ZStack {
                                RoundedRectangle(cornerRadius: 8)
                                    .stroke(selectedAnimalKind == animalKind ? Color.black : Color.gray, lineWidth: 2)
                                    .frame(width: 150, height: 150)
                                    .opacity(selectedAnimalKind == animalKind ? 0.5 : 1.0)
                                
                                Image("\(animalKind.image)" + "Happy")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 150, height: 150)
                                    .opacity(selectedAnimalKind == animalKind ? 0.5 : 1.0)
                            }
                            //                            }
                        }
                    }
                }
                .padding()
                // Save Button Code
                Button {
                    //                    if selectedAnimalKind == .none {
                    //                        print("selectedAnimalKind = \(selectedAnimalKind)")
                    //                    } else {
                    //                        // selected animal should be set above
                    //                    isAnimalSelected = true
                    dismiss()
                    //                    }
                } label: {
                    Text("Save")
                        .buttonStyle(.borderedProminent)
                        .fontWeight(.bold)
                        .multilineTextAlignment(.center)
                        .foregroundColor(.white)
                        .padding()
                        .background(Color("AccentColor"))
                        .cornerRadius(8)
                    // .disabled(selectedAnimalKind == .none ? true : false)
                }
                /*
                 if let selectedAnimal = selectedAnimal {
                 Button {
                 //                        isAnimalSelected = true
                 self.selectedAnimal = selectedAnimal
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
                 } else {
                 Button{
                 // add save code here
                 } label: {
                 Text("Save")
                 }
                 .disabled(true)
                 .frame(maxWidth: .infinity)
                 .padding()
                 }
                 */
            }
            .navigationTitle("Pick your companion!")
        }
    }
    /*
     func buttonTapped(_ animal: Animal) {
     clickedButton = false
     selectedAnimal = animal
     }
     */
}

struct AnimalPickerPreviewWrapper: View {
    @State var selectedAnimalKind: AnimalKind = .cow
    
    var body: some View {
        AnimalPickerView(selectedAnimalKind: $selectedAnimalKind)
            .environmentObject(GoalManager())
    }
}

struct AnimalPickerView_Previews: PreviewProvider {
    static var previews: some View {
        AnimalPickerPreviewWrapper()
    }
}

