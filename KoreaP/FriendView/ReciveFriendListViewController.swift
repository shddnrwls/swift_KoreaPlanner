//
//  ReciveFriendListViewController.swift
//  KoreaP
//
//  Created by mac on 2018. 3. 22..
//  Copyright © 2018년 swift. All rights reserved.
//

import UIKit
import Alamofire
class ReciveFriendListViewController: UIViewController,UITableViewDataSource,UITableViewDelegate {
    @IBOutlet var tableView: UITableView!
    var recivefriendArray = [AnyObject]()
    var uid = UserDefaults.standard.integer(forKey: "uid")
    let token =   UserDefaults.standard.object(forKey: "object" as String)
    override func viewDidLoad() {
        super.viewDidLoad()
        let headersVal = [
            "Authorization": (token as! String),
            ]
        Alamofire.request("http://13.125.66.99:8080/koreaplaner/api/\(uid)/friends/receive", headers: headersVal).responseJSON { response in
            let result = response.result
            
            if let dict = result.value as? Dictionary<String,AnyObject>{
                if let innerDict = dict["data"]{
                    
                    self.recivefriendArray = innerDict as! [AnyObject]
                    self.tableView.reloadData()
                }
            }
            
        }

        // Do any additional setup after loading the view.
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return recivefriendArray.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "myFriendCell") as? MyFriendTableViewCell else {
            return UITableViewCell()
        }
        cell.emailLbl.text = recivefriendArray[indexPath.row]["email"] as? String
        cell.nameLbl.text = recivefriendArray[indexPath.row]["name"] as? String
        cell.imgView.image = UIImage(named:"ttsilhouette_2402174")
        return cell
        
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
        
    }
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let add = UITableViewRowAction(style: .destructive, title: "승인", handler: { action , indexPath in
           
            let id = self.recivefriendArray[indexPath.row]["id"]
            friendReciveRest(fid: id as! Int)
            self.recivefriendArray.remove(at: indexPath.row)
            tableView.reloadData()
            let storyboard: UIStoryboard = self.storyboard!
            let nextView = storyboard.instantiateViewController(withIdentifier: "mainNavView")
            self.present(nextView, animated: true, completion: nil)
        })
        let acc = UITableViewRowAction(style: .normal, title: "거절", handler: { action , indexPath in
            friendid = self.recivefriendArray[indexPath.row]["id"] as! Int
            print("확인\(friendid)")
            self.recivefriendArray.remove(at: indexPath.row)
            tableView.reloadData()
        })
        return [add,acc]
    }

}
