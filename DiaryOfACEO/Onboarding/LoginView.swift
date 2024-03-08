//
//  LoginView.swift
//  DiaryOfACEO
//
//  Created by Sidney Sadel on 3/7/24.
//

import SwiftUI

struct LoginView: View {
    @StateObject private var viewModel: LoginViewModel = .init()
    
    var body: some View {
        
        VStack(spacing: 16) {
            Spacer()
            
            Text("Create an account or sign in to save and see your conversation history")
                .font(.title.weight(.bold))
                .multilineTextAlignment(.center)
                .padding(.bottom)
            CapsuleButton(text: "Continue with Google", imageSource: .resource(.googleLogo), widthMode: .maxWidth) {
                //
            }
            CapsuleButton(text: "Continue with Apple", imageSource: .resource(.appleLogo), widthMode: .maxWidth) {
                //
            }
            CapsuleButton(text: "Continue with Facebook", imageSource: .resource(.facebookLogo), widthMode: .maxWidth) {
                //
            }
            
            Spacer()
            
            Button {
                viewModel.logIn()
            } label: {
                Text("Skip")
                    .font(.subheadline.weight(.semibold))
                    .foregroundStyle(.white.opacity(0.8))
            }
            .buttonStyle(.interactive)
            .padding()
        }
        .padding()
    }
}

#Preview {
    LoginView()
}
