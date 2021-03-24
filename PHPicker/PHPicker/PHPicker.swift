//
//  PHPicker.swift
//  PHPicker
//
//  Created by Cédric Bahirwe on 24/03/2021.
//

import SwiftUI
import UIKit
import PhotosUI

struct PhotoPicker: UIViewControllerRepresentable {
    @Binding var isPresented: Bool
    @Binding var selectedImage: Image?
    
    var phFilter: PHPickerFilter
    
    func makeUIViewController(context: Context) -> PHPickerViewController {
        var configuration = PHPickerConfiguration(photoLibrary: PHPhotoLibrary.shared())
        
        configuration.filter = phFilter
        
        let controller = PHPickerViewController(configuration: configuration)
        controller.delegate = context.coordinator
        return controller
    }
    
    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) { }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    class Coordinator: PHPickerViewControllerDelegate {
        private let parent: PhotoPicker
        
        init(_ parent: PhotoPicker) {
            self.parent = parent
        }
        
        func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
            parent.isPresented = false
            
            if let itemProvider = results.first?.itemProvider, itemProvider.canLoadObject(ofClass: UIImage.self) {
                itemProvider.loadObject(ofClass: UIImage.self) { [weak self] uiImage, error in
                    DispatchQueue.main.async {
                        guard let self = self, let uiImage = uiImage as? UIImage else { return }
                        self.parent.selectedImage = Image(uiImage: uiImage)
                    }
                }
            }
        }
    }
}
