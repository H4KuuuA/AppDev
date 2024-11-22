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
                        /// Moving to Bottom
                        .offset(y: size .height)
                }
            }
    }
}
