//
//  SignupViewController.swift
//  CIS55Project_NewLink
//
//  Created by George Rothert on 6/2/18.
//  Copyright © 2018 DeAnza. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth


struct userSecurityAnswer {
    //let answer1: String
    //let answer2: String
    let email: String
}

var users: [userSecurityAnswer] = []

class SignupViewController: UIViewController {

    private let CONNECTIONS_SEGUE = "Connections2Segue";
    
    @IBOutlet var emailInput: UITextField!
    @IBOutlet var passwordInput: UITextField!

    @IBOutlet var loginBtnOutlet: UIButton!
    
    @IBOutlet var signBtnOutlet: UIButton!
    
    @IBOutlet var errorMessage: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        emailInput.frame.size.height = 40
//        emailInput.borderStyle = .line
//        emailInput.textColor = UIColor.black
        passwordInput.frame.size.height = 40
//        passwordInput.borderStyle = .line
        loginBtnOutlet.frame.size.height = 40
        loginBtnOutlet.frame.size.width = 300
        
        signBtnOutlet.frame.size.height = 40
        signBtnOutlet.frame.size.width = 300
        
        
        let gradient = CAGradientLayer()
        gradient.frame =  CGRect(origin: CGPoint.zero, size: self.signBtnOutlet.frame.size)
        gradient.colors = [UIColor.black.cgColor, UIColor.black.cgColor]

        let shape = CAShapeLayer()
        shape.lineWidth = 2
        shape.path = UIBezierPath(rect: self.signBtnOutlet.bounds).cgPath
        shape.strokeColor = UIColor.black.cgColor
        shape.fillColor = UIColor.clear.cgColor
        gradient.mask = shape

        self.signBtnOutlet.layer.addSublayer(gradient)
        
        
        // Do any additional setup after loading the view.
    }

    override func viewDidAppear(_ animated: Bool) {
        if AuthProvider.Instance.isLoggedIn() {
            performSegue(withIdentifier: "LoginToConnections", sender: nil);
            // This code enables the user to stay logged in when they leave the app and then come back.
        }
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func Login(_ sender: Any) {
        
        if emailInput.text != "" && passwordInput.text != "" {
            
            AuthProvider.Instance.login(withEmail: emailInput.text!.lowercased(), password: passwordInput.text!, loginHandler: { (message) in
                
                if message != nil {
                    self.alertTheUser(title: "Problem With Authentication", message: message!);
                } else {
                    self.emailInput.text = "";
                    self.passwordInput.text = "";
                    
                    self.performSegue(withIdentifier: "LoginToConnections", sender: nil)                }
                
                
            });
            
        } else {
            
            alertTheUser(title: "Email and Password are required", message: "Please enter e-mail and passowrd in the text fields");
            
            
        }
        
        
    }
    
    @IBAction func Signup(_ sender: Any) {
        
        if emailInput.text != "" && passwordInput.text != "" {

            AuthProvider.Instance.signUp(withEmail: emailInput.text!.lowercased(), password: passwordInput.text!, loginHandler: { (message) in

                if message != nil {
                    self.alertTheUser(title: "Problem With Creating A New User", message: message!)
                } else {
                    self.emailInput.text = ""
                    self.passwordInput.text = ""

                    self.performSegue(withIdentifier: "ContinueUserSignUp", sender: nil)
                }

            } )


        }
        else {

            alertTheUser(title: "Email and Password are required", message: "Please enter e-mail and passowrd in the test fields");


        }
        
        
        
    }
    
    private func alertTheUser(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert);
        let ok = UIAlertAction(title: "OK", style: .default, handler: nil);
        alert.addAction(ok);
        present(alert, animated: true, completion: nil);
        
        
        
    }
    
    @IBAction func unwindToLoginScreen(segue:UIStoryboardSegue){
        //self.dismiss(animated: true, completion: nil)
    }
    @IBAction func profileViewLogout(segue:UIStoryboardSegue){
        //self.dismiss(animated: true, completion: nil)
    }

    
//    func displayErrorPassword() {
//        errorMessage.text = "Confirm password is not correct."
//        errorMessage.isEnabled = true
//    }
//    func displayPasswordLimit(){
//        errorMessage.text = "The password should be at least 6 characters."
//        errorMessage.isEnabled = true
//    }
//** display don't leave the box blank. */
//    func displayDontBlank() {
//        errorMessage.text = "Please fill in all the questions."
//        errorMessage.isEnabled = true
//
//    }
//
//     MARK: - Navigation
//
//     In a storyboard-based application, you will often want to do a little preparation before navigation
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//         Get the new view controller using segue.destinationViewController.
//         Pass the selected object to the new view controller.
//    }
//

}
