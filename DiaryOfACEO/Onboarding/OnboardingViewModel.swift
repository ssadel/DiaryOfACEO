//
//  OnboardingViewModel.swift
//  DiaryOfACEO
//
//  Created by Sidney Sadel on 3/7/24.
//

import SwiftUI

final class OnboardingViewModel: ObservableObject {
    enum Step: Int, CaseIterable {
        case first
        case second
        case third
        case fourth
    }
    
    @Published var currentStep: Step = .first
    @AppStorage("didOnboardUser") var didOnboardUser: Bool = false
    
    init() {
        print("OnboardingViewModel init")
    }
    
    deinit {
        print("OnboardingViewModel deinit")
    }
    
    func nextStepTapped() {
        if let nextStep = Step(rawValue: self.currentStep.rawValue + 1) {
            self.currentStep = nextStep
        } else {
            didOnboardUser = true
        }
    }
    
    func backButtonTapped() {
        guard let nextStep = Step(rawValue: self.currentStep.rawValue - 1) else {
            return
        }
        self.currentStep = nextStep
    }
    
    func skipButtonTapped() {
        didOnboardUser = true
    }
}
