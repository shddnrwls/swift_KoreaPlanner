//
//  ShareFriendViewController.swift
//  KoreaP
//
//  Created by mac on 2018. 3. 27..
//  Copyright © 2018년 swift. All rights reserved.
//

import UIKit
import Alamofire
class ShareFriendViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {

    @IBOutlet var tableView: UITableView!
    var friendArray = [AnyObject]()
    
    var uid = UserDefaults.standard.integer(forKey: "uid")
    let token =   UserDefaults.standard.object(forKey: "object" as String)
    override func viewDidLoad() {
        super.viewDidLoad()
        let headersVal = [
            "Authorization": (token as! String),
            ]
        Alamofire.request("http://13.125.66.99:8080/koreaplaner/api/schedules/\(sssid)/detail", headers: headersVal).responseJSON { response in
            let result = response.result
            
            
            if let dict = result.value as? Dictionary<String,AnyObject>{
                if let innerDict = dict["data"]{
                    print(innerDict)
                    if let secondinnerDict = innerDict["findUserDtoList"]
                    {
                        self.friendArray = secondinnerDict as! [AnyObject]
                        self.tableView.reloadData()
                    }
                }
            }
            
        }
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return friendArray.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "myFriendCell") as? MyFriendTableViewCell else {
            return UITableViewCell()
        }
        cell.emailLbl.text = friendArray[indexPath.row]["email"] as? String
        cell.nameLbl.text = friendArray[indexPath.row]["name"] as? String
        cell.imgView.image = UIImage(named:"ttsilhouette_2402174")
        return cell
        
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
        
    }
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let add = UITableViewRowAction(style: .destructive, title: "Add", handler: { action , indexPath in
            self.friendArray.remove(at: indexPath.row)
            tableView.reloadData()
        })
        return [add]
    }
    
    

}
