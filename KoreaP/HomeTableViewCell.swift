//
//  HomeTableViewCell.swift
//  KoreaP
//
//  Created by mac on 2018. 3. 14..
//  Copyright © 2018년 swift. All rights reserved.
//

import UIKit

class HomeTableViewCell: UITableViewCell {
    @IBOutlet weak var openView: UIView!
    @IBOutlet weak var secondView: UIView!{
        didSet{
            secondView?.isHidden = true
            secondView?.alpha = 0
            
        }
    }
    @IBOutlet weak var open: UIButton!
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var email: UILabel!
    let background_color = UIColor.init(red: 50/255, green: 54/255, blue: 64/255, alpha: 1)
    var cellExits:Bool = false
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.contentView.backgroundColor = background_color
    }
    
    func animate(duration:Double, c: @escaping () -> Void) {
        UIView.animateKeyframes(withDuration: duration, delay: 0, options: .calculationModePaced, animations: {
            UIView.addKeyframe(withRelativeStartTime: 0, relativeDuration: duration, animations: {
                
                self.secondView.isHidden = !self.secondView.isHidden
                if self.secondView.alpha == 1 {
                    self.secondView.alpha = 0.5
                } else {
                    self.secondView.alpha = 1
                }
                
            })
        }, completion: {  (finished: Bool) in
            print("animation complete")
            c()
        })
    }

    
}
