//
//  ContentView.swift
//  DiaryOfACEO
//
//  Created by Sidney Sadel on 3/7/24.
//

import SwiftUI

struct MasterView: View {
    @StateObject private var viewModel: MasterViewModel = .init()
    @AppStorage("didOnboardUser") var didOnboardUser: Bool = false
    
    var body: some View {
        ZStack {
            if !didOnboardUser {
                OnboardingView()
            } else if !viewModel.isLoggedIn {
                // login view
            } else {
                HomeView()
            }
        }
        .animation(.easeInOut, value: didOnboardUser)
        .animation(.easeInOut, value: viewModel.isLoggedIn)
    }
}

final class MasterViewModel: ObservableObject {
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
