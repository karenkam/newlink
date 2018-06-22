//
//  AddNamePhotoViewController.swift
//  CIS55Project_NewLink
//
//  Created by Karen Jin on 6/12/18.
//  Copyright © 2018 DeAnza. All rights reserved.
//

import UIKit
import MobileCoreServices
import AVFoundation
import Photos
import Firebase

class AddNamePhotoViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    let databaseRef = Database.database().reference();
    
    var newPic : Bool?
    
    @IBOutlet var imageView: UIImageView!
    
    @IBOutlet var addPicButton: UIButton!
    
    
    @IBOutlet var addPicLabel: UILabel!
    
    @IBOutlet var firstNameTextField: UITextField!
    
    @IBOutlet var lastNameTextField: UITextField!
    
    @IBOutlet var namePhotoContinue: UIButton!
    
    //    @IBOutlet weak var imageView: UIImageView!
//
//    @IBOutlet weak var addPicLabel: UILabel!
//    @IBOutlet weak var addPicButton: UIButton!
    
    @IBAction func addPhotoTapped(_ sender: Any) {
        let pickImageAlert = UIAlertController(title: "Select Image From", message: "", preferredStyle: .actionSheet)
        let cameraAction = UIAlertAction(title: "Camera", style: .default) {(action) in
            if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.camera){
                let imagePicker = UIImagePickerController()
                imagePicker.delegate = self
                imagePicker.sourceType = UIImagePickerControllerSourceType.camera
                imagePicker.mediaTypes = [kUTTypeImage as String]
                imagePicker.allowsEditing = false
                self.present(imagePicker,animated: true,completion: nil)
                self.newPic = true
            }
        }
        let cameraRollAction = UIAlertAction(title:"Photo Library", style:.default) {(action) in
            if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.photoLibrary){
                let imagePicker = UIImagePickerController()
                imagePicker.delegate = self
                imagePicker.sourceType = UIImagePickerControllerSourceType.photoLibrary
                imagePicker.mediaTypes = [kUTTypeImage as String]
                imagePicker.allowsEditing = false
                self.present(imagePicker,animated: true,completion: nil)
                self.newPic = false
            }
        }
        pickImageAlert.addAction(cameraAction)
        pickImageAlert.addAction(cameraRollAction)
        self.present(pickImageAlert, animated: true)
    }
    
    @IBAction func namePhotoContinueTapped(_ sender: Any) {
        
        let firstName = firstNameTextField.text!
        let lastName = lastNameTextField.text!
        
        let userUID = (Auth.auth().currentUser?.uid)!
        let path = userUID + "profilePic"
        let storageRef = Storage.storage().reference(withPath: path)
//        let uploadMetadata = StorageMetadata()
//        uploadMetadata.contentType = "image/jpg"
//        let imageData = imageView.image as! Data
//        let uploadTask = storageRef.putData(imageData, metadata: uploadMetadata) {(metadata, error) in
//            if (error != nil) {
//                print("Upload error \(error?.localizedDescription)")
//            } else {
//                self.databaseRef.child("Connections").child((Auth.auth().currentUser?.uid)!).updateChildValues([Constants.DOWNLOADURL: metadata.downloadURL()])
//            }
//        }
        
        
        if let uploadData = UIImageJPEGRepresentation(imageView.image!, 0.5) {
            storageRef.putData(uploadData, metadata: nil, completion: { (metadata, error) in
                if error != nil{
                    print(error)
                    return
                }

                metadata?.storageReference?.downloadURL(completion: { (url, error) in
                    if let downloadURL = url?.absoluteString {
                        print (downloadURL, "#######downloadurl#######")
                        self.databaseRef.child("Connections").child((Auth.auth().currentUser?.uid)!).updateChildValues([Constants.DOWNLOADURL: downloadURL])
                    }
                })

                print (metadata)
            })
        }
        self.databaseRef.child("Connections").child((Auth.auth().currentUser?.uid)!).updateChildValues([Constants.FIRST_NAME: firstName, Constants.LAST_NAME: lastName, Constants.DOWNLOADURL: path], withCompletionBlock: { (error, ref) in
            if error.self != nil {
                print(error)
                return
            }
        })
        performSegue(withIdentifier: "GoToSetCompanyLocation", sender: self)
        
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupAddTarget()
        //        companyTitLocContinueBtnOutlet.layer.borderWidth = 1 // button outline
        namePhotoContinue.layer.borderColor = UIColor.darkGray.cgColor // button outline color
        //        companyTitLocContinueBtnOutlet.layer.cornerRadius = 5 // button rectangle 圆角
        namePhotoContinue.layer.cornerRadius = namePhotoContinue.frame.size.height / 2 // button 椭圆
        namePhotoContinue.layer.masksToBounds = true
        
        //        view.setGradientBackground(colorOne: Colors.veryDarkGrey, colorTwo: Colors.green) // Grandient Background
        namePhotoContinue.setGradientBackground(colorOne: Colors.newlineGreen, colorTwo: Colors.newlineBlue)
        
        
        
        
        
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        let mediaType = info[UIImagePickerControllerMediaType] as! NSString
        if mediaType.isEqual(to: kUTTypeImage as String){
            let image = info[UIImagePickerControllerOriginalImage] as! UIImage
            imageView.image = image
            
            if newPic == true {
                UIImageWriteToSavedPhotosAlbum(image, self, #selector(imageError),nil)
                
            }
        }
        addPicLabel.isHidden = true
        addPicButton.alpha = 0.5
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc func imageError(image: UIImage, didFinishSavingWithError error: NSErrorPointer, contextInfo: UnsafeRawPointer){
        if error != nil {
            let alert = UIAlertController(title: "Save Failed", message: "Failed to save image", preferredStyle: .alert)
            let cancelAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
            alert.addAction(cancelAction)
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        self.dismiss(animated: true, completion: nil)
        
    }
    
    func setupAddTarget(){
        namePhotoContinue.isHidden = true
        firstNameTextField.addTarget(self, action: #selector(fieldNotEmpty), for: .editingChanged)
        lastNameTextField.addTarget(self, action: #selector(fieldNotEmpty), for: .editingChanged)
//        imageView.addTarget(self, action: #selector(fieldNotEmpty), for: .editingChanged)
    }
    
    @objc func fieldNotEmpty(){
        
        guard
            let fname = firstNameTextField.text, !fname.isEmpty,
            let lname = lastNameTextField.text, !lname.isEmpty
//            let image = self.imageView.image, !image.is
        
        
        
        else {
            self.namePhotoContinue.isHidden = true
            return
        }
        self.namePhotoContinue.isHidden = false
    }
    
    @IBAction func Logout(_ sender: Any) {
        if AuthProvider.Instance.logOut() {
            dismiss(animated: true, completion: nil)
        }
    }
    
    
    
    
    
    
    
    
}
