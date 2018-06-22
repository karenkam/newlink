//
//  Connection.swift
//  CIS55Project_NewLink
//
//  Created by Tony King on 6/13/18.
//  Copyright © 2018 DeAnza. All rights reserved.
//

import Foundation
import FirebaseStorage


class Connection {
    
    private var _fname = ""
    private var _lname = ""
    private var _id = ""
    
    private var _company = ""
    private var _location = ""
    private var _jobTitle = ""
    private var _aboutMe = ""
    private var _photoPath = ""
    
    
    init(id: String, firstName: String, lastName: String,company: String, location: String, jobTitle: String, aboutMe: String, photoURL: String){
        _id = id;
        _fname = firstName
        _lname = lastName
        _company = company
        _location = location
        _jobTitle = jobTitle
        _aboutMe = aboutMe
        _photoPath = photoURL
    }
    
    
    func getName() -> String {
        return _fname + " " + _lname
    }
    
    func getLocation() -> String {
        return _location
    }
    
    func getCompany() -> String {
        return _company
    }
    
    func getJob() -> String {
        return _jobTitle
    }
    func getFirstName() -> String {
        return _fname
    }
    func getLastName() -> String {
        return _lname
    }
    func getAboutMe() -> String {
        return _aboutMe
    }
    func getImage() -> AnyObject {
        
        // Reference to an image file in Firebase Storage
        
        let imageRef = Storage.storage().reference().child(_photoPath) 
        
        // UIImageView in your ViewController
        //let imageView = UIImageView()
        
        // Placeholder image
        //let placeholderImage = UIImage(named: "placeholder.jpg")
        
        // Load the image using SDWebImage
        //imageView.sd_setImage(with: imageRef)
        //imageView.sd_setImage(with: imageRef, placeholderImage: placeholderImage)
        
        
//        let imagePath = _id + "profilePic"
//        print("imagePath: ",imagePath)
//        let imageRef = Storage.storage().reference().child(imagePath)
//        var profileImage = UIImage()
//        // Download in memory with a maximum allowed size of 1MB (1 * 1024 * 1024 bytes)
//        imageRef.getData(maxSize: 1 * 1028 * 1028) { data, error in
//            if let error = error {
//                print(error, "image error")
//                return
//            } else {
//                // Data for "images/island.jpg" is returned
//                profileImage = UIImage(data: data!)!
//
//            }
//
//        }
//        return profileImage
        return imageRef
    }
    func getImagePath()->String{
         return _photoPath
    }
}





