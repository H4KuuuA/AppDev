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
    @State private var spacing: CGFloat = 0
    @State private var rotation: CGFloat = .zero
    @State private var enableRefletion: Bool = false
    
    var body: some View {
        NavigationStack{
            VStack{
                Spacer(minLength: 0)
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
                
                Spacer(minLength: 0)
                
                /// Customization View
                VStack(alignment: .leading, spacing: 10, content: {
                    Toggle("Toggle reflection", isOn: $enableRefletion)
                        .font(.caption2)
                        .foregroundColor(.gray)
                    Slider(value: $spacing, in: -90...20)
                    
                    Text("Card Spacing")
                        .font(.caption2)
                        .foregroundStyle(.gray)
                    
                    Slider(value:  $rotation, in: -90...20)
                })
                .padding(15)
                .background(.ultraThinMaterial, in: .rect(cornerRadius: 10))
                .padding(15)
            }
            .navigationTitle("Bookfy")
        }
        .preferredColorScheme(.dark)
    }
}

#Preview {
    ContentView()
}
