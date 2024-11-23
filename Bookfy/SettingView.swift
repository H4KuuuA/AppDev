//
//  SettingView.swift
//  Bookfy
//
//  Created by 大江悠都 on 2024/11/22.
//

import SwiftUI

struct SettingView: View {
    @Binding var spacing: CGFloat
    @Binding var rotation: CGFloat
    @Binding var enableReflection: Bool
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10, content: {
            Toggle("Toggle Reflection", isOn: $enableReflection)
                .font(.caption2)
                .foregroundColor(.gray)
            
            Slider(value: $spacing, in: -120...20)
                .onChange(of: spacing) { newValue in
                    print("Spacing value changed: \(newValue)")
                }
            
            Text("Card Rotation")
                .font(.caption2)
                .foregroundStyle(.gray)
            
            Slider(value: $rotation, in: 0...180)
                .onChange(of: rotation) { newValue in
                    print("Rotation value changed: \(newValue)")
                }
        })
        .padding(15)
        .background(.ultraThinMaterial, in: .rect(cornerRadius: 10))
        .padding(15)
    }
}

struct CustomizationView_Previews: PreviewProvider {
    @State static var spacing: CGFloat = -50
    @State static var rotation: CGFloat = 45
    @State static var enableReflection: Bool = true

    static var previews: some View {
        SettingView(spacing: $spacing, rotation: $rotation, enableReflection: $enableReflection)
    }
}
