//
//  CardCell.swift
//  DiaryOfACEO
//
//  Created by Sidney Sadel on 3/7/24.
//

import SwiftUI

struct CardCell: View {
    var body: some View {
        
        ZStack {
            RoundedRectangle(cornerRadius: 20, style: .continuous)
            
        }
        .aspectRatio(3/4, contentMode: .fit)
        .padding(.horizontal, 40)
        
    }
}

#Preview {
    CardCell()
}
