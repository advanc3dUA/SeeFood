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
        }
        
        imagePicker.dismiss(animated: true)
    }
}

