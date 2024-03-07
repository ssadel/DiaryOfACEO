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
    
    init(card: Card, width: CGFloat = UIScreen.width * 0.85) where Content == EmptyView {
        self.data = .card(card)
        self.width = width
    }
    init(@ViewBuilder content: @escaping () -> Content, width: CGFloat = UIScreen.width * 0.85) {
        self.data = .view(content())
        self.width = width
    }
    
    var data: CardData
    var width: CGFloat
    
    var body: some View {
        ZStack {
            background
            content
        }
        .aspectRatio(0.7, contentMode: .fit)
        .frame(width: width)
        .clipShape(RoundedRectangle(cornerRadius: 20, style: .continuous))
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
