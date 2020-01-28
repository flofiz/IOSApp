//
//  ReceiveCell.swift
//  ProjetIOS
//
//  Created by Florian Fizaine on 27/01/2020.
//  Copyright © 2020 Florian Fizaine. All rights reserved.
//

import UIKit

class ReceiveCell: UITableViewCell {

    @IBOutlet weak var receiveMessageLabel: UILabel!
    @IBOutlet weak var contactProfileImage: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
