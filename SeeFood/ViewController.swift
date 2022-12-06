//
//  ViewController.swift
//  SeeFood
//
//  Created by Yuriy Gudimov on 06.12.2022.
//

import UIKit
import CoreML
import Vision

class ViewController: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    
    @IBOutlet weak var photoImageView: UIImageView!
    private let imagePicker = UIImagePickerController()
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        imagePickerConfiguration()
        
    }
    
    fileprivate func imagePickerConfiguration() {
        
        imagePicker.delegate = self
        imagePicker.sourceType = .camera
        imagePicker.allowsEditing = false
    }
    
    @IBAction func cameraPressed(_ sender: UIBarButtonItem) {
        
        present(imagePicker, animated: true)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        if let userSelectedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            photoImageView.image = userSelectedImage
            
            guard let ciImage = CIImage(image: userSelectedImage) else {
                fatalError("Couldn't convert picked image to CIImage")
            }
            
            detect(image: ciImage)
            
        }
        
        imagePicker.dismiss(animated: true)
    }
    
    private func detect(image: CIImage) {
        
        let mLModelConfiguration = MLModelConfiguration()
        guard let model = try? VNCoreMLModel(for: Inceptionv3(configuration: mLModelConfiguration).model) else {
            fatalError("Loading CoreML failed")
        }
        
        let request = VNCoreMLRequest(model: model) { request, error in
            guard let results = request.results as? [VNClassificationObservation] else {
                fatalError("Unable to get results from ML model")
            }
            print(results)
        }
        
        let handler = VNImageRequestHandler(ciImage: image)
        do {
            try handler.perform([request])
        } catch {
            fatalError(error.localizedDescription)
        }
    }
}

