//
//  Card.swift
//  CGB
//
//  Created by Yoseph Wijaya on 2017/12/19.
//  Copyright © 2017 paidy. All rights reserved.
//

import Foundation
import UIKit

enum CurrencyType:String{
    case JPY = "JPY"
    
    var getCur:String{
        switch self {
        case .JPY:
            return "¥"
            
        }
    }
}

struct Card {
    let id:String
    let date:String
    let amount:String
    let currency:String
    let description:String
    let kind:String
    
    //Experimental because I don't see any dynamical/photo content at mock up assignment
    let heightContent:CGFloat
    
    init(_ id:String,
         date:String,
         amount:String,
         currency:String,
         description:String,
         kind:String,
         heightContent:CGFloat) {
        self.id = id
        
        if date.characters.count > 0 {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
            let dateF = dateFormatter.date(from:date)
            let calendar = Calendar.current
            let components = calendar.dateComponents([.year, .month, .day, .hour], from: dateF!)
            let finalDate = calendar.date(from:components)
            
            dateFormatter.dateFormat = "yyyy/MM/dd"
            self.date = dateFormatter.string(from: finalDate!)
        }else{
            self.date = ""
        }
        
        let getCur = CurrencyType.init(rawValue: currency)
        if kind != "capture" && kind.characters.count > 0 {
            self.amount = "-\(getCur != nil ? getCur!.getCur : "")\(amount.getStringFromCustomRange(_startIndex: 1, _countLength: amount.characters.count - 1))"
        }else{
            self.amount = "\(getCur != nil ? getCur!.getCur : "")\(amount)"
        }
        
        
        
        self.currency = currency
        self.description = description
        self.kind = kind
        self.heightContent = heightContent
    }
    
}
