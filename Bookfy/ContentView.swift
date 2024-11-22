//
//  ContentView.swift
//  Bookfy
//
//  Created by 大江悠都 on 2024/11/19.
//

import SwiftUI

struct ContentView: View {
    @State private var items: [CoverFlowItem] = [.red, .blue, .green, .yellow, .primary].compactMap {
        return .init(color: $0)
    }
    var body: some View {
        NavigationStack{
            VStack{
                HomeView(
                    itemWidth: 280,
                    spacing: 0,
                    rotation: 0,
                    items: items
                ) {item in
                RoundedRectangle(cornerRadius: 20)
                        .fill(item.color.gradient)
                }
                .frame(height: 180)
            }
            .navigationTitle("Bookfy")
        }
        .preferredColorScheme(.dark)
    }
}

#Preview {
    ContentView()
}
