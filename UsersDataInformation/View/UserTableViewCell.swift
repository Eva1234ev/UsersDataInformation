//
//  UserTableViewCell.swift
//  TestSwiftforme
//
//  Created by Eva on 9/22/19.
//  Copyright © 2019 Eva. All rights reserved.
//

import UIKit
import SDWebImage

class UserTableViewCell: UITableViewCell {

    @IBOutlet private var userView: UIView!
    @IBOutlet private var userImage: UIImageView!
    @IBOutlet private var userFullNameLabel: UILabel!
    @IBOutlet private var userEmailLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        userView.layer.cornerRadius = 10
        userView.layer.masksToBounds = true
        userImage.layer.cornerRadius =  userImage.frame.height/2
        userImage.layer.masksToBounds = true
    }

    func configure(with user: UserDataForm?) {
        if let user = user {
            userFullNameLabel.text = user.first_name + " " + user.last_name
            userEmailLabel.text = user.email
            userImage.sd_setImage(with: URL(string: user.avatar), placeholderImage: UIImage(named: "placeholder.png"))
            userView.alpha = 1
        } else {
    
            userView.alpha = 0
        }
    }

}
