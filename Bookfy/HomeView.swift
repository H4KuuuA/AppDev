//
//  HomeView.swift
//  Bookfy
//
//  Created by 大江悠都 on 2024/11/22.
//

import SwiftUI

struct HomeView<Content: View, Item: RandomAccessCollection>: View where Item.Element: Identifiable{
    var itemWidth : CGFloat
    var enableReflection: Bool = false
    var spacing : CGFloat = 0
    var rotation: Double
    var items: Item
    var content: (Item.Element) -> Content
    
    var body: some View {
        GeometryReader {
            let size = $0.size
            ScrollView(.horizontal){
                LazyHStack(spacing: 0){
                    ForEach(items) { item in
                        content(item)
                            .frame(width: itemWidth)
                            .reflection(true)
                    }
                }
                .padding(.horizontal,(size.width - itemWidth) / 2)
                .scrollTargetLayout()
            }
            .scrollTargetBehavior(.viewAligned)
            .scrollIndicators(.hidden)
            .scrollClipDisabled()
        }
        
    }
}

/// Cover Flow Item Model
struct CoverFlowItem: Identifiable {
    let id : UUID = .init()
    var color: Color
}
#Preview {
    ContentView()
}
