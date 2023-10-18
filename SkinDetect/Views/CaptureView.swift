//
//  ContentView.swift
//  SkinDetect
//
//  Created by Alin Petrus on 10.10.2023.
//

import SwiftUI

struct CaptureView: View {
    
    @State var sheet: PhotoSheetType?
    @State var image: UIImage?
    @State var isAnalyzing: Bool = false
    @State var result: SkinNightmarePredictor.QualificationResult?
    @State var predictor: SkinNightmarePredictor = SkinNightmarePredictor()
    
    var body: some View {
        NavigationStack {
            VStack {
                if let image {
                    analyseView(image: image)
                }
                if let result {
                    ResultView(result: result)
                }
                Spacer()
                PickerControlView(sheet: $sheet, result: $result)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .navigationTitle("Skin Nightmares")
            .navigationBarTitleDisplayMode(.inline)
            .disabled(isAnalyzing)
                .padding()
                .toolbar(content: {
                    if isAnalyzing {
                        ToolbarItem(placement: .topBarTrailing) {
                            ProgressView()
                                .tint(.white)
                        }
                    }
                    ToolbarItem(placement: .topBarLeading) {
                        clearButton()
                    }
                })
                .backgroundGradient()
        }
        .sheet(item: $sheet, content: { selectedSheet in
            NavigationStack {
                ImagePickerView(selectedImage: $image, sourceType: selectedSheet.sourcetype)
            }
        })
    }
    
    // MARK: - Initializer(s)
    
    init() {
        UINavigationBar.appearance().largeTitleTextAttributes = [.foregroundColor: UIColor.white]
        UINavigationBar.appearance().titleTextAttributes = [.foregroundColor: UIColor.white]
    }
    
    // MARK: - Private
    
    @ViewBuilder
    private func analyseView(image: UIImage) -> some View {
        Image(uiImage: image)
            .resizable()
            .scaledToFit()
        Button("Analyse") {
            self.isAnalyzing = true
            Task { @MainActor in
                self.result = try? await predictor.qualify(image: image)
                self.isAnalyzing = false
            }
        }
        .buttonStyle(.borderedProminent)
        .tint(.green)
    }
    
    private func clearButton() -> some View {
        Button("Clear") {
            image = nil
            result = nil
        }
    }
    
}
