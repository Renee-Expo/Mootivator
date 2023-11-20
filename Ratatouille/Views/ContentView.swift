//
//  ContentView.swift
//  Ratatouille
//
//  Created by rgs on 4/9/23.
//

import SwiftUI

// Don't code in this View, its the main holding view, so tab bars, sidebars, etc.

struct ContentView: View {
    var body: some View {
        TabView {
            HomeView()
                .tabItem {
                    Text("Home")
                    Image(systemName: "house")
                }
            GoalView()
                .tabItem {
                    Text("Goals")
                    Image(systemName: "star.fill")
                }
            EmptyView()
                .tabItem {
                    Text("Animals")
                    Image(systemName: "pawprint.fill")
                }
            EmptyView()
                .tabItem {
                    Text("Notifications")
                    Image(systemName: "bell.fill")
                }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
