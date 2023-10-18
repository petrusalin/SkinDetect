//
//  PhotoSheetType.swift
//  SkinDetect
//
//  Created by Alin Petrus on 11.10.2023.
//

import Foundation
import UIKit

enum PhotoSheetType: Identifiable {
    case camera
    case library
    
    var id: String {
        switch self {
        case .camera:
            return "cameraSourceId"
        case .library:
            return "librarySourceId"
        }
    }
    
    var sourcetype: UIImagePickerController.SourceType {
        switch self {
        case .camera:
            return .camera
        case .library:
            return .photoLibrary
        }
    }
}
