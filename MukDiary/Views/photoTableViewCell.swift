//
//  photoTableViewCell.swift
//  MukDiary
//
//  Created by Seryun Chun on 2023/02/26.
//

import UIKit

class photoTableViewCell: UITableViewCell {
    
    @IBOutlet weak var photoImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
