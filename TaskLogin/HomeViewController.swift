//
//  HomeViewController.swift
//  RegApi
//
//  Created by prashant thakare on 07/04/21.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase

class HomeViewController: UIViewController {

    //var ref:DatabaseReference?
    
    @IBOutlet weak var genderLbl: UILabel!
    @IBOutlet weak var cityLbl: UILabel!
    @IBOutlet weak var birthDateLbl: UILabel!
    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var logOutBtn: UIBarButtonItem!
    @IBAction func Btn(_ sender: Any) {
        
    }
    @IBAction func didTapLogout(_ sender: Any) {
        do {
            // User SignOut
            try Auth.auth().signOut()
            let vc = storyboard?.instantiateViewController(identifier: "LoginViewController") as! LoginViewController
            vc.modalPresentationStyle = .fullScreen
            self.present(vc, animated: true, completion: nil)
        } catch  {
            print(error.localizedDescription)
        }
        
        
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        nameLbl.isHidden = true
        cityLbl.isHidden = true
        birthDateLbl.isHidden = true
        genderLbl.isHidden = true
        // Do any additional setup after loading the view.
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        // check user signed in
        if Auth.auth().currentUser == nil{
            let vc = storyboard?.instantiateViewController(identifier: "LoginViewController") as! LoginViewController
            vc.modalPresentationStyle = .fullScreen
            present(vc, animated: true, completion: nil)
            
           
        }
        getDataFromDatabase()
        
        
         
    }
    
    // fetching data from Database
    func getDataFromDatabase(){
        let ref = Database.database().reference()
       
       
       ref.child("User").queryOrderedByKey().observe(.value) { (snapshot) in
        
        if let dict = snapshot.children.allObjects as? [DataSnapshot]{
            for snap in dict{
                if let mainDict = snap.value as? [String:AnyObject]{
                let name = mainDict["name"] as? String
                let date = mainDict["date"] as? String
                let gender = mainDict["gender"] as? String
                let city = mainDict["city"] as? String
                    self.nameLbl.isHidden = false
                    self.cityLbl.isHidden = false
                    self.birthDateLbl.isHidden = false
                    self.genderLbl.isHidden = false
                    self.nameLbl.text = "Welcome \(name!)"
                    self.birthDateLbl.text = "Your birthdate is \(date!)"
                    self.genderLbl.text = "Your gender is \(gender!)"
                    self.cityLbl.text = "You live in \(city!)"
                
                    
                }
            }
            
               
               
           }
       } withCancel: { (error) in
           print("error")
       }
        
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
