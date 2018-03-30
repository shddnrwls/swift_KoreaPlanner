//
//  MainViewController.swift
//  
//
//  Created by mac on 2018. 3. 25..
//

import UIKit
import Alamofire
var userImage = UIImage(named:"ttsilhouette_2402174")
class MainViewController: UIViewController {

    @IBOutlet var nameTextField: UITextField!
    @IBOutlet var profileImage: UIImageView!
    var dede = [String:AnyObject]()
    override func viewDidLoad() {
        self.viewWillAppear(true)
        profileImage.layer.cornerRadius = 95
        nameTextField.addBorderBottom(height: 1.0, color: UIColor.lightGray)
        
        
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
            self.profileImage.image = userImage
            
        }
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
