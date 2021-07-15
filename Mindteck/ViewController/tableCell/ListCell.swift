//
//  ListCell.swift
//  Mindteck
//
//  Created by Samir Samanta on 07/07/21.
//

import UIKit

class ListCell: UITableViewCell {

    @IBOutlet weak var lblProfileName: UILabel!
    @IBOutlet weak var profileImg: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    func initializeCellDetails(cellDic :  ProfileList){
        lblProfileName.text = cellDic.name
        profileImg.image = UIImage(named: cellDic.image)
    }
}
