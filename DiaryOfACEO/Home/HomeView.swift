//
//  HomeView.swift
//  DiaryOfACEO
//
//  Created by Sidney Sadel on 3/7/24.
//

import SwiftUI

struct HomeView: View {
    @State var activeIndex: Int = 0
    
    var body: some View {
        
        CardScrollView(activeIndex: $activeIndex, cards: Card.sampleCards)
        
    }
}

#Preview {
    HomeView()
}
