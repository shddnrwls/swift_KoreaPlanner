//
//  MyFriendTableViewCell.swift
//  KoreaP
//
//  Created by mac on 2018. 3. 20..
//  Copyright © 2018년 swift. All rights reserved.
//

import UIKit

class MyFriendTableViewCell: UITableViewCell {
    @IBOutlet var nameLbl: UILabel!
    @IBOutlet var emailLbl: UILabel!
    
    @IBOutlet var imgView: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
