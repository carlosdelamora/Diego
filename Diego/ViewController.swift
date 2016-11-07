//
//  ViewController.swift
//  Diego
//
//  Created by Carlos De la mora on 11/5/16.
//  Copyright © 2016 Carlos De la mora. All rights reserved.
//
import Foundation
import UIKit

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
    

}

