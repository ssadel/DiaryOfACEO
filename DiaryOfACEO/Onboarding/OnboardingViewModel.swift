//
//  OnboardingViewModel.swift
//  DiaryOfACEO
//
//  Created by Sidney Sadel on 3/7/24.
//

import Foundation

final class OnboardingViewModel: ObservableObject {
    enum Step: Int, CaseIterable {
        case first
        case second
        case third
        case fourth
    }
    
    @Published private(set) var currentStep: Step = .first
    
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
            // completed
        }
    }
    
    func backButtonTapped() {
        guard let nextStep = Step(rawValue: self.currentStep.rawValue - 1) else {
            return
        }
        self.currentStep = nextStep
    }
    
    func skipButtonTapped() {
        // completed
    }
}
