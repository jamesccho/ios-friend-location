//
//  FriendTableViewCell.swift
//  FriendLocationSample
//
//  Created by James Chan on 5/4/2018.
//  Copyright © 2018 James Chan. All rights reserved.
//

import Foundation
import UIKit
import SnapKit

class FriendTableViewCell: UITableViewCell {
    
    let icon: UIImageView = UIImageView()
    let name: UILabel = UILabel()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.addSubview(icon)
        contentView.addSubview(name)
        
        icon.snp.makeConstraints { (make) in
            make.width.height.equalTo(50)
            make.left.top.equalTo(contentView).offset(8)
            make.bottom.equalTo(contentView).offset(-8)
        }

        name.snp.makeConstraints { (make) in
            make.left.equalTo(icon.snp.right).offset(8)
            make.right.equalTo(contentView).offset(-8)
            make.centerY.equalTo(contentView)
        }

    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
