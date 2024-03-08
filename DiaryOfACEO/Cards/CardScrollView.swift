//
//  CardFeedView.swift
//  DiaryOfACEO
//
//  Created by Sidney Sadel on 3/7/24.
//

import SwiftUI

struct CardScrollView: View {
    @Binding var activeIndex: Int
    var cards: [Card]
    
    @State private var currentDragOffsetX: CGFloat = .zero
    @State private var snappedOffsetX: CGFloat = .zero
    private let cellWidth: CGFloat = UIScreen.width * 0.85
    private let cellSpacing: CGFloat = 5
    private let centerX: CGFloat = UIScreen.width / 2
    private var spacingFromViewEdgeToCard: CGFloat {
        (UIScreen.width - cellWidth) / 2
    }
    private var totalWidth: CGFloat {
        distance(for: cards.count - 1)
    }
    
    var body: some View {
        HStack {
            ForEach(cards) { card in
                let isActive: Bool = cards.firstIndex(where: { $0.id == card.id }) == activeIndex
                
                CardCell(card: card, width: cellWidth)
                    .rotationEffect(.degrees(isActive ? 0 : 4))
                    .brightness(isActive ? 0 : -0.5)
                    .zIndex(isActive ? 1 : 0)
            }
        }
        .offset(x: offset())
        .padding(.horizontal, spacingFromViewEdgeToCard)
        .gesture(
            DragGesture()
                .onChanged { v in
                    let value = snappedOffsetX + (v.translation.width / 2)
                    withAnimation(.interactiveSpring) {
                        currentDragOffsetX = value
                    }
                }
                .onEnded(onDragEnd(_:))
        )
    }
    
    private func offset() -> CGFloat {
        (totalWidth / 2) + currentDragOffsetX
    }
    
    private func distance(for index: Int) -> CGFloat {
        CGFloat(index) * (cellWidth + (cellSpacing * 2))
    }
    
    private func onDragEnd(_ v: _ChangedGesture<DragGesture>.Value) {
        let threshold: CGFloat = UIScreen.width / 2
        let swipeToNextItem: Bool = v.translation.width < 0 &&
        (v.translation.width < -threshold || v.predictedEndTranslation.width < -threshold)
        let swipeToPreviousItem: Bool = v.translation.width > 0 &&
        (v.translation.width > threshold || v.predictedEndTranslation.width > threshold)
        
        withAnimation(.interpolatingSpring) {
            if swipeToNextItem && cards[safe: activeIndex + 1] != nil {
                activeIndex += 1
                currentDragOffsetX = -distance(for: activeIndex)
                snappedOffsetX = currentDragOffsetX
            } else if swipeToPreviousItem && cards[safe: activeIndex - 1] != nil {
                activeIndex -= 1
                currentDragOffsetX = -distance(for: activeIndex)
                snappedOffsetX = currentDragOffsetX
            } else {
                currentDragOffsetX = snappedOffsetX
            }
        }
    }
}

#Preview {
    struct Test: View {
        @State private var activeIndex: Int = 0
        var body: some View {
            CardScrollView(activeIndex: $activeIndex, cards: Card.sampleCards)
        }
    }
    
    return Test()
}
