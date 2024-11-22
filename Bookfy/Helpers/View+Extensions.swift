//
//  View+Extensions.swift
//  Bookfy
//
//  Created by 大江悠都 on 2024/11/22.
//

import SwiftUI

extension View {
    ///Custom Spacers
    @ViewBuilder
    func  hSpacing(_ alignment: Alignment) -> some View {
        self
            .frame(maxWidth: .infinity, alignment: alignment)
    }
    @ViewBuilder
    func  vSpacing(_ alignment: Alignment) -> some View {
        self
            .frame(maxHeight: .infinity, alignment: alignment)
    }
    @ViewBuilder
    func reflection(_added: Bool) -> some View {
        self
            .overlay {
                GeometryReader {
                    let size = $0.size
                    
                    self
                    /// Flipping Upside Down
                        .scaleEffect(y: -1)
                        .mask {
                            Rectangle()
                                .fill(
                                    .linearGradient(colors: [
                                        .white,
                                        .white.opacity(0.7),
                                        .white.opacity(0.5),
                                        .white.opacity(0.3),
                                        .white.opacity(0.1),
                                        .white.opacity(0),
                                    ] + Array(repeating: Color .clear, count:  5), startPoint: .top, endPoint: .bottom)
                                )
                        }
                    /// Moving to Bottom
                        .offset(y: size .height + 5)
                        .opacity(0.5)
                }
            }
    }
}
