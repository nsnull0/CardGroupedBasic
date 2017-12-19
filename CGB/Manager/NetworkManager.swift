//
//  NetworkManager.swift
//  CGB
//
//  Created by Yoseph Wijaya on 2017/12/19.
//  Copyright © 2017 paidy. All rights reserved.
//

import Foundation




enum NetworkCondition:Int {
    case noInternet = 1
    case errorNetwork = 2
    case Success = 3
    
    var description:String {
        switch self {
        case .errorNetwork:
            return "Network Error, please contact us about the error"
        case .noInternet:
            return "No Internet Connection, please enable your internet connection"
        case .Success:
            return ""
        }
    }
}

class NetworkManager {
    static private let CARD_LINK_URL_STRING = "http://www.mocky.io/v2/5a275eb23000006e3c0e8a5e"
    
    
    func fetchData(completeRequest:@escaping ((NetworkCondition, Data?) -> Void)) {
        
        let url = URL(string: NetworkManager.CARD_LINK_URL_STRING)
        
        URLSession.shared.dataTask(with: url!){
            (data, response, err) in
            
            let httpresponse = response as? HTTPURLResponse
            
            guard data != nil else {
                
                completeRequest( httpresponse?.statusCode == 404 ? NetworkCondition.errorNetwork : NetworkCondition.noInternet, nil)
                
                return
            }
            
            completeRequest(NetworkCondition.Success, data)
            
        }.resume()
        
        
    }
    
}
