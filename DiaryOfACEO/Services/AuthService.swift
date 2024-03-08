//
//  AuthService.swift
//  DiaryOfACEO
//
//  Created by Sidney Sadel on 3/7/24.
//

import Foundation

final class AuthService: Service {
    enum State {
        case loading
        case guest
        case notAuthenticated
        case authenticated
    }
    
    @Published private(set) var authState: State = .loading
    
    init() {
        observeAuthState()
    }
    
    func start() {}
    
    func reset() {}
    
    func simulateLogIn() {
        self.authState = .authenticated
    }
    
    private func observeAuthState() {
        // placeholder
        self.authState = .notAuthenticated
    }
}
