//
//  MenuTableViewCell.swift
//  DejengOrderApp
//
//  Created by Alice on 2023/5/11.
//

import UIKit

class MenuTableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var mPrice: UILabel!
    @IBOutlet weak var lPrice: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
