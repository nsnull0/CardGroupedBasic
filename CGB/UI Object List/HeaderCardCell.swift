//
//  HeaderCardCell.swift
//  CGB
//
//  Created by Yoseph Wijaya on 2017/12/19.
//  Copyright © 2017 paidy. All rights reserved.
//

import UIKit

class HeaderCardCell: UIView {

    @IBOutlet weak var HeaderTextLabel: UILabel!
    

    class func instanceFromNib() -> HeaderCardCell {
        return UINib(nibName: "HeaderCardCell", bundle: nil).instantiate(withOwner: nil, options: nil)[0] as! HeaderCardCell
    }
    
}
