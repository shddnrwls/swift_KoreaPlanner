//
//  DetailSecheduleViewController.swift
//  KoreaP
//
//  Created by mac on 2018. 3. 23..
//  Copyright © 2018년 swift. All rights reserved.
//

import UIKit
import Alamofire
var sssid = 0
class DetailSecheduleViewController: UIViewController ,UITableViewDataSource,UITableViewDelegate{
    @IBOutlet var tableView: UITableView!
    @IBOutlet var titleTextField: UITextField!
    @IBOutlet var themaTextField: UITextField!
    @IBOutlet var startDateTextField: UITextField!
    @IBOutlet var endDateTextField: UITextField!
    @IBOutlet var introduceText: UITextView!
    var userArray = [AnyObject]()
    
    var uid = UserDefaults.standard.integer(forKey: "uid")
    let token =   UserDefaults.standard.object(forKey: "object" as String)
    let sid = mysechedulearr[myindex]["sid"] as! Int
    
    override func viewDidLoad() {
        super.viewDidLoad()
        titleTextField.addBorderBottom(height: 1.0, color: UIColor.lightGray)
        themaTextField.addBorderBottom(height: 1.0, color: UIColor.lightGray)
        startDateTextField.addBorderBottom(height: 1.0, color: UIColor.lightGray)
        endDateTextField.addBorderBottom(height: 1.0, color: UIColor.lightGray)
        titleTextField.text = mysechedulearr[myindex]["title"] as? String
        themaTextField.text = mysechedulearr[myindex]["thema"] as? String
        startDateTextField.text = mysechedulearr[myindex]["startdate"] as? String
        endDateTextField.text = mysechedulearr[myindex]["enddate"] as? String
        
        print("asdsdasd:\(sid)")
        sssid = sid
        let headersVal = [
            "Authorization": (token as! String),
            ]
        Alamofire.request("http://13.125.66.99:8080/koreaplaner/api/schedules/\(sid)/detail", headers: headersVal).responseJSON { response in
            let result = response.result
            
            
            if let dict = result.value as? Dictionary<String,AnyObject>{
                if let innerDict = dict["data"]{
                    print(innerDict)
                    if let secondinnerDict = innerDict["detailScheduleDtos"]
                    {
                        self.userArray = secondinnerDict as! [AnyObject]
                        self.tableView.reloadData()
                    }
                }
            }
            
        }
        
        // Do any additional setup after loading the view.
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "detailCell") as? DetailSecheduleTableViewCell else {
            return UITableViewCell()
        }
        cell.nameLbl.text = userArray[indexPath.row]["city"] as? String
        cell.startDate.text = userArray[indexPath.row]["startdate"] as? String
        cell.endDate.text = userArray[indexPath.row]["enddate"] as? String
        
        return cell
        
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return userArray.count
        
    }
    @IBAction func editSechedule(_ sender: UIButton) {
        secheduleEditRest(enddate: endDateTextField.text!, startdate: startDateTextField.text!, thema: themaTextField.text!, title: titleTextField.text!, sid: sid)
        
    }
    

}
