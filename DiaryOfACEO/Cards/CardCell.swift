//
//  CardCell.swift
//  DiaryOfACEO
//
//  Created by Sidney Sadel on 3/7/24.
//

import SwiftUI

/// Can populate view with either a card or a view
struct CardCell<Content: View>: View {
    enum CardData {
        case view(Content)
        case card(Card)
    }
    
    init(card: Card) where Content == EmptyView {
        self.data = .card(card)
    }
    init(@ViewBuilder content: @escaping () -> Content) {
        self.data = .view(content())
    }
    
    var data: CardData
    
    var body: some View {
        ZStack {
            background
            content
        }
        .aspectRatio(3/4, contentMode: .fit)
        .frame(width: UIScreen.width * 0.85)
        .clipped()
    }
    
    @ViewBuilder
    private var content: some View {
        switch data {
        case .view(let content):
            content
        case .card(let card):
            VStack {
                Spacer()
                Text(card.question)
                    .font(.custom(.reenieBeenie, style: .title))
                Spacer()
                Text(card.author.uppercased())
                    .font(.headline.weight(.regular))
                    .monospaced()
                    .padding(.bottom, 30)
            }
            .foregroundStyle(.black)
        }
    }
    
    private var background: some View {
        RoundedRectangle(cornerRadius: 20, style: .continuous)
            .fill(.white)
    }
}

#Preview {
    CardCell(card: .sampleCards[0])
}
