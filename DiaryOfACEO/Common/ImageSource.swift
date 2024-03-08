//
//  ImageSource.swift
//  DiaryOfACEO
//
//  Created by Sidney Sadel on 3/7/24.
//

import SwiftUI

enum ImageSource {
    case systemImage(String)
    case resource(ImageResource)
    
    var image: Image {
        switch self {
        case .systemImage(let string):
            return Image(systemName: string)
        case .resource(let imageResource):
            return Image(imageResource)
        }
    }
}
