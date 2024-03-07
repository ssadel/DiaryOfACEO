//
//  Card.swift
//  DiaryOfACEO
//
//  Created by Sidney Sadel on 3/7/24.
//

import Foundation

struct Card: Identifiable {
    var id: String = UUID().uuidString
    var question: String
    var author: String
}

extension Card {
    static let sampleCards: [Card] = [
        .init(question: "What da dog doin?", author: "Lebron James"),
        .init(question: "What's the biggest lesson you've learned on your own?", author: "Gary Neville"),
        .init(question: "Do you hate Steven Singer", author: "Not Steven Singer"),
        .init(question: "Who is the GOAT?", author: "Tom Brady")
    ]
}
