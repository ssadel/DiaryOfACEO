//
//  CardFeedView.swift
//  DiaryOfACEO
//
//  Created by Sidney Sadel on 3/7/24.
//

import SwiftUI

struct CardScrollView: View {
    @Binding var activeIndex: Int?
    var cards: [Card]
    
    @State private var currentDragOffsetX: CGFloat = .zero
    @State private var snappedOffsetX: CGFloat = .zero
    
    private let cellWidth: CGFloat = UIScreen.width * 0.85
    private let cellSpacing: CGFloat = 5
    private let centerX: CGFloat = UIScreen.width / 2
    private var spacingFromViewEdgeToCard: CGFloat {
        (UIScreen.width - cellWidth) / 2
    }
    private var maxOffsetX: CGFloat {
        distance(for: cards.count + 2)
    }
    
    var body: some View {
        ScrollView(.horizontal) {
            HStack {
                ForEach(cards) { card in
                    CardCell(card: card, width: cellWidth)
                }
            }
            .offset(x: currentDragOffsetX)
            .padding(.horizontal, spacingFromViewEdgeToCard)
        }
        .scrollIndicators(.hidden)
//        .scrollDisabled(true)
//        .gesture(
//            DragGesture()
//                .onChanged { v in
//                    let value = snappedOffsetX + v.translation.width
//                    // guard -value > 0, -value < maxOffsetX else { return }
//                    currentDragOffsetX = value
//                }
//                .onEnded { v in
//                    snappedOffsetX = currentDragOffsetX
//                    // check if next or current is closer
//                }
//        )
    }
    
    private func offset(for card: Card) -> CGFloat {
        if let index = cards.firstIndex(where: { $0.id == card.id }) {
            return distance(for: index)
        }
        return 0
    }
    
    private func distance(for index: Int) -> CGFloat {
        ((CGFloat(index) * (cellWidth + cellSpacing))) + currentDragOffsetX
    }
}

#Preview {
    struct Test: View {
        @State private var activeIndex: Int?
        var body: some View {
            CardScrollView(activeIndex: $activeIndex, cards: Card.sampleCards)
        }
    }
    
    return Test()
}
