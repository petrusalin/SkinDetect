//
//  BackgroundGradientModifier.swift
//  SkinDetect
//
//  Created by Alin Petrus on 13.10.2023.
//

import SwiftUI

struct BackgroundGradientModifier: ViewModifier {
    
    func body(content: Content) -> some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: [.green, .blue]),
                                       startPoint: .top,
                                       endPoint: .bottom)
            .ignoresSafeArea()
            content
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}

extension View {
    
    func backgroundGradient() -> some View {
        modifier(BackgroundGradientModifier())
    }
    
}
