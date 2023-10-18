//
//  PickerControlView.swift
//  SkinDetect
//
//  Created by Alin Petrus on 13.10.2023.
//

import SwiftUI

struct PickerControlView: View {
    @Binding var sheet: PhotoSheetType?
    @Binding var result: SkinNightmarePredictor.QualificationResult?
    
    var body: some View {
        VStack {
            Text("Provide a skin picture:")
                .foregroundStyle(.white)
                .multilineTextAlignment(.center)
                .font(.title)
            Spacer()
                .frame(height: 10)
            HStack {
                Spacer()
                Button(action: {
                    self.result = nil
                    self.sheet = .camera
                }, label: {
                    Image(systemName: "camera")
                        .font(.largeTitle)
                })
                Spacer(minLength: 10)
                Button(action: {
                    self.result = nil
                    self.sheet = .library
                }, label: {
                    Image(systemName: "photo")
                        .font(.largeTitle)
                })
                Spacer()
            }
        }
    }
}
