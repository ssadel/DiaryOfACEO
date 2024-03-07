//
//  OnboardingView.swift
//  DiaryOfACEO
//
//  Created by Sidney Sadel on 3/7/24.
//

import SwiftUI

struct OnboardingView: View {
    @StateObject private var viewModel: OnboardingViewModel = .init()
    
    var body: some View {
        VStack {
            header
            cards
            pageIndicator
            nextButton
            skipButton
        }
        .padding(.vertical)
    }
    
    private var header: some View {
        ZStack {
            Text("DOAC Conversation Cards")
                .font(.subheadline.weight(.semibold))
            
            Button {
                viewModel.backButtonTapped()
            } label: {
                Image(systemName: "arrow.left")
                    .font(.title2.weight(.medium))
                    .foregroundStyle(.white)
                    .padding()
            }
            .frame(maxWidth: .infinity, alignment: .leading)
        }
        .opacity(viewModel.currentStep != .first ? 1.0 : 0.0)
        .animation(.easeOut, value: viewModel.currentStep)
    }
    
    private var cards: some View {
        Text("TODO")
            .frame(maxHeight: .infinity)
    }
    
    private var pageIndicator: some View {
        HStack {
            ForEach(OnboardingViewModel.Step.allCases.indices, id: \.self) { i in
                let isActive: Bool = viewModel.currentStep.rawValue == i
                
                Circle()
                    .fill(isActive ? .white : .gray)
                    .frame(width: 7, height: 7)
                    .scaleEffect(isActive ? 1.1 : 1.0)
            }
        }
        .animation(.interactiveSpring, value: viewModel.currentStep)
        .padding(.vertical)
    }
    
    private var nextButton: some View {
        CapsuleButton(text: "Next") {
            viewModel.nextStepTapped()
        }
    }
    
    @ViewBuilder
    private var skipButton: some View {
        let show: Bool = viewModel.currentStep != .first && viewModel.currentStep != .fourth
        
        Button {
            viewModel.skipButtonTapped()
        } label: {
            Text("Skip")
                .font(.subheadline.weight(.semibold))
                .foregroundStyle(.white.opacity(0.8))
        }
        .buttonStyle(.interactive)
        .opacity(show ? 1.0 : 0.0)
        .animation(.easeOut, value: show)
        .padding(.top, 5)
    }
}

#Preview {
    OnboardingView()
}
