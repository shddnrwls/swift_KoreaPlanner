//
//  MySecheduleViewController.swift
//  KoreaP
//
//  Created by mac on 2018. 3. 23..
//  Copyright © 2018년 swift. All rights reserved.
//

import UIKit
import Alamofire
var mysechedulearr = [AnyObject]()
var myindex = 0
var shareid = 0
class MySecheduleViewController: UIViewController ,UITableViewDelegate,UITableViewDataSource{
    @IBOutlet var tableView: UITableView!
    
    
    
    var uid = UserDefaults.standard.integer(forKey: "uid")
    let token =   UserDefaults.standard.object(forKey: "object" as String)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let headersVal = [
            "Authorization": (token as! String),
            ]
        Alamofire.request("http://13.125.66.99:8080/koreaplaner/api/schedules/\(uid)", headers: headersVal).responseJSON { response in
            let result = response.result
            
            if let dict = result.value as? Dictionary<String,AnyObject>{
                if let innerDict = dict["data"]{
                    
                    mysechedulearr = innerDict as! [AnyObject]
                    self.tableView.reloadData()
                }
            }
            
        }

        // Do any additional setup after loading the view.
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return mysechedulearr.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "sCell") as? MySecheduleTableViewCell else {
            return UITableViewCell()
        }
        cell.nameLbl.text = mysechedulearr[indexPath.row]["type"] as? String
        cell.titleLbl.text = mysechedulearr[indexPath.row]["title"] as? String
        cell.startdateLbl.text = mysechedulearr[indexPath.row]["startdate"] as? String
        cell.enddateLbl.text = mysechedulearr[indexPath.row]["enddate"] as? String
        return cell
        
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
        
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        myindex = indexPath.row
       performSegue(withIdentifier: "detail", sender: self)
    }

    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
       
        let delete = UITableViewRowAction(style: .destructive, title: "삭제", handler: { action , indexPath in
            
            let token =   UserDefaults.standard.object(forKey: "object" as String)
            let qid = mysechedulearr[indexPath.row]["sid"] as! Int
            let qq = String(qid)
            let detailurl = "http://13.125.66.99:8080/koreaplaner/api/schedules/schedule/\(qq)"
            let headersVal = [
                "Authorization": (token as! String),
                ]
            Alamofire.request(detailurl,method: .delete,headers: headersVal).responseJSON { response in
                let result = response.result
                print(response)
            }
            
            
            mysechedulearr.remove(at: indexPath.row)
            tableView.reloadData()
        })
        let share = UITableViewRowAction(style: .normal, title: "공유", handler: { action , indexPath in
            shareid = mysechedulearr[indexPath.row]["sid"] as! Int
            let storyboard: UIStoryboard = self.storyboard!
            let nextView = storyboard.instantiateViewController(withIdentifier: "searchFriend")
            self.present(nextView, animated: true, completion: nil)
            
            tableView.reloadData()
        })
        
        return [delete,share]
    }

}
