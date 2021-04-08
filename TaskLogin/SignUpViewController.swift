//
//  SignUpViewController.swift
//  TaskLogin
//
//  Created by prashant thakare on 08/04/21.
//

import UIKit
import FirebaseDatabase
import DateTimePicker
import SkyFloatingLabelTextField
import FirebaseAuth
class SignUpViewController: UIViewController {
    //Global variables
    var ref = DatabaseReference.init()
    let gender:[String] = ["male","female","other"]
    var thePicker = UIPickerView()
    var picker = UIDatePicker()
    
    
    // refernce
    @IBOutlet weak var submitBtn: UIButton!
    @IBOutlet weak var genderPicker: UITextField!
    @IBOutlet weak var dateTextF: UITextField!
    
    @IBOutlet weak var nameTF: SkyFloatingLabelTextField!
    @IBOutlet weak var emailTF: SkyFloatingLabelTextField!
    @IBOutlet weak var passwordTF: SkyFloatingLabelTextField!
    @IBOutlet weak var cityTF: SkyFloatingLabelTextField!
    
    
    
    
    //dismiss keyboard
    @objc func dismissKeyboard(){
        emailTF.resignFirstResponder()
        passwordTF.resignFirstResponder()
        nameTF.resignFirstResponder()
        dateTextF.resignFirstResponder()
        genderPicker.resignFirstResponder()
        cityTF.resignFirstResponder()
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tapGesture()
        
        
        
        thePicker.delegate = self
        thePicker.dataSource = self
        genderPicker.inputView = thePicker
        self.genderPicker.delegate = self
        self.dateTextF.delegate = self
        
       //using extension
        dateTextF.drawShadow(shadowColor: .black, offset: CGSize(width: 3, height: 3))
        genderPicker.drawShadow(shadowColor: .black, offset: CGSize(width: 3, height: 3))
        makePicker()
        
        
    }
    @IBAction func submitBtn(_ sender: Any) {
        // validation
        if ((emailTF.text?.isEmailValid) == true),passwordTF.text!.count >= 8,nameTF.text != "",cityTF.text != "",dateTextF.text != "",genderPicker.text != ""{
            firebaseAuth()
            // sending to previous page
            dismiss(animated: true, completion: nil)
        }
        else  {
            //if  error found
            self.presentAlert(withTitle: " enter Valid ", message: "enter valid credential")
        }
        
        
        
    }
    
   
    func makePicker(){
        picker = UIDatePicker()
        dateTextF.inputView = picker
        picker.addTarget(self, action: #selector(SignUpViewController.handleDatePicker), for: UIControl.Event.valueChanged)
        picker.datePickerMode = .date
    }

    @objc func handleDatePicker() {
        var dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd-MM-yyyy"
        dateTextF.text = dateFormatter.string(from: picker.date)
        dateTextF.resignFirstResponder()
    }
    func tapGesture(){
        let tapGesture:UITapGestureRecognizer = UITapGestureRecognizer.init(target: self, action: #selector(dismissKeyboard))
        self.view.addGestureRecognizer(tapGesture)
    }
    func firebaseAuth(){
        // create user email and password
        Auth.auth().createUser(withEmail: emailTF.text!, password: passwordTF.text!) { [self] (authData, error) in
            if error == nil{
                //saving data to database
                let userdata = ["name":nameTF.text,"city":cityTF.text,"gender":genderPicker.text,"date":dateTextF.text]
                let ref = Database.database().reference()
                ref.child("User").childByAutoId().setValue(userdata)
            }
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
extension SignUpViewController: UIPickerViewDelegate,UIPickerViewDataSource,UITextFieldDelegate{
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
      return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return gender.count
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return gender[row]
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        thePicker.resignFirstResponder()
       return genderPicker.text = gender[row]
    }
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool{
        return false
    }
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        if textField == genderPicker{
            self.thePicker.selectRow(0, inComponent: 0, animated: true)
            self.pickerView(thePicker, didSelectRow: 0, inComponent: 0)
        }
        return true
    }
    
}
