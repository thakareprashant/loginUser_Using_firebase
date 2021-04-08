//
//  ViewController.swift
//  RegApi
//
//  Created by prashant thakare on 04/04/21.
//

import UIKit

import FirebaseAuth

class LoginViewController: UIViewController {
     
    
    
    //Reference
    @IBOutlet weak var PasswordLbl: UILabel!
    @IBOutlet weak var EmailLbl: UILabel!
    @IBOutlet weak var passTextF: UITextField!
    @IBOutlet weak var emailTextF: UITextField!
    @IBOutlet weak var SignUpLbl: UILabel!
    @IBOutlet weak var ScrollV: UIScrollView!
    @IBOutlet weak var LoginScreenView: UIView!
    @IBOutlet weak var btn: UIButton!
    
    @IBOutlet weak var signUpBtn: UIButton!
    
    @IBAction func signIn(_ sender: Any) {
        // Login functionality
        Auth.auth().signIn(withEmail: emailTextF.text!, password: passTextF.text!) { (authResult, error) in
            if error != nil{
                // If user Not found
                self.presentAlert(withTitle: "Login eroor", message: "Check Your login credential")
            }
            else{
                // Go to home page
                self.dismiss(animated: true, completion: nil)
            }
            
            
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        btn.drawShadow(shadowColor: .black, offset: CGSize(width: 3, height: 3))
        signUpBtn.drawShadow(shadowColor: .black, offset: CGSize(width: 3, height: 3))
       
        // Do any additional setup after loading the view.
    }
    @IBAction func didTapSignUp(_ sender: Any) {
        let vc = storyboard?.instantiateViewController(identifier: "SignUpViewController") as! SignUpViewController
        present(vc, animated: true, completion: nil)
    }
    
    
   
}


