//
//  API.swift
//  CryptoWallet
//
//  Created by Kirill Khudiakov on 21/03/2019.
//  Copyright © 2019 Kirill Khudiakov. All rights reserved.
//

import Foundation
import Moya


enum CryptoAPI {
    case histoday(String, String, Int)
}

extension CryptoAPI: TargetType {
    var baseURL: URL {
        return URL(string: "https://min-api.cryptocompare.com/data")!
    }
    
    var path: String {
        switch self {
        case .histoday:
            return "/histoday"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .histoday(_):
            return .get
        }
    }
    
    var sampleData: Data {
        return Data()
    }
    
    var task: Task {
        switch self {
        case .histoday(let fromSymbol, let toSymbol, let limit):
            
            return .requestParameters(parameters: [
                "fsym": fromSymbol,
                "tsym": toSymbol,
                "limit": limit,
                "aggregate": 3
                ],
                encoding: URLEncoding.default)
        }
    }
    
    var headers: [String : String]? {
        return ["Content-type": "application/json"]
    }
}
