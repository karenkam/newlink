//
//  CompanyTitleLocationViewController.swift
//  CIS55Project_NewLink
//
//  Created by Karen Jin on 6/13/18.
//  Copyright © 2018 DeAnza. All rights reserved.
//

import UIKit
import Firebase

class CompanyTitleLocationViewController: UIViewController {
    
    let databaseRef = Database.database().reference();
    
    @IBOutlet var companyLabel: UILabel!
    
    @IBOutlet var companyTextField: UITextField!
    
    @IBOutlet var jobTitleLabel: UILabel!
    
    @IBOutlet var jobTitleTextField: UITextField!
    
    @IBOutlet var locationLabel: UILabel!
    
    @IBOutlet var locationTextField: UITextField!
    
    @IBOutlet var companyTitLocContinueBtnOutlet: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupAddTarget()
        companyTitLocContinueBtnOutlet.layer.borderColor = UIColor.darkGray.cgColor // button outline color
        companyTitLocContinueBtnOutlet.layer.cornerRadius = companyTitLocContinueBtnOutlet.frame.size.height / 2 // button 椭圆
        companyTitLocContinueBtnOutlet.layer.masksToBounds = true

        companyTitLocContinueBtnOutlet.setGradientBackground(colorOne: Colors.newlineGreen, colorTwo: Colors.newlineBlue)
        
        

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func companyTitLocContinueBtnClick(_ sender: Any) {
        let company = companyTextField.text!
        let title = jobTitleTextField.text!
        let location = locationTextField.text!
        
        self.databaseRef.child("Connections").child((Auth.auth().currentUser?.uid)!).updateChildValues(["company" : company, "title" : title, "location" : location] ,withCompletionBlock: { (error, ref) in
            if error != nil {
                print(error)
                return
            }
        })
        
        performSegue(withIdentifier: "GoToSetAboutYou", sender: self)
    }
    
    func setupAddTarget(){
        companyTitLocContinueBtnOutlet.isHidden = true
        companyTextField.addTarget(self, action: #selector(fieldNotEmpty), for: .editingChanged)
        jobTitleTextField.addTarget(self, action: #selector(fieldNotEmpty), for: .editingChanged)
        locationTextField.addTarget(self, action: #selector(fieldNotEmpty), for: .editingChanged)
        
    }
    
    @objc func fieldNotEmpty(){
        
        guard
            let company = companyTextField.text, !company.isEmpty,
            let job = jobTitleTextField.text, !job.isEmpty,
            let location = locationTextField.text, !location.isEmpty
            
            else {
                self.companyTitLocContinueBtnOutlet.isHidden = true
                return
        }
        self.companyTitLocContinueBtnOutlet.isHidden = false
    }
    
    @IBAction func logout(_ sender: Any) {
        if AuthProvider.Instance.logOut() {
            dismiss(animated: true, completion: nil)
        }
        
    }
    
}



