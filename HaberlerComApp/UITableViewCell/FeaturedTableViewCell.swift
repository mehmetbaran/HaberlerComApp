//
//  FeaturedTableViewCell.swift
//  HaberlerComApp
//
//  Created by Mehmet Baran on 4.04.2020.
//  Copyright © 2020 Mehmet Baran. All rights reserved.
//

import UIKit

class FeaturedTableViewCell: UITableViewCell {
    
    //MARK: IBOutlets
    
    @IBOutlet weak var newsImage: UIImageView!
    @IBOutlet weak var newsTitle: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        
        newsImage.layer.cornerRadius = 10
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
