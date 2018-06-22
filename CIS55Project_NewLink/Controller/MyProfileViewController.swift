//
//  MyProfileViewController.swift
//  CIS55Project_NewLink
//
//  Created by Karen Jin on 6/18/18.
//  Copyright © 2018 DeAnza. All rights reserved.
//

import UIKit
import Firebase

class MyProfileViewController: UIViewController{
    
    

    var ref = Database.database().reference()
    let userID = Auth.auth().currentUser?.uid
    
    @IBOutlet var detailProflePic: UIImageView!
    @IBOutlet var f_name: UILabel!

    @IBOutlet var l_name: UILabel!
    @IBOutlet var jobtitle: UILabel!

    @IBOutlet var company: UILabel!
    @IBOutlet var location: UILabel!
    @IBOutlet var about_me: UITextView!

    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.about_me.allowsEditingTextAttributes = false
        self.about_me.backgroundColor = UIColor.clear
        self.view.backgroundColor = UIColor(patternImage: #imageLiteral(resourceName: "newLinkConnectionsBG2"))
        print(userID!, "my profile")
        ref.child("Connections").child(self.userID!).observeSingleEvent(of: .value, with: {(snapshot) in

            let value = snapshot.value as? NSDictionary
            self.f_name.text = value?[Constants.FIRST_NAME] as? String ?? ""
            self.l_name.text = value?[Constants.LAST_NAME] as? String ?? ""
            self.jobtitle.text = value?[Constants.TITLE] as? String ?? ""
            self.company.text = value?[Constants.COMPANY] as? String ?? ""
            self.location.text = value?[Constants.LOCATION] as? String ?? ""
            self.about_me.text = value?[Constants.ABOUT_ME] as? String ?? ""
            let imageRef = Storage.storage().reference().child(value?[Constants.DOWNLOADURL] as! String)
            self.detailProflePic.sd_setImage(with: imageRef)
        
        }) { (error) in
            print(error.localizedDescription, "error in my profile")

        }


    }
    
    @IBAction func LogOut(_ sender: Any) {
        do {
            try Auth.auth().signOut()
        }
        catch let logoutError {
            print (logoutError)
        }
    }
    
    
    @IBAction func editProfile(_ sender: Any) {
        performSegue(withIdentifier: "EditProfile", sender: self)
    }
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    



} // class
