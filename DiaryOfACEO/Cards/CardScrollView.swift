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
    
    private let cardWidth: CGFloat = UIScreen.width * 0.85
    private let spacing: CGFloat = 5
    private var spacingFromViewEdgeToCard: CGFloat {
        (UIScreen.width - cardWidth) / 2
    }
    private var maxOffsetX: CGFloat {
        distance(for: cards.count + 2)
    }
    
    var body: some View {
        ZStack {
            ForEach(cards) { card in
                CardCell(card: card, width: cardWidth)
                    .offset(x: offset(for: card))
            }
            Text("WIP")
                .foregroundStyle(.red)
                .font(.title)
        }
        .padding(.horizontal, spacingFromViewEdgeToCard)
        .gesture(
            DragGesture()
                .onChanged { v in
                    let value = snappedOffsetX + v.translation.width
                    guard -value > 0, -value < maxOffsetX else { return }
                    currentDragOffsetX = value
                }
                .onEnded { v in
                    snappedOffsetX = currentDragOffsetX
                    self.activeIndex = getIndexFrom(distance: snappedOffsetX)
                }
        )
    }
    
    private func offset(for card: Card) -> CGFloat {
        if let index = cards.firstIndex(where: { $0.id == card.id }) {
            return distance(for: index)
        }
        return 0
    }
    
    private func distance(for index: Int) -> CGFloat {
        ((CGFloat(index) * (cardWidth + spacing))) + currentDragOffsetX
    }
    
    private func getIndexFrom(distance: CGFloat) -> Int {
        Int(distance / self.distance(for: 1))
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
