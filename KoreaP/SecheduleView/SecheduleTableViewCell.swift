//
//  SecheduleTableViewCell.swift
//  KoreaP
//
//  Created by mac on 2018. 3. 22..
//  Copyright © 2018년 swift. All rights re/Users/mac/Desktop/swift/KoreaP/KoreaP/Home.storyboardserved.
//

import UIKit

class SecheduleTableViewCell: UITableViewCell {

    @IBOutlet var stdLbl: UILabel!
    @IBOutlet var countlbl: UILabel!
    @IBOutlet var locationNamelbl: UILabel!
    @IBOutlet var endLbl: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
