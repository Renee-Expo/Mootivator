//
//  MainView.swift
//  Ratatouille
//
//  Created by klifton Cheng stu on 4/9/23.
//

import SwiftUI

struct MainView: View {
    var body: some View {
        TabView {
            HomeView()
                .tabItem {
                    Text("HomeView")
                    Image(systemName: "house")
                }
            
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
