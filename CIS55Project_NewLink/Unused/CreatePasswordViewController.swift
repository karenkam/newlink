//
//  CreatePasswordViewController.swift
//  CIS55Project_NewLink
//
//  Created by Karen Jin on 6/13/18.
//  Copyright © 2018 DeAnza. All rights reserved.
//

import UIKit

class CreatePasswordViewController: UIViewController {

    @IBOutlet var createPasswordLabel: UILabel!
    
    @IBOutlet var createPasswordTextField: UITextField!
    
    @IBOutlet var showPasswordBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func showPasswordBtnClick(_ sender: Any) {
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
