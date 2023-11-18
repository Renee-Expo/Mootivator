//
//  HomeView.swift
//  Ratatouille
//
//  Created by klifton Cheng stu on 18/11/23.
//

import SwiftUI

struct HomeView: View {
    @State var indexItem : Int = 0
    
    var body: some View {
        VStack {
            AnimalEmotionElement(scale: .constant(20))
            Text("Metric == \(indexItem)") // for debugging
            Spacer()
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
