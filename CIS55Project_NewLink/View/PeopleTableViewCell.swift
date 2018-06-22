//
//  PeopleTableViewCell.swift
//  CIS55Project_NewLink
//
//  Created by WONG YING TUNG on 6/16/18.
//  Copyright © 2018 DeAnza. All rights reserved.
//

import UIKit

class PeopleTableViewCell: UITableViewCell {

    @IBOutlet var cellUserLocation: UILabel!
    @IBOutlet var cellUserJobCompany: UILabel!
    @IBOutlet var cellUserName: UILabel!
    @IBOutlet var cellProfilePic: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
