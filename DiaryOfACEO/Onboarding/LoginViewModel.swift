//
//  LoginViewModel.swift
//  DiaryOfACEO
//
//  Created by Sidney Sadel on 3/7/24.
//

import Foundation

final class LoginViewModel: ObservableObject {
    private let authService: AuthService = ServiceContainer.shared.authService
    
    init() {
        print("LoginViewModel init")
    }
    
    deinit {
        print("LoginViewModel deinit")
    }
    
    func logIn() {
        authService.simulateLogIn()
    }
}
