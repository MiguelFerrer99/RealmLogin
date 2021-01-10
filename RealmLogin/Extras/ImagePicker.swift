//
//  ImagePicker.swift
//  RealmLogin
//
//  Created by Miguel Ferrer Fornali on 09/01/2021.
//

import Foundation
import SwiftUI

class ImagePickerCoordinator: NSObject, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    
    @Binding var selectedImage:UIImage?
    @Binding var isPresented:Bool
    @Binding var photoIsSelected:Bool
    
    init(selectedImage: Binding<UIImage?>, isPresented: Binding<Bool>, photoIsSelected: Binding<Bool>) {
        _selectedImage = selectedImage
        _isPresented = isPresented
        _photoIsSelected = photoIsSelected
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let uiImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            selectedImage = uiImage
            photoIsSelected = true
            isPresented = false
        }
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        isPresented = false
    }
}

struct ImagePicker: UIViewControllerRepresentable {
    
    @Binding var selectedImage:UIImage?
    @Binding var isPresented:Bool
    @Binding var photoIsSelected:Bool
    var sourceType:UIImagePickerController.SourceType = .camera
    typealias UIViewControllerType = UIImagePickerController
    typealias Coordinator = ImagePickerCoordinator
    
    func updateUIViewController(_ uiViewController: UIImagePickerController, context: UIViewControllerRepresentableContext<ImagePicker>) {
    }
    
    func makeCoordinator() -> ImagePicker.Coordinator {
        return ImagePickerCoordinator(selectedImage: $selectedImage, isPresented: $isPresented, photoIsSelected: $photoIsSelected)
    }
    
    func makeUIViewController(context: UIViewControllerRepresentableContext<ImagePicker>) -> UIImagePickerController {
        let picker = UIImagePickerController()
        picker.sourceType = sourceType
        picker.delegate = context.coordinator
        return picker
    }
}
