//
//  ServiceContainer.swift
//  DiaryOfACEO
//
//  Created by Sidney Sadel on 3/7/24.
//

import Foundation

protocol Service {
    func start()
    func reset()
}

final class ServiceContainer {
    static let shared: ServiceContainer = .init()
    
    let authService: AuthService
    
    private let services: [Service]
    
    private init() {
        authService = .init()
        
        services = [
            authService
        ]
    }
    
    func start() {
        for service in services {
            service.start()
        }
    }
    
    func reset() {
        for service in services {
            service.reset()
        }
    }
}
