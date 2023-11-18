//
//  HomeView.swift
//  Ratatouille
//
//  Created by klifton Cheng stu on 18/11/23.
//

import SwiftUI

struct HomeView: View {
    
    @State var animalEmotion = 0
    
    var body: some View {
        Text("Metric == \(animalEmotion)")
    }
}

#Preview {
    HomeView()
}
