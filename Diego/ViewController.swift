//
//  ViewController.swift
//  Diego
//
//  Created by Carlos De la mora on 11/5/16.
//  Copyright © 2016 Carlos De la mora. All rights reserved.
//
import Foundation
import UIKit
import TesseractOCR

class ViewController: UIViewController, UITextViewDelegate,UINavigationControllerDelegate, UIImagePickerControllerDelegate {

    var activityIndicator:UIActivityIndicatorView!
    
    @IBOutlet weak var textView: UITextView!
    
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    @IBAction func UploadPictureButton(_ sender: Any) {
        //create an UIAlert
        let imagePickerActionSheet = UIAlertController(title: "Upload Photo",
                                                       message: nil, preferredStyle: .actionSheet)
        // check if we have a camera and if we do, allow the user to take a picture and use it
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            let cameraButton = UIAlertAction(title: "Take Photo",
                                             style: .default) { (alert) -> Void in
                                                let imagePicker = UIImagePickerController()
                                                imagePicker.delegate = self
                                                imagePicker.sourceType = .camera
                                                self.present(imagePicker,
                                                                           animated: true,
                                                                           completion: nil)
            }
            imagePickerActionSheet.addAction(cameraButton)
        }
        // 4
        let libraryButton = UIAlertAction(title: "Choose Existing",
                                          style: .default) { (alert) -> Void in
                                            let imagePicker = UIImagePickerController()
                                            imagePicker.delegate = self
                                            imagePicker.sourceType = .photoLibrary
                                            self.present(imagePicker,
                                                                       animated: true,
                                                                       completion: nil)
        }
        imagePickerActionSheet.addAction(libraryButton)
        // 5
        let cancelButton = UIAlertAction(title: "Cancel",
                                         style: .cancel) { (alert) -> Void in
        }
        imagePickerActionSheet.addAction(cancelButton)
        // 6
        present(imagePickerActionSheet, animated: true,
                              completion: nil)
        
    }
    
    
    
    func addActivityIndicator() {
        activityIndicator = UIActivityIndicatorView(frame: view.bounds)
        activityIndicator.activityIndicatorViewStyle = .whiteLarge
        activityIndicator.backgroundColor = UIColor(white: 0, alpha: 0.25)
        activityIndicator.startAnimating()
        view.addSubview(activityIndicator)
    }
    
    func removeActivityIndicator() {
        activityIndicator.removeFromSuperview()
        activityIndicator = nil
    }
    
    //scale the picture
    func scaleImage(image: UIImage, maxDimension: CGFloat) -> UIImage {
        
        var scaledSize = CGSize(width: maxDimension, height: maxDimension)
        var scaleFactor: CGFloat
        
        if image.size.width > image.size.height {
            scaleFactor = image.size.height / image.size.width
            scaledSize.width = maxDimension
            scaledSize.height = scaledSize.width * scaleFactor
        } else {
            scaleFactor = image.size.width / image.size.height
            scaledSize.height = maxDimension
            scaledSize.width = scaledSize.height * scaleFactor
        }
        
        UIGraphicsBeginImageContext(scaledSize)
        image.draw(in: CGRect(origin: CGPoint(x:0,y:0), size: CGSize(width:scaledSize.width, height: scaledSize.height)))
        let scaledImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        // TODO: write a guard statement to make sure that scaledImage is not nil
        return scaledImage!
    }
    
    func imagePickerController(_ picker: UIImagePickerController,
                               didFinishPickingMediaWithInfo info: [String : Any]) {
        let selectedPhoto = info[UIImagePickerControllerOriginalImage] as! UIImage
        let scaledImage = scaleImage(image: selectedPhoto, maxDimension: 640)
        
        addActivityIndicator()
        
        dismiss(animated: true, completion: {
            self.performImageRecognition(image: scaledImage)
        })
    }
    
    
    
   
    func performImageRecognition(image: UIImage) {
        // 1
        let tesseract = G8Tesseract(language: "eng+fra")
        // 2
        
        // 3
        tesseract?.engineMode = .tesseractCubeCombined
        // 4
        tesseract?.pageSegmentationMode = .auto
        // 5
        tesseract?.maximumRecognitionTime = 60.0
        // 6
        tesseract?.image = image.g8_blackAndWhite()
        tesseract?.recognize()
        // 7
        textView.text = tesseract?.recognizedText
        textView.isEditable = true
        // 8
        removeActivityIndicator()
    }

}

