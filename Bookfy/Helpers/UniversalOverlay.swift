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
    var content: Content
    init(@ViewBuilder content : @escaping() -> Content) {
        self.content = content()
    }
    var  properites = UniversalOverlayProperities()
    var body: some View {
        content
            .environment(properites)
            .onAppear{
                if let widowScene = (UIApplication.shared.connectedScenes.first as? UIWindowScene),
                   properites.window == nil {
                    let window = PassThroughWindow(windowScene: widowScene)
                    window.isHidden = false
                    window.isUserInteractionEnabled = true
                    ///  Setting Up SwiftUI Based RootView Controller
                    let rootViewController = UIHostingController(rootView: UniversalOverlayViews().environment(properites))
                    rootViewController.view.backgroundColor = .clear
                    window.rootViewController = rootViewController
                    properites.window = window
                }

            }
    }
}

/// Shared Universal Overlay Properities
@Observable
class UniversalOverlayProperities {
    var window: UIWindow?
    var views: [OverlayView] = []
    
    struct OverlayView: Identifiable {
        var id: String = UUID().uuidString
        var view: AnyView
    }
}
fileprivate struct UniversalOverlayModifier<ViewContent: View>: ViewModifier {
    var animation: Animation
    @Binding var show: Bool
    @ViewBuilder var viewContent: ViewContent
    /// Local View Properites
    @Environment(UniversalOverlayProperities.self) private var properites
    
    @State private var viewID: String?
    
    func body(content: Content) -> some View {
        content
            .onChange(of: show) { oldValue, newValue in
                if newValue {
                    
                }else {
                    
                }
            }
    }
    
    private func addview() {
            if properites.window != nil && viewID == nil {
                viewID = UUID().uuidString
                guard let viewID else { return }
                
                withAnimation(animation) {
                    properites.views.append(.init(id: viewID, view: .init(viewContent)))
                }
                self.viewID = nil
            }
        }
        
        private func removeView () {
            if let viewID {
                withAnimation(animation) {
                    properites.views.removeAll(where: { $0.id == viewID})
                }
            }
        }
}

fileprivate struct UniversalOverlayViews: View {
    @Environment(UniversalOverlayProperities.self) private var properities
    var body: some View {
        ZStack{
            
        }
    }
}

fileprivate class PassThroughWindow: UIWindow {
    override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
        guard let hitView = super.hitTest(point, with: event),
                let rootView = rootViewController?.view
        else { return nil }
        
        if #available(iOS 18, *) {
            for subview in rootView.subviews.reversed() {
                /// Finding if any of rootview's is  receving hit test
                let pointInSubView = subview.convert(point,from: rootView)
                if subview.hitTest(pointInSubView, with: event) == subview {
                    return hitView
                }
            }        }
        return hitView == rootView ? nil : hitView
    }
}
//#Preview {
//    UniversalOverlayViews()
//}
