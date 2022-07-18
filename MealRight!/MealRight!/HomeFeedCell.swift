//
//  HomeFeedCell.swift
//  MealRight!
//
//  Created by Tommyyu on 4/8/22.
//

import UIKit

class HomeFeedCell: UITableViewCell {

    @IBOutlet weak var feedimage: UIImageView!
    @IBOutlet weak var UsernameLabel: UILabel!
    
    @IBOutlet weak var LikeImage: UIImageView!
    
    @IBOutlet weak var TitleLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    



}
