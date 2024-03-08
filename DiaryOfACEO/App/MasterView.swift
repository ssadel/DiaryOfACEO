//
//  ContentView.swift
//  DiaryOfACEO
//
//  Created by Sidney Sadel on 3/7/24.
//

import SwiftUI
import Combine

struct MasterView: View {
    @StateObject private var viewModel: MasterViewModel = .init()
    @AppStorage("didOnboardUser") var didOnboardUser: Bool = false
    
    init() {
        // reset for testing
        didOnboardUser = false
    }
    
    var body: some View {
        ZStack {
            if !didOnboardUser {
                OnboardingView()
            } else if viewModel.authState == .notAuthenticated {
                LoginView()
            } else {
                HomeView()
            }
        }
        .animation(.easeInOut, value: didOnboardUser)
        .animation(.easeInOut, value: viewModel.authState)
    }
}

final class MasterViewModel: ObservableObject {
    @Published private(set) var authState: AuthService.State
    
    private let authService: AuthService = ServiceContainer.shared.authService
    private var cancelBag = Set<AnyCancellable>()
    
    init() {
        print("MasterViewModel init")
        self.authState = authService.authState
        self.setupObservers()
    }
    
    deinit {
        print("MasterViewModel deinit")
        cancelBag.forEach { $0.cancel() }
    }
    
    private func setupObservers() {
        authService.$authState
            .receive(on: DispatchQueue.main)
            .sink { [weak self] authState in
                self?.authState = authState
            }
            .store(in: &cancelBag)
    }
}

#Preview {
    MasterView()
}
