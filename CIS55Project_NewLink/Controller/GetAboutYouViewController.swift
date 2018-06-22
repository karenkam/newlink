//
//  GetAboutYouViewController.swift
//  CIS55Project_NewLink
//
//  Created by WONG YING TUNG on 6/14/18.
//  Copyright © 2018 DeAnza. All rights reserved.
//

import UIKit
import Firebase

class GetAboutYouViewController: UIViewController, UITextViewDelegate {

    @IBOutlet var introduceYourself: UITextView!
    @IBOutlet var finishBtn: UIButton!
    let databaseRef = Database.database().reference();
    

    

    
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        self.introduceYourself.delegate = (self as UITextViewDelegate)
        self.finishBtn.isHidden = true
        //setupAddTarget()
        finishBtn.layer.borderColor = UIColor.darkGray.cgColor // button outline color
        finishBtn.layer.cornerRadius = finishBtn.frame.size.height / 2 // button 椭圆
        finishBtn.layer.masksToBounds = true
        finishBtn.setGradientBackground(colorOne: Colors.newlineGreen, colorTwo: Colors.newlineBlue)
        
    
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func FinishSignUp(_ sender: Any) {
                let aboutMe = introduceYourself.text!
        
                self.databaseRef.child("Connections").child((Auth.auth().currentUser?.uid)!).updateChildValues(["aboutMe" : aboutMe] ,withCompletionBlock: { (error, ref) in
                    if error != nil {
                        print(error)
                        return
                    }
                })
        
                performSegue(withIdentifier: "SignUpToConnections", sender: self)
    }
    
    @IBAction func logout(_ sender: Any) {
        if AuthProvider.Instance.logOut() {
            dismiss(animated: true, completion: nil)
        }
    }
    
    
    
    
    func textViewDidChange(_ textView: UITextView) {
        self.finishBtn.isHidden = false
    }




}
