//
//  MultiPickerView.swift
//  Ratatouille
//
//  Created by rgs on 20/11/23.
//

import SwiftUI

struct MultiSelectPickerView: View {
    //the list of all items to read from
    @State var days: [String]
    
    //a binding to the values we want to track
    @Binding var selectedDays: [String]
    
    var body: some View {
        Form {
            List {
                ForEach(days, id: \.self) { item in
                    Button(action: {
                        withAnimation {
                            if self.selectedDays.contains(item) {
                                //you may need to adapt this piece, my object has an ID I match against rather than just the string
                                self.selectedDays.removeAll(where: { $0 == item })
                            } else {
                                self.selectedDays.append(item)
                            }
                        }
                    }) {
                        HStack {
                            Image(systemName: "checkmark")
                                .opacity(self.selectedDays.contains(item) ? 1.0 : 0.0)
                            Text("\(item)")
                        }
                    }
                    .foregroundColor(.primary)
                }
            }
        }
        .listStyle(GroupedListStyle())
    }
}
