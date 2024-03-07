//
//  ButtonStyle+Ex.swift
//  Readit Narrator
//
//  Created by Sidney Sadel on 7/26/23.
//

import SwiftUI

extension ButtonStyle where Self == InteractiveButtonStyle {
    static func interactive(scale: CGFloat = 0.925, shouldOpacity: Bool = false, timeoutDuration: TimeInterval? = nil) -> InteractiveButtonStyle {
        return InteractiveButtonStyle(scale: scale, shouldOpacity: shouldOpacity, timeoutDuration: timeoutDuration)
    }
    
    static var interactive: InteractiveButtonStyle {
        return InteractiveButtonStyle()
    }
}

extension ButtonStyle where Self == NoButtonStyle {
    static var none: NoButtonStyle {
        return NoButtonStyle()
    }
}

extension ButtonStyle where Self == TimeoutButtonStyle {
    static func timeout(duration: TimeInterval) -> TimeoutButtonStyle {
        return TimeoutButtonStyle(timeoutDuration: duration)
    }
    
    static var timeout: TimeoutButtonStyle {
        return TimeoutButtonStyle(timeoutDuration: 1.0)
    }
}

struct NoButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .contentShape(Rectangle())
    }
}

struct TimeoutButtonStyle: ButtonStyle {
    let timeoutDuration: TimeInterval
    @State private var isTimeoutEnabled: Bool = false
    
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .opacity(configuration.isPressed ? 0.85 : 1.0)
            .contentShape(Rectangle())
            .allowsHitTesting(!isTimeoutEnabled)
            .onChange(of: configuration.isPressed) { b in
                guard !b else { return }
                
                isTimeoutEnabled = true
                DispatchQueue.main.asyncAfter(deadline: .now() + timeoutDuration) {
                    isTimeoutEnabled = false
                }
            }
    }
}

struct InteractiveButtonStyle: ButtonStyle {
    @State private var isPressed: Bool = false
    @State private var isLongPress: Bool = false
    @State private var isLongPressTimer: Timer?
    @State private var isTimeoutActive: Bool = false
    
    private let peakScaleValue: CGFloat
    private let shouldOpacity: Bool
    private let timeoutDuration: TimeInterval?
    
    private var scaleValue: CGFloat {
        isPressed ? peakScaleValue : 1.0
    }
    
    init(scale: CGFloat = 0.925, shouldOpacity: Bool = false, timeoutDuration: TimeInterval? = nil) {
        self.peakScaleValue = scale
        self.shouldOpacity = shouldOpacity
        self.timeoutDuration = timeoutDuration
    }
    
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .scaleEffect(scaleValue)
            .animation(.easeOut(duration: 0.12), value: isPressed)
            .opacity(shouldOpacity ? (configuration.isPressed ? 0.8 : 1.0) : 1.0)
            .contentShape(RoundedRectangle(cornerRadius: 2))
            .allowsHitTesting(!isTimeoutActive)
            .onChange(of: configuration.isPressed) { b in
                if b {
                    onPress()
                } else {
                    onRelease()
                }
            }
    }
    
    private func onPress() {
        withAnimation { isPressed = true }
        isLongPressTimer = Timer.scheduledTimer(withTimeInterval: 0.1, repeats: false) { _ in
            isLongPress = true
        }
    }
    
    private func onRelease() {
        isLongPressTimer?.invalidate()
        if !isLongPress {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.12) {
                withAnimation { isPressed = false }
            }
        } else {
            withAnimation { isPressed = false }
        }
        isLongPress = false
        
        guard let timeoutDuration = timeoutDuration else { return }
        isTimeoutActive = true
        DispatchQueue.main.asyncAfter(deadline: .now() + timeoutDuration) {
            isTimeoutActive = false
        }
    }
}
