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
                    Label("追加", systemImage: "square.and.arrow.down.fill")
                }
            
            Text("Settings")
                .tabItem {
                    Label("設定", systemImage: "gearshape")
                }
        }
    }
}

#Preview {
    RootView{
        ContentView()
    }
}
