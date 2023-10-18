//
//  SkinNightmarePredictor.swift
//  SkinDetect
//
//  Created by Alin Petrus on 10.10.2023.
//

import CoreImage
import CoreML
import Foundation
import UIKit
import Vision

final class SkinNightmarePredictor {
    
    // MARK: - Qualification Result
    
    enum QualificationResult {
        case noImage
        case noMatch
        case identified(String)
    }
    
    
    // MARK: - Properties
    
    private let model: VNCoreMLModel
    
    // MARK: - Initializer
    
    init() {
        let defaultConfig = MLModelConfiguration()
        
        do {
            // Create an instance of the image classifier's wrapper class.
            let imageClassifierWrapper = try SkinNightmare(configuration: defaultConfig)
            // Create the model
            let model = try VNCoreMLModel(for: imageClassifierWrapper.model)
            
            self.model = model
        } catch {
            fatalError("Cannot load model")
        }
    }
    
    // MARK: - Functions
    
    func qualify(image: UIImage?) async throws -> QualificationResult {
        try await withCheckedThrowingContinuation { continuation in
            guard let image, let cgImage = image.cgImage else {
                continuation.resume(returning: .noImage)
                
                return
            }
            
            let orientation = CGImagePropertyOrientation(rawValue: UInt32(image.imageOrientation.rawValue))
            
            checkImage(cgImage, orientation: orientation ?? .up) { result in
                switch result {
                case .success(let matches):
                    if let result = matches.first {
                        continuation.resume(returning: .identified(result.identifier))
                    } else {
                        continuation.resume(returning: .noMatch)
                    }
                case .failure(let error):
                    continuation.resume(throwing: error)
                }
            }
        }
    }
    
    // MARK: - Private
    
    private func checkImage(_ image: CGImage, orientation: CGImagePropertyOrientation, completion: @escaping ((Result<[VNClassificationObservation], Error>) -> Void)) {
        let imageClassificationRequest = VNCoreMLRequest(model: self.model) { request, error in
            guard let results = request.results else {
                completion(.success([]))
                
                return
            }
            
            let classifications = results as? [VNClassificationObservation] ?? []
            
            completion(.success(classifications))
        }
        
        imageClassificationRequest.imageCropAndScaleOption = .scaleFit
        #if targetEnvironment(simulator)
        imageClassificationRequest.usesCPUOnly = true
        #endif
        
        let handler = VNImageRequestHandler(cgImage: image, orientation: orientation)
        let requests: [VNRequest] = [imageClassificationRequest]
        
        // Start the image classification request.
        do {
            try handler.perform(requests)
        } catch {
            print(error)
        }
    }
    
}
