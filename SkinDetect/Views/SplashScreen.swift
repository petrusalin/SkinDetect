//
//  SplashScreen.swift
//  SkinDetect
//
//  Created by Alin Petrus on 13.10.2023.
//

import SwiftUI

struct SplashScreen: View {
    var body: some View {
        VStack {
            Spacer()
            Image(systemName: "cross.fill")
            Text("Skin Nightmare")
            Spacer()
        }
        .frame(maxWidth: .infinity)
        .backgroundGradient()
        .font(.largeTitle)
        .tint(.green)
    }
}

#Preview {
    SplashScreen()
}
