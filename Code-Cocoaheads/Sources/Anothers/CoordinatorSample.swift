//
//  CoordinatorSample.swift
//  Code-Cocoaheads
//
//  Created by marcos.felipe.souza on 23/07/22.
//

import PhotosUI
import SwiftUI

/// Paul Hudson Code
struct ImagePicker: UIViewControllerRepresentable {
    
    @Binding var image: Image?
    
    func makeUIViewController(context: Context) -> PHPickerViewController {
        var config = PHPickerConfiguration(photoLibrary: PHPhotoLibrary.shared())
        config.filter = .images

        let picker = PHPickerViewController(configuration: config)
        picker.delegate = context.coordinator
        return picker
    }

    func updateUIViewController(_ uiViewController: PHPickerViewController, context: Context) {
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    class Coordinator: NSObject, PHPickerViewControllerDelegate {
        
        var parent: ImagePicker
        
        init(_ parent: ImagePicker) {
            self.parent = parent
        }
        
        /// Delegate se o user selecionando imagem ou cancelando.
        func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
            picker.dismiss(animated: true)
            guard let provider = results.first?.itemProvider else { return }
            if provider.canLoadObject(ofClass: UIImage.self) {
                provider.loadObject(ofClass: UIImage.self) { image, _ in
                    if let uiImage = image as? UIImage {
                        self.parent.image = Image(uiImage: uiImage)
                    }
                }
            }
        }
    }
}
