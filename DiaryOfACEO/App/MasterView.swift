//
//  ContentView.swift
//  DiaryOfACEO
//
//  Created by Sidney Sadel on 3/7/24.
//

import SwiftUI

struct MasterView: View {
    @StateObject private var viewModel: MasterViewModel = .init()
    
    var body: some View {
        ZStack {
            if !viewModel.didUserGetOnboarded {
                // onboarding view
            } else if !viewModel.isLoggedIn {
                // login view
            } else {
                // main
            }
        }
    }
}

final class MasterViewModel: ObservableObject {
    @Published private(set) var didUserGetOnboarded: Bool = true
    @Published private(set) var isLoggedIn: Bool = true // TODO: imp
    
    init() {
        print("MasterViewModel init")
    }
    
    deinit {
        print("MasterViewModel deinit")
    }
}

#Preview {
    MasterView()
}