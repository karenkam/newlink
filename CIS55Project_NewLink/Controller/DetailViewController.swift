//
//  DetailViewController.swift
//  CIS55Project_NewLink
//
//  Created by WONG YING TUNG on 6/18/18.
//  Copyright © 2018 DeAnza. All rights reserved.
//

import UIKit
import Firebase



class DetailViewController: UIViewController {

    @IBOutlet var detailProfilePic: UIImageView!
    @IBOutlet var full_name: UILabel!
   // @IBOutlet var l_name: UILabel!
    @IBOutlet var job_title: UILabel!
    @IBOutlet var company_: UILabel!
    @IBOutlet var location_: UILabel!
    @IBOutlet var about_me: UITextView!
    
    var userDetail : Connection!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.full_name.text = self.userDetail.getName()
        //self.l_name.text = self.userDetail.getLastName()
        self.job_title.text = self.userDetail.getJob()
        self.company_.text = self.userDetail.getCompany()
        self.location_.text = self.userDetail.getLocation()
        self.about_me.text = self.userDetail.getAboutMe()
        self.view.backgroundColor = UIColor(patternImage: #imageLiteral(resourceName: "newLinkConnectionsBG2"))
        self.about_me.backgroundColor = UIColor.clear
        self.detailProfilePic.sd_setImage(with: self.userDetail.getImage() as! StorageReference)
        //self.detailProfilePic.image = self.userDetail.getImage() as! UIImage

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
