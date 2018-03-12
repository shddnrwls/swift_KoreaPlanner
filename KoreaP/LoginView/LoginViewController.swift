//
//  LoginViewController.swift
//  KoreaP
//
//  Created by mac on 2018. 3. 11..
//  Copyright © 2018년 swift. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
    @IBOutlet weak var blurView: UIVisualEffectView!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextfield: UITextField!
    @IBOutlet weak var BackgroundView: UIView!
    @IBOutlet weak var titleLbl: UILabel!
    
    override func viewDidLoad() {
        blurView.layer.cornerRadius = 500
        passwordTextfield.isSecureTextEntry = true
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func loginBtn(_ sender: UIButton) {
        let email = emailTextField.text
        let password = passwordTextfield.text
        
        if( email == ""||password == "")
        {
            return
        }
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
    @IBAction func signupBtn(_ sender: UIButton) {
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
