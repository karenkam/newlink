//
//  EditProfileViewController.swift
//  CIS55Project_NewLink
//
//  Created by WONG YING TUNG on 6/20/18.
//  Copyright © 2018 DeAnza. All rights reserved.
//

import UIKit
import Firebase

class EditProfileViewController: UIViewController {

    @IBOutlet var editProfilePicture: UIImageView!
    @IBOutlet var editFirstN: UITextField!
    @IBOutlet var editLastN: UITextField!
    @IBOutlet var editJobT: UITextField!
    @IBOutlet var editCompany: UITextField!
    @IBOutlet var editLocation: UITextField!
    @IBOutlet var editAboutMe: UITextView!
    
    var ref = Database.database().reference()
    let userID = Auth.auth().currentUser?.uid
    
    var newFirst, newLast, newComp, newJob, newLoc, newAbout : NSString!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor(patternImage: #imageLiteral(resourceName: "newLinkConnectionsBG2"))
        ref.child("Connections").child(self.userID!).observeSingleEvent(of: .value, with: {(snapshot) in
            
            let value = snapshot.value as? NSDictionary
            self.editFirstN.text = value?[Constants.FIRST_NAME] as? String ?? ""
            self.editLastN.text = value?[Constants.LAST_NAME] as? String ?? ""
            self.editJobT.text = value?[Constants.TITLE] as? String ?? ""
            self.editCompany.text = value?[Constants.COMPANY] as? String ?? ""
            self.editLocation.text = value?[Constants.LOCATION] as? String ?? ""
            self.editAboutMe.text = value?[Constants.ABOUT_ME] as? String ?? ""
            let imageRef = Storage.storage().reference().child(value?[Constants.DOWNLOADURL] as! String)
            self.editProfilePicture.sd_setImage(with: imageRef)
            
        }) { (error) in
            print(error.localizedDescription, "error in my profile")
            
        }

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func SaveChanges(_ sender: Any) {
        newFirst = self.editFirstN.text! as NSString
        newLast = self.editLastN.text! as NSString
        newJob = self.editJobT.text! as NSString
        newComp = self.editCompany.text! as NSString
        newLoc = self.editLocation.text! as NSString
        newAbout = self.editAboutMe.text! as NSString
        
//        ref.child(Constants.CONNECTIONS).child(userID!).setValue([Constants.LAST_NAME: newLast]){
//            (error:Error?, ref:DatabaseReference) in
//            if let error = error{
//                print("Data could not be saved")
//            } else {
//                print("Data saved successfully")
//            }
//        }
        
//        let key = ref.child(Constants.CONNECTIONS).childByAutoId().key
//        let post = [Constants.FIRST_NAME: newFirst,
//                    Constants.LAST_NAME: newLast,
//                    Constants.ABOUT_ME: newAbout,
//                    Constants.COMPANY: newComp,
//                    Constants.LOCATION: newLoc,
//                    Constants.TITLE: newJob, ]
//        let childUpdates = ["/Connections/\(key)": post]
//        ref.updateChildValues(childUpdates)
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
