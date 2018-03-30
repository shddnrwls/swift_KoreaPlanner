//
//  FriendlistViewController.swift
//  KoreaP
//
//  Created by mac on 2018. 3. 20..
//  Copyright © 2018년 swift. All rights reserved.
//

import UIKit
import Alamofire
class FriendlistViewController: UIViewController,UITableViewDataSource,UITableViewDelegate,UISearchBarDelegate {
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet var search: UISearchBar!
    
    var friendarr = [Friend]()
    var currentFriendArray = [Friend]()
    var userArray = [AnyObject]()
    var currentUserArray = [AnyObject]()
    var uid = UserDefaults.standard.integer(forKey: "uid")
    let token =   UserDefaults.standard.object(forKey: "object" as String)
    override func viewDidLoad() {
        super.viewDidLoad()
//        setUpfriends()
        let headersVal = [
            "Authorization": (token as! String),
            ]
        Alamofire.request("http://13.125.66.99:8080/koreaplaner/api/users/all/\(uid)", headers: headersVal).responseJSON { response in
            let result = response.result
            
            if let dict = result.value as? Dictionary<String,AnyObject>{
                if let innerDict = dict["user"]{
                    self.userArray = innerDict as! [AnyObject]
                    self.currentUserArray = innerDict as! [AnyObject]
                    self.tableView.reloadData()
                }
            }
        }
        


        // Do any additional setup after loading the view.
    }
    
    private func setUpfriends() {
        friendarr.append(Friend(name: "노욱진", email: "shddnrwls@gmail.com"))
        friendarr.append(Friend(name: "이승기", email: "swe212@gmail.com"))
        friendarr.append(Friend(name: "원일준", email: "wls2221@gmail.com"))
        friendarr.append(Friend(name: "신성철", email: "shwls898@gmail.com"))
//        currentFriendArray = friendarr
    }
    private func setUpSearchBar(){
        search.delegate = self
    }
    class Friend {
        let name:String
        let email:String
        init(name: String,email: String){
            self.name = name
            self.email = email
        }
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return userArray.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "myFriendCell") as? MyFriendTableViewCell else {
            return UITableViewCell()
        }
        
        let url = URL(string:"http://s3.ap-northeast-2.amazonaws.com/koreaplaner/11495f0d012f400da01a6e5d83d8ef3b.png")
        let data = try? Data(contentsOf: url!) //make sure your image in this url does exist, otherwise unwrap in a if let check / try-catch

        cell.emailLbl.text = userArray[indexPath.row]["email"] as? String
        cell.nameLbl.text = userArray[indexPath.row]["name"] as? String
        
        
        if userArray[indexPath.row]["profileimage"]as? String == nil{
            cell.imgView.image = UIImage(named:"ttsilhouette_2402174")
            print("널이다")
            
        }else
        {
            print("있다")
            
//            let url = URL(string: (userArray[indexPath.row]["profileimage"] as? String)!)
//            let data = try? Data(contentsOf: url!) //make sure your image in this url does exist, otherwise unwrap in a if let check / try-catch
//            cell.imageView?.image = UIImage(data: data!)
            
        }
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
        
    }
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let add = UITableViewRowAction(style: .destructive, title: "Add", handler: { action , indexPath in
            let id = self.userArray[indexPath.row]["id"]
            friendAddRest(fid: id as! Int)
            self.userArray.remove(at: indexPath.row)
            tableView.reloadData()
        })
        return [add]
    }
    func searchBar(_ search: UISearchBar, textDidChange searchText: String){
//        currentFriendArray = friendarr.filter({ friend -> Bool in
//            guard let text = search.text else { return false }
//            return friend.name.contains(text)
//        })
        currentUserArray = userArray.filter({ user -> Bool in
            guard let text = search.text else { return false}
            return user.name.contains(text)
        })
        tableView.reloadData()
        
        
    }
    func searchBar(_ search: UISearchBar, selectedScopeButtonIndexDidChange selectedScope: Int){
        
    }
    
    
    
    

}
