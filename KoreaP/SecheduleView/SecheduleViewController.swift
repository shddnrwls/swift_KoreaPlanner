//
//  SecheduleViewController.swift
//  KoreaP
//
//  Created by mac on 2018. 3. 20..
//  Copyright © 2018년 swift. All rights reserved.
//

import UIKit

class SecheduleViewController: UIViewController {
    @IBOutlet var titleLbl: UITextField!
    @IBOutlet var themaLbl: UITextField!
    @IBOutlet var startDate: UITextField!
    @IBOutlet var endDate: UITextField!
    let datePicker = UIDatePicker()
    let endDatePicker = UIDatePicker()
    
    override func viewDidLoad() {
        super.viewDidLoad()
         createDate()

        // Do any additional setup after loading the view.
    }
    
    func createDate(){
        
        //datePicke 포멧
        datePicker.datePickerMode = .date
        endDatePicker.datePickerMode = .date
        
        // 하단툴바
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        
        // 툴바 버튼아이템
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: #selector(donePressed))
        toolbar.setItems([doneButton], animated: false)
        
        startDate.inputAccessoryView = toolbar
        endDate.inputAccessoryView = toolbar
        
       // textField 에 선택한 날짜 보여주기
        endDate.inputView = endDatePicker
        startDate.inputView = datePicker
        
    }
    //날짜입력 확인이벤트
    @objc func donePressed() {
        
        // format date
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .short
        dateFormatter.timeStyle = .none
        
        startDate.text = dateFormatter.string(from: datePicker.date)
        endDate.text = dateFormatter.string(from: endDatePicker.date)
        self.view.endEditing(true)
    }
    

    @IBAction func nextBtn(_ sender: UIButton) {
        
        
        print("확인:\(startDate.text!),\(endDate.text!)")
        secheduleRest(endDate: endDate.text!, startDate: startDate.text!, thema: themaLbl.text!, title: titleLbl.text!)
        
    }
    
    //날짜 간격 일수 뽑기
    func getIntervalDays(date: Date?, anotherDay: Date? = nil) -> Double {
        
        var interval: Double!
        
        if anotherDay == nil {
            interval = date?.timeIntervalSinceNow
        } else {
            interval = date?.timeIntervalSince(anotherDay!)
        }
        
        let r = interval / 86400
        
        return floor(r)
    }

}
