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
                
                /// Customization View
                VStack(alignment: .leading, spacing: 10, content: {
                    Toggle("Toggle Spacing", isOn: $enableReflection)
                        .font(.caption2)
                        .foregroundColor(.gray)
                    Slider(value: $spacing, in: -120...20)
                        .onChange(of: spacing) { newValue in
                            print("Spacing value changed: \(newValue)")
                        }
                    
                    Text("Card Rotaion")
                        .font(.caption2)
                        .foregroundStyle(.gray)
                    
                    Slider(value:  $rotation, in: 0...180)
                        .onChange(of: rotation) { newValue in
                            print("Spacing value changed: \(newValue)")
                        }
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
