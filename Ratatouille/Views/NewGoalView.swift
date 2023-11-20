//
//  NewGoalView.swift
//  Ratatouille
//
//  Created by Kaveri Mi on 19/11/23.
//

import SwiftUI

struct NewGoalView: View {
    
    @Binding var sourceArray: [Goal]
    
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

struct NewGoalView_Previews: PreviewProvider {
    static var previews: some View {
        NewGoalView(sourceArray: .constant([]))
    }
}
