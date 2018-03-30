//
//  RegisterViewController.swift
//  KoreaP
//
//  Created by mac on 2018. 3. 18..
//  Copyright © 2018년 swift. All rights reserved.
//

import UIKit

class RegisterViewController: UIViewController {

    @IBOutlet weak var emailTexrfield: UITextField!
    @IBOutlet weak var passwordTextfield: UITextField!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var interestsTextfield: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        emailTexrfield.addBorderBottom(height: 1.0, color: UIColor.lightGray)
        passwordTextfield.addBorderBottom(height: 1.0, color: UIColor.lightGray)
        nameTextField.addBorderBottom(height: 1.0, color: UIColor.lightGray)
        interestsTextfield.addBorderBottom(height: 1.0, color: UIColor.lightGray)
        passwordTextfield.isSecureTextEntry = true
        

        // Do any additional setup after loading the view.
    }
    @IBAction func registerBtn(_ sender: UIButton) {
        registerRest(email: emailTexrfield.text!, password: passwordTextfield.text!, name: nameTextField.text!, phoneNumber: interestsTextfield.text!, { isSuccess in
            if isSuccess {
                print("success")
//                let storyboard: UIStoryboard = UIStoryboard(name: "Home", bundle: nil)
//                let nextView = storyboard.instantiateInitialViewController()
//                self.present(nextView!, animated: true, completion: nil)
            } else {
                
                print("fail")
            }
        })
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
