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
    /// View properities
    @State private var spacing: CGFloat = -50
    @State private var rotation: CGFloat = 45
    @State private var enableReflection: Bool = true
    
    var body: some View {
        NavigationStack{
            VStack{
                Spacer(minLength: 0)
                HomeView(
                    itemWidth: 280,
                    enableReflection: enableReflection,
                    spacing: spacing,
                    rotation: rotation,
                    items: items
                ) {item in
                RoundedRectangle(cornerRadius: 20)
                        .fill(item.color.gradient)
                }
                .frame(height: 360)
                
                Spacer(minLength: 0)
                
            }
            .navigationTitle("Bookfy")
        }
        .preferredColorScheme(.dark)
    }
}

#Preview {
    ContentView()
}
