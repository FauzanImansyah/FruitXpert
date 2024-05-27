//
//  ImageClassifier.swift
//  FruitXpert2
//
//  Created by Fauzan Imansyah on 22/05/24.
//

import Foundation

import SwiftUI

class ImageClassifier: ObservableObject {
    @Published private var classifier = Classifier()
    
    var imageClass: String? {
        classifier.results
    }
        
    func detect(uiImage: UIImage) {
        guard let ciImage = CIImage (image: uiImage) else { return }
        classifier.detect(ciImage: ciImage)
    }
}
