//
//  SettingView.swift
//  Bookfy
//
//  Created by 大江悠都 on 2024/11/22.
//

import SwiftUI

struct SettingView: View {
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        VStack(alignment: .leading, spacing: 15, content:{
            HStack{
                Button(action: {
                    dismiss()
                }, label: {
                    Image(systemName: "xmark.circle.fill")
                        .font(.title)
                        .tint(.gray)
                    
                })
            }
        })
    }
}

#Preview {
    SettingView()
        .vSpacing(.bottom)
}
