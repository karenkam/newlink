//
//  SearchTableViewCell.swift
//  CIS55Project_NewLink
//
//  Created by WONG YING TUNG on 6/20/18.
//  Copyright © 2018 DeAnza. All rights reserved.
//

import UIKit

class SearchTableViewCell: UITableViewCell {

    @IBOutlet var resultImage: UIImageView!
    @IBOutlet var resultFullName: UILabel!
    @IBOutlet var resultJobTitle: UILabel!
    @IBOutlet var resultCompany: UILabel!
    @IBOutlet var resultLocation: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
