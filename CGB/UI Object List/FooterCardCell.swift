//
//  FooterCardCell.swift
//  CGB
//
//  Created by Yoseph Wijaya on 2017/12/19.
//  Copyright © 2017 paidy. All rights reserved.
//

import UIKit

class FooterCardCell: UIView {

    class func instanceFromNib() -> FooterCardCell {
        return UINib(nibName: "FooterCardCell", bundle: nil).instantiate(withOwner: nil, options: nil)[0] as! FooterCardCell
    }

}
