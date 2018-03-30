//
//  DetailRegisterViewController.swift
//  KoreaP
//
//  Created by mac on 2018. 3. 19..
//  Copyright © 2018년 swift. All rights reserved.
//

import UIKit
import Alamofire

class DetailRegisterViewController: UIViewController ,UINavigationControllerDelegate,UIImagePickerControllerDelegate{
   
    
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var interests: UITextView!
    override func viewDidLoad() {
        super.viewDidLoad()
        profileImage.layer.cornerRadius = 130
        profileImage.clipsToBounds = true
        
        // Do any additional setup after loading the view.
    }
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        let selectedimage = info[UIImagePickerControllerOriginalImage] as! UIImage
        profileImage.image = selectedimage
      
        dismiss(animated: true, completion: nil)
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let controller = UIImagePickerController()
        controller.delegate = self
        controller.sourceType = .photoLibrary
        
        present(controller, animated: true,completion: nil)
        
        
    }
    
    @IBAction func imageUpload(_ sender: UIButton){
        let uid = UserDefaults.standard.integer(forKey: "uid")
        let token =   "eyJhbGciOiJIUzUxMiJ9.eyJzdWIiOiI0NiIsImlzcyI6ImtvcmVhcGxhbmVyIiwiZXhwIjoxNTIyNTY0MDc4LCJpYXQiOjE1MjE5NTkyNzgsImVtYWlsIjoiMyJ9.DzEKDRNlhIu1udpAFwkKJy9z4GBKaxa2a5MNSAyaxRkkXJcJvicsUWRtftdXZNgYIMN3Zvkg0BxF9Eu_tEI7LA"
        let preseurl = "http://13.125.66.99:8080/koreaplaner/api/users/46/profilimage)"
        let headersVal = [
            "Authorization": (token as! String),
            ]
        let compressionQuality: CGFloat = 0.8
        guard let imageData = UIImageJPEGRepresentation(profileImage.image!, compressionQuality) else {
            print("Unable to get JPEG representation for image )")
            return
        }
        Alamofire.upload(imageData, to: preseurl, method: .put, headers: headersVal)
            .responseData {
                response in
                guard let httpResponse = response.response else {
                    print("Something went wrong uploading")
                    return
                }
                
                let publicUrl = preseurl.components(separatedBy: "?")[0]
        }
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
