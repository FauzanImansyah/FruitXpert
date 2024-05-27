//
//  ImagePicker.swift
//  FruitXpert2
//
//  Created by Fauzan Imansyah on 22/05/24.
//

import SwiftUI

struct ImagePicker: UIViewControllerRepresentable {
    
    @Binding var uiImage: UIImage?
    @Binding var isPresenting: Bool
    @Binding var sourceType: UIImagePickerController.SourceType
    
    typealias UIViewControllerType = UIImagePickerController
    
    func makeUIViewController(context: Context) -> UIImagePickerController {
      let imagePicker = UIImagePickerController()
      imagePicker.sourceType = sourceType
      imagePicker.delegate = context.coordinator
      return imagePicker
    }
    
    func updateUIViewController(_ uiViewController: UIImagePickerController, context: Context) { }
    
    func makeCoordinator() -> Coordinator {
      Coordinator(self)
    }
}

    
    
    // MARK: - Coordinator class
    class Coordinator: NSObject, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
     
        let parent: ImagePicker
        
        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
          parent.uiImage = info[.originalImage] as? UIImage
          parent.isPresenting = false
        }

        func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
          parent.isPresenting = false
        }
        
        init(_ imagePicker: ImagePicker) {
          self.parent = imagePicker
        }
    
}
