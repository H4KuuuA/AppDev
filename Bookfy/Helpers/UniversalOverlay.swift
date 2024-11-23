//
//  UniversalOverlay.swift
//  Bookfy
//
//  Created by 大江悠都 on 2024/11/23.
//

import SwiftUI

/// Extensions
extension View {
    @ViewBuilder
    func universalOverlay<Content: View>(
        animation: Animation = .snappy,
        show: Binding<Bool>,
        @ViewBuilder content: @escaping () -> Content
    ) -> some View {
        self
            .modifier(UniversalOverlayModifier(animation: animation, show: show, viewContent: content))
    }
}

/// Root View Wrapper
struct RootView<Content: View>: View {
    @ViewBuilder var content: Content
    var body: some View {
        /*@START_MENU_TOKEN@*//*@PLACEHOLDER=Hello, world!@*/Text("Hello, world!")/*@END_MENU_TOKEN@*/
    }
}

/// Shared Universal Overlay Properities
@Observable
class UniversalOverlayProperities {
    var window: UIWindow?
    var views: [OverlayView] = []
    
    struct OverlayView: Identifiable {
        var id: String = UUID().uuidString
        var vieww: AnyView
    }
}
fileprivate struct UniversalOverlayModifier<ViewContent: View>: ViewModifier {
    var animation: Animation
    @Binding var show: Bool
    @ViewBuilder var viewContent: ViewContent
    
    func body(content: Content) -> some View {
        content
    }
}

struct UniversalOverlay: View {
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

#Preview {
    UniversalOverlay()
}
