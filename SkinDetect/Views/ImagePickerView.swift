//
//  ImagePickerView.swift
//  SkinDetect
//
//  Created by Alin Petrus on 10.10.2023.
//

import UIKit
import SwiftUI

@objc
private class ImagePickerViewModel: NSObject, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    var didSelectBlock: ((_ image: UIImage?) -> Void)?
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let selectedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage

        didSelectBlock?(selectedImage)
    }
    
}

struct ImagePickerView: UIViewControllerRepresentable {

    @Environment(\.dismiss) private var dismiss
    @Binding var selectedImage: UIImage?
    var sourceType: UIImagePickerController.SourceType
    private let viewModel: ImagePickerViewModel = ImagePickerViewModel()
        
    func makeUIViewController(context: Context) -> UIImagePickerController {
        let imagePicker = UIImagePickerController()
        imagePicker.sourceType = self.sourceType
        
        imagePicker.delegate = viewModel
        
        viewModel.didSelectBlock = { image in
            selectedImage = image
            dismiss()
        }
        
        return imagePicker
    }

    func updateUIViewController(_ uiViewController: UIImagePickerController, context: Context) {

    }
}
