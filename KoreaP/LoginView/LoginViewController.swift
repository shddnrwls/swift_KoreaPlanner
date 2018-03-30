//
//  LoginViewController.swift
//  KoreaP
//
//  Created by mac on 2018. 3. 11..
//  Copyright © 2018년 swift. All rights reserved.
//

import UIKit


class LoginViewController: UIViewController {
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextfield: UITextField!
    @IBOutlet weak var signBtn: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        emailTextField.addBorderBottom(height: 1.0, color: UIColor.lightGray)
        passwordTextfield.addBorderBottom(height: 1.0, color: UIColor.lightGray)
        passwordTextfield.isSecureTextEntry = true
        
    }
   
    @IBAction func loginBtn(_ sender: UIButton) {
        let email = emailTextField.text
        let password = passwordTextfield.text
        
        if( email == ""||password == "")
        {
            return
        }
//        let storyboard: UIStoryboard = UIStoryboard(name: "Home", bundle: nil)
//        let nextView = storyboard.instantiateInitialViewController()
//        self.present(nextView!, animated: true, completion: nil)

        loginRest(login: email!, password: password!, { isSuccess in

            if isSuccess {
                print("success")
                let storyboard: UIStoryboard = UIStoryboard(name: "Home", bundle: nil)
                let nextView = storyboard.instantiateInitialViewController()
                self.present(nextView!, animated: true, completion: nil)
            } else {

                print("fail")
                let alertController = UIAlertController(title: "로그인에 실패하셨습니다",message: "email,password를 확인해주세요.", preferredStyle: UIAlertControllerStyle.alert)

                //UIAlertActionStye.destructive 지정 글꼴 색상 변경


                let cancelButton = UIAlertAction(title: "확인", style: UIAlertActionStyle.cancel, handler: nil)


                alertController.addAction(cancelButton)

                self.present(alertController,animated: true,completion: nil)

            }
        })
    }
  
    

}
