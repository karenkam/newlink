//
//  SearchResultDetailViewController.swift
//  CIS55Project_NewLink
//
//  Created by WONG YING TUNG on 6/20/18.
//  Copyright © 2018 DeAnza. All rights reserved.
//

import UIKit
import Firebase

class SearchResultDetailViewController: UIViewController {

    @IBOutlet var resultDetailImage: UIImageView!
    @IBOutlet var resultDetailFullName: UILabel!
    @IBOutlet var resultDetailJobTitle: UILabel!
    @IBOutlet var resultDetailLocation: UILabel!
    @IBOutlet var resultDetailCompany: UILabel!
    @IBOutlet var resultDetailAboutMe: UITextView!
    
    var searchDetail: Connection!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor(patternImage: #imageLiteral(resourceName: "newLinkConnectionsBG2"))
        self.resultDetailFullName.text = self.searchDetail.getName()
        self.resultDetailJobTitle.text = self.searchDetail.getJob()
        self.resultDetailCompany.text = self.searchDetail.getCompany()
        self.resultDetailLocation.text = self.searchDetail.getLocation()
        self.resultDetailAboutMe.text = self.searchDetail.getAboutMe()
        self.resultDetailImage.sd_setImage(with: self.searchDetail.getImage() as! StorageReference)
        self.resultDetailAboutMe.backgroundColor = UIColor.clear

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
