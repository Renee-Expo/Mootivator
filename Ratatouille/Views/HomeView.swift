//
//  HomeView.swift
//  Ratatouille
//
//  Created by klifton Cheng stu on 18/11/23.
//

import SwiftUI

struct HomeView: View {
    
    @State var animalEmotion: Double = 20 // testing variable
    
    var body: some View {
        Text("Metric == \(animalEmotion)")
        Spacer()
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
