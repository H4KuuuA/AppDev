//
//  ContentView.swift
//  Bookfy
//
//  Created by 大江悠都 on 2024/11/19.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            // Home Tab - ContentViewを表示
            BookHomeView()
                .tabItem {
                    Label("ホーム", systemImage: "house")
                }
            
            // 他のタブを追加することもできます
            Text("Notifications")
                .tabItem {
                    Label("追加", systemImage: "plus.square.fill.on.square.fill")
                }
            
            Text("Settings")
                .tabItem {
                    Label("Settings", systemImage: "gearshape")
                }
        }
    }
}

#Preview {
    RootView{
        ContentView()
    }
}
