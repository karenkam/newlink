//
//  GetGenderViewController.swift
//  CIS55Project_NewLink
//
//  Created by Karen Jin on 6/13/18.
//  Copyright © 2018 DeAnza. All rights reserved.
//

import UIKit

class GetGenderViewController: UIViewController {

    @IBOutlet var whatYourGender: UILabel!
    
    @IBOutlet var femaleBtnOutlet: UIButton!
    
    @IBOutlet var maleBtnOutlet: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        femaleBtnOutlet.backgroundColor = .clear
        femaleBtnOutlet.layer.cornerRadius = 5
        femaleBtnOutlet.layer.borderWidth = 1
        femaleBtnOutlet.layer.borderColor = UIColor.blue.cgColor
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func femaleBtnClick(_ sender: Any) {
        
    }
    @IBAction func maleBtnClick(_ sender: Any) {
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
