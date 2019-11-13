//
//  searchTableViewCell.swift
//  Podcasts
//
//  Created by Joe Farrell on 11/23/18.
//  Copyright © 2018 Joe Farrell. All rights reserved.
//

import UIKit

class searchTableViewCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var authorLabel: UILabel!
    @IBOutlet weak var podcastImage: UIImageView?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
