//
//  CardManager.swift
//  CGB
//
//  Created by Yoseph Wijaya on 2017/12/19.
//  Copyright © 2017 paidy. All rights reserved.
//

import Foundation
import UIKit

protocol CardProtocol {
    func itemIsLoaded(Correctly:Bool)
}

class CardManager {

    static let heightContentDefaultTapap:CGFloat = 100
    static let heightContentDefaultUntap:CGFloat = 60
    
    var delegate:CardProtocol?
    var cardCollections:[Card] = []
    
    func load(data:Data){
        
        do {
            guard let JSONData = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? [[String: Any]] else {
                return
            }
            cardCollections.removeAll()
            for content in JSONData {
                let card:Card = Card(content["id"] as? String ?? "",
                                     date: content["pushed_at"] as? String ?? "",
                                     amount: "\(content["amount"] ?? "")",
                                     currency: content["currency"] as? String ?? "",
                                     description: content["description"] as? String ?? "",
                                     kind: content["kind"] as? String ?? "",
                                     heightContent: CardManager.heightContentDefaultTapap)
                cardCollections.append(card)
            }
            
            self.delegate?.itemIsLoaded(Correctly: true)
            
        } catch  {
            self.delegate?.itemIsLoaded(Correctly: false)
        }
        
        
    }
    
    
}
