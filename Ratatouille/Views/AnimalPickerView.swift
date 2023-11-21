//
//  AnimalPickerView.swift
//  Ratatouille
//
//  Created by rgs on 20/11/23.
//

import SwiftUI

struct AnimalPickerView: View {
    @State private var showNewGoalSheet = false
    var body: some View {
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
        AnimalPickerView()
    }
}
