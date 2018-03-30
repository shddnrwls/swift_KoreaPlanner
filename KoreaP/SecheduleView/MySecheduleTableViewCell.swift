//
//  MySecheduleTableViewCell.swift
//  KoreaP
//
//  Created by mac on 2018. 3. 23..
//  Copyright © 2018년 swift. All rights reserved.
//

import UIKit

class MySecheduleTableViewCell: UITableViewCell {
    @IBOutlet var nameLbl: UILabel!
    @IBOutlet var titleLbl: UILabel!
    @IBOutlet var enddateLbl: UILabel!
    @IBOutlet var startdateLbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
