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
        case minWidth(CGFloat = UIScreen.width / 2.75)
    }
    
    var text: String
    var imageSource: ImageSource?
    var foregroundColor: Color = .black
    var backgroundColor: Color = .white
    var widthMode: WidthMode = .minWidth()
    var action: () -> Void
    
    var body: some View {
        Button {
            action()
        } label: {
            label
        }
        .buttonStyle(.interactive)
    }
    
    private var label: some View {
        HStack {
            if let source = imageSource {
                source.image
            }
            Text(text)
        }
        .font(.headline)
        .foregroundStyle(foregroundColor)
        .closure { view in
            if case .minWidth(let width) = widthMode {
                view
                    .frame(minWidth: width)
            } else {
                view
                    .frame(maxWidth: .infinity)
            }
        }
        .padding(.vertical, 14)
        .padding(.horizontal)
        .background(
            Capsule(style: .continuous)
                .fill(.white)
        )
    }
}

#Preview {
    CapsuleButton(text: "textasdsadas", imageSource: .resource(.googleLogo), action: {})
}
