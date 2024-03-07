//
//  Card.swift
//  DiaryOfACEO
//
//  Created by Sidney Sadel on 3/7/24.
//

struct Card {
    var question: String
    var author: String
}

extension Card {
    static let sampleCards: [Card] = [
        .init(question: "What da dog doin?", author: "Lebron James")
    ]
}
