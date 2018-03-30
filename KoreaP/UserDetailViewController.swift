//
//  UserDetailViewController.swift
//  KoreaP
//
//  Created by mac on 2018. 3. 23..
//  Copyright © 2018년 swift. All rights reserved.
//

import UIKit
import Alamofire

class UserDetailViewController: UIViewController ,UINavigationControllerDelegate,UIImagePickerControllerDelegate{

    @IBOutlet var imageView: UIImageView!
    @IBOutlet var nameTextField: UITextField!
    @IBOutlet var logOutBtn: UIButton!
    @IBOutlet var userEditBtn: UIButton!
    @IBOutlet var IdTextField: UITextField!
    
    @IBOutlet var interestTextField: UITextField!
    var dede = [String:AnyObject]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imageView.layer.cornerRadius = 76
        nameTextField.addBorderBottom(height: 1.0, color: UIColor.white)
        IdTextField.addBorderBottom(height: 1.0, color: UIColor.white)
        interestTextField.addBorderBottom(height: 1.0, color: UIColor.white)
        IdTextField.isSecureTextEntry = true
        imageView.image = userImage
        
        logOutBtn.layer.cornerRadius = 10
        userEditBtn.layer.cornerRadius = 10
        let uid = UserDefaults.standard.integer(forKey: "uid")
        let token =   UserDefaults.standard.object(forKey: "object" as String)
        
        let detailurl = "http://13.125.66.99:8080/koreaplaner/api/users/\(uid)"
        let headersVal = [
            "Authorization": (token as! String),
            ]
        Alamofire.request(detailurl, headers: headersVal).responseJSON { response in
            let result = response.result
            
            if let dict = result.value as! [String:Any]?{
                if let innerdict = dict["user"] as! [String:Any]?
                {
                    self.dede = innerdict as [String : AnyObject]
                }
            }
            self.nameTextField.text = self.dede["name"] as? String
            
            self.interestTextField.text = self.dede["interest"] as? String
            
        }
        

        // Do any additional setup after loading the view.
    }

    @IBAction func editAction(_ sender: UIButton) {
        userEditRest(name: nameTextField.text!, password: IdTextField.text!, interest: interestTextField.text!)
        let storyboard: UIStoryboard = self.storyboard!
        let nextView = storyboard.instantiateViewController(withIdentifier: "mainView")
        self.present(nextView, animated: true, completion: nil)
    }
    @IBAction func logoutAction(_ sender: UIButton) {
        let storyboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let nextView = storyboard.instantiateInitialViewController()
        self.present(nextView!, animated: true, completion: nil)
     
    }
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        let selectedimage = info[UIImagePickerControllerOriginalImage] as! UIImage
        imageView.image = selectedimage
        userImage = selectedimage
        dismiss(animated: true, completion: nil)
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let controller = UIImagePickerController()
        controller.delegate = self
        controller.sourceType = .photoLibrary
        
        present(controller, animated: true,completion: nil)
        
        
    }
    class User{
        let name:String
        let email:String
        let id : Int
        let interest:String
        let profileimage:String
        init(name:String,email: String,id: Int,interest: String,profileimage: String) {
            self.email = email
            self.name = name
            self.id = id
            self.interest = interest
            self.profileimage = profileimage
        }
    }
}
