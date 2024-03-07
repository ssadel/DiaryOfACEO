//
//  StyledButton.swift
//  DiaryOfACEO
//
//  Created by Sidney Sadel on 3/7/24.
//

import SwiftUI

struct CapsuleButton: View {
    enum WidthMode {
        case maxWidth
        case value(CGFloat)
    }
    
    var text: String
    var action: () -> Void
    var foregroundColor: Color = .black
    var backgroundColor: Color = .white
    var widthMode: WidthMode = .value(UIScreen.width / 2.5)
    
    var body: some View {
        Button {
            action()
        } label: {
            label
        }
        .buttonStyle(.interactive)
    }
    
    private var label: some View {
        Text(text)
            .font(.headline)
            .foregroundStyle(foregroundColor)
            .closure { view in
                if case .value(let width) = widthMode {
                    view
                        .frame(minWidth: width)
                } else {
                    view
                        .frame(maxWidth: .infinity)
                }
            }
            .padding(.vertical, 12)
            .background(
                Capsule(style: .continuous)
                    .fill(.white)
            )
    }
}

#Preview {
    CapsuleButton(text: "text", action: {}, widthMode: .maxWidth)
}
