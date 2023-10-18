//
//  ResultView.swift
//  SkinDetect
//
//  Created by Alin Petrus on 11.10.2023.
//

import SwiftUI

struct ResultView: View {
    let result: SkinNightmarePredictor.QualificationResult
    
    var body: some View {
        switch result {
        case .noImage:
            Text("Please provide an image for a skin condition")
        case .noMatch:
            Text("Could not identify skin condition")
        case .identified(let condition):
            Form {
                Section {
                    HStack {
                        Text("Condition:")
                        Text(condition)
                    }
                    HStack {
                        Image("wiki")
                            .resizable()
                            .frame(width: 40, height: 40)
                        Text("Wiki:")
                        Link(condition, destination: URL(string: "https://en.wikipedia.org/wiki/\(condition.replacingOccurrences(of: " ", with: "_"))")!)
                    }
                    HStack {
                        Image("google")
                            .resizable()
                            .frame(width: 40, height: 40)
                        Text("Google:")
                        Link(condition, destination: URL(string: "https://www.google.com/search?q=\(condition.replacingOccurrences(of: " ", with: "_"))")!)
                    }
                }
                .listRowBackground(Color.green)
                .listRowSeparatorTint(.white)
            }
            .background(Color.clear)
            .foregroundColor(.white)
            .scrollContentBackground(.hidden)
        }
    }
}
