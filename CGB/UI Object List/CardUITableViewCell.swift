//
//  CardUITableViewCell.swift
//  CGB
//
//  Created by Yoseph Wijaya on 2017/12/19.
//  Copyright © 2017 paidy. All rights reserved.
//

import UIKit

enum TypeCardCell {
    case first
    case middle
    case last
}



class CardUITableViewCell: UITableViewCell {

    @IBOutlet weak var photoImageView: UIImageView!
    
    @IBOutlet weak var backgroundContentItemView: UIView!
    
    @IBOutlet weak var heightContentConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var contentFlagBot: UIView!
    
    @IBOutlet weak var contentFlagTop: UIView!
    
    
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var kindLabel: UILabel!
    
    @IBOutlet weak var borderBot: UIView!
    
    
    @IBOutlet weak var topConstraints: NSLayoutConstraint!
    
    @IBOutlet weak var botConstraints: NSLayoutConstraint!
    
    private var defaultColor:UIColor = UIColor.white
    
    override func awakeFromNib() {
        super.awakeFromNib()
        defaultColor = self.kindLabel.backgroundColor!
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

    func setup(cardData:Card, type:TypeCardCell){
        backgroundContentItemView.isHidden = true
        self.contentFlagBot.isHidden = true
        self.contentFlagTop.isHidden = true
        self.borderBot.isHidden = false
        self.photoImageView.layer.cornerRadius = 5
        self.topConstraints.constant = 0
        self.botConstraints.constant = 0
        
        if type == .first {
            self.topConstraints.constant = 5
            self.contentFlagTop.isHidden = true
            self.contentFlagBot.isHidden = false
            
        }else if type == .last{
            self.botConstraints.constant = 5
            self.contentFlagTop.isHidden = false
            self.contentFlagBot.isHidden = true
            self.borderBot.isHidden = true
            
        }else {
            self.photoImageView.layer.cornerRadius = 0
        }
        
        
        self.dateLabel.text = cardData.date
        self.descriptionLabel.text = cardData.description
        self.priceLabel.text = cardData.amount
        self.kindLabel.text = cardData.kind
        if cardData.kind != "capture" {
            self.kindLabel.textColor = UIColor.white
            self.kindLabel.backgroundColor = UIColor.darkGray
            
        }else{
            self.kindLabel.textColor = UIColor.black
            self.kindLabel.backgroundColor = defaultColor
            
        }
    }
    
}


