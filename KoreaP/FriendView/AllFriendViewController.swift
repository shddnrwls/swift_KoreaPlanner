//
//  AllFriendViewController.swift
//  KoreaP
//
//  Created by mac on 2018. 3. 25..
//  Copyright © 2018년 swift. All rights reserved.
//

import UIKit

class AllFriendViewController: UIViewController {
    @IBOutlet var firstContainer: UIView!
    
    @IBOutlet var thirdContainer: UIView!
    @IBOutlet var secondContainer: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func showContainer(_ sender: UISegmentedControl) {
        if (sender.selectedSegmentIndex == 0)
        {
            UIView.animate(withDuration: 0.5, animations: {
                self.firstContainer.alpha = 1.0
                self.secondContainer.alpha = 0.0
                self.thirdContainer.alpha = 0.0
            })
        }else if (sender.selectedSegmentIndex == 1)
        {
            UIView.animate(withDuration: 0.5, animations: {
                self.firstContainer.alpha = 0.0
                self.secondContainer.alpha = 1.0
                self.thirdContainer.alpha = 0.0
            })
        }
        else
        {
            UIView.animate(withDuration: 0.5, animations: {
                self.firstContainer.alpha = 0.0
                self.secondContainer.alpha = 0.0
                self.thirdContainer.alpha = 1.0
                
            })
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
