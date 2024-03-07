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
    
    private var cards: some View { // TODO: use actual card scroll view
        TabView(selection: $viewModel.currentStep) {
            CardCell {
                ZStack {
                    RadialGradient(colors: [.black.opacity(0.8), .black], center: .center, startRadius: 30, endRadius: 300)
                    VStack {
                        Text("the diary of a ceo".uppercased())
                            .font(.title.weight(.semibold))
                        Text("conversation cards".uppercased())
                            .font(.title2.weight(.bold))
                    }
                    .foregroundStyle(.white)
                }
            }
            .tag(OnboardingViewModel.Step.first)
            
            CardCell {
                VStack(spacing: 30) {
                    Spacer()
                    Text("Beyond Small Talk, Diary-Style")
                        .font(.custom(.reenieBeenie, style: .largeTitle))
                    Text("Immerse in authentic conversations using The Conversation Cards, featuring questions asked by accomplished guests from The Diary Of A CEO podcast.")
                        .opacity(0.8)
                    Spacer()
                    Spacer()
                }
                .foregroundStyle(.black)
                .padding()
            }
            .tag(OnboardingViewModel.Step.second)
            
            CardCell {
                VStack(spacing: 30) {
                    Spacer()
                    Text("Prologue to Impact")
                        .font(.custom(.reenieBeenie, style: .largeTitle))
                    Text("Explore wisdom and experiences, turning each interaction into a heartfelt journey.")
                        .opacity(0.8)
                    Spacer()
                    Spacer()
                }
                .foregroundStyle(.black)
                .padding()
            }
            .tag(OnboardingViewModel.Step.third)
            
            CardCell {
                VStack(spacing: 30) {
                    Spacer()
                    Text("Embrace Shared Journeys")
                        .font(.custom(.reenieBeenie, style: .largeTitle))
                    Text("From cherished friends to newfound connections, The Conversation Cards unfold meaningful dialogues that deepen bonds and illuminate shared journeys in any setting.")
                        .opacity(0.8)
                    Spacer()
                    Spacer()
                }
                .foregroundStyle(.black)
                .padding()
            }
            .tag(OnboardingViewModel.Step.fourth)
        }
        .tabViewStyle(.page(indexDisplayMode: .never))
        .frame(maxHeight: .infinity)
        .animation(.easeOut, value: viewModel.currentStep)
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
        ZStack {
            let text: String = viewModel.currentStep == .fourth ? "Start my journey" : "Next"
            CapsuleButton(text:  text) {
                viewModel.nextStepTapped()
            }
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
