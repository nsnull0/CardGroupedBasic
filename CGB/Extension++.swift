//
//  ExtensionPublicList.swift
//  CGB
//
//  Created by Yoseph Wijaya on 2017/12/19.
//  Copyright © 2017 paidy. All rights reserved.
//

import Foundation
import UIKit

extension UIView{
    @IBInspectable
    var shadowRadius: CGFloat {
        get {
            return layer.shadowRadius
        }
        set {
            layer.shadowRadius = newValue
        }
    }
    
    @IBInspectable
    var shadowOpacity: Float {
        get {
            return layer.shadowOpacity
        }
        set {
            layer.shadowOpacity = newValue
        }
    }
    
    @IBInspectable
    var shadowOffset: CGSize {
        get {
            return layer.shadowOffset
        }
        set {
            layer.shadowOffset = newValue
        }
    }
    
    @IBInspectable
    var shadowColor: UIColor? {
        get {
            if let color = layer.shadowColor {
                return UIColor(cgColor: color)
            }
            return nil
        }
        set {
            if let color = newValue {
                layer.shadowColor = color.cgColor
            } else {
                layer.shadowColor = nil
            }
        }
    }
    
    @IBInspectable
    var cornerRadius: CGFloat {
        get {
            return layer.cornerRadius
        }
        set {
            layer.cornerRadius = newValue
        }
    }
}

extension UIImageView {
    
    
    
    
}

extension UILabel {
    
    
    @IBInspectable
    var borderWidth: CGFloat {
        get {
            return layer.borderWidth
        }
        set {
            layer.borderWidth = newValue
        }
    }
}

extension String{
    func getStringFromCustomRange (_startIndex i:Int,_countLength length:Int) -> String {
        let start = self.index(self.startIndex, offsetBy: i)
        let countChar:Int = (-(self.characters.count - i))+length
        let end = self.index(self.endIndex, offsetBy: countChar)
        let range = start..<end
        
        return self.substring(with: range)
    }
}
