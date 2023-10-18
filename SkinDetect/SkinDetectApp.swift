//
//  SkinDetectApp.swift
//  SkinDetect
//
//  Created by Alin Petrus on 10.10.2023.
//

import SwiftUI

@main
struct SkinDetectApp: App {
    var body: some Scene {
        WindowGroup {
            CaptureView()
                .tint(.white)
        }
    }
}
