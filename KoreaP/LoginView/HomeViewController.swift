//
//  HomeViewController.swift
//  
//
//  Created by mac on 2018. 3. 12..
//

import UIKit
import CoreData
struct User {
    var name:String
    var email:String
    var title:String
    var startDate:String
    var lastDate:String
    var color:UIColor!

}

class HomeViewController: UIViewController,UITableViewDelegate,UITableViewDataSource{
    var tableview:UITableView!
    var users:[User] = []
     let appleTheme:[UIColor] =  [UIColor.init(red: 166/255, green: 63/255, blue: 149/255, alpha: 1), UIColor.init(red: 122/255, green: 131/255, blue: 156/255, alpha: 1), UIColor.init(red: 78/255, green: 166/255, blue: 157/255, alpha: 1), UIColor.init(red: 119/255, green: 191/255, blue: 99/255, alpha: 1), UIColor.init(red: 217/255, green: 67/255, blue: 67/255, alpha: 1)]
    let background_color = UIColor.init(red: 50/255, green: 54/255, blue: 64/255, alpha: 1)
    var t_count:Int = 0
    var lastCell: StackViewCell = StackViewCell()
    var button_tag:Int = -1
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
//        view.backgroundColor = .black
        
        users.append(User(name:"어",email:"shddnrwls@gmail.com",title:"1박2일 부산여행",startDate:"2018-03-05",lastDate:"2018-03-08",color: .white))
        users.append(User(name:"노욱진",email:"shddnrwls@gmail.com",title:"힐링 강원도",startDate:"2018-03-05",lastDate:"2018-03-08",color: appleTheme[0]))
        users.append(User(name:"노욱진",email:"shddnrwls@gmail.com",title:"내일로 7일",startDate:"2018-03-05",lastDate:"2018-03-08",color: appleTheme[0]))
   
        tableview = UITableView(frame: view.frame)
        tableview.layer.frame.size.height = view.frame.height * 1.5
        tableview.frame.origin.y += 80
        tableview.register(UINib(nibName: "StackViewCell", bundle: nil), forCellReuseIdentifier: "StackViewCell")
        tableview.delegate = self
        tableview.dataSource = self
        tableview.allowsSelection = false
        tableview.separatorStyle = .none
        tableview.backgroundColor = .clear
        view.addSubview(tableview)
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == button_tag {
            return 320
        } else {
            return 60
        }
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableview.dequeueReusableCell(withIdentifier: "StackViewCell", for: indexPath) as! StackViewCell
        if !cell.cellExists {
            cell.salary.text = "메일:\(users[indexPath.row].email)"
            cell.name.text = "제목:\(users[indexPath.row].title)"
            cell.startLbl.text = "출발일:\(users[indexPath.row].startDate)"
            cell.endLbl.text = "마지막날:\(users[indexPath.row].lastDate)"
            cell.open.setTitle(users[indexPath.row].title, for: .normal)
            cell.openView.backgroundColor = .white
            cell.stuffView.backgroundColor = users[indexPath.row].color
            cell.open.tag = t_count
            cell.open.addTarget(self, action: #selector(cellOpened(sender:)), for: .touchUpInside)
            t_count += 1
            cell.cellExists = true
        }
        UIView.animate(withDuration: 0){
            cell.contentView.layoutIfNeeded()
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users.count
    }
    
    @objc func cellOpened(sender:UIButton){
        self.tableview.beginUpdates()
        
        let previousCellTag = button_tag
        if lastCell.cellExists{
            self.lastCell.animate(duration: 0.2, c: {
                self.view.layoutIfNeeded()
            })
            
            if sender.tag == button_tag {
                button_tag = -1
                lastCell = StackViewCell()
            }
        }
        if sender.tag != previousCellTag{
            button_tag = sender.tag
            lastCell = tableview.cellForRow(at: IndexPath(row: button_tag, section: 0 )) as! StackViewCell
            self.lastCell.animate(duration: 0.2, c: {
                self.view.layoutIfNeeded()
            })
        }
        self.tableview.endUpdates()
    }
}
