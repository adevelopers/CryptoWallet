//
//  Bar.swift
//  CryptoWallet
//
//  Created by Kirill Khudiakov on 21/03/2019.
//  Copyright © 2019 Kirill Khudiakov. All rights reserved.
//

import Foundation


struct Bar: Codable {
    var time: Int
    var close: Float
    var high: Float
    var low: Float
    var open: Float
    var volumefrom: Float
    var volumeto: Float
}

extension Bar : CustomStringConvertible {
    var description: String {
        let date = Date(timeIntervalSince1970: Double(time))
        let formatter = DateFormatter()
        formatter.dateFormat = "Y.MM.dd HH:mm"
        
        return "\ntime: \(formatter.string(from: date)) close \(close) "
    }
}


/*
 "TimeTo": 1553126400,
 "TimeFrom": 1550534400,
 "FirstValueInArray": true,
 "ConversionType": {
 "type": "direct",
 "conversionSymbol": ""
 },
 "RateLimit": {},
 "HasWarning": false
 */
struct HistoryData: Codable {
    var Response: String
    var `Type`: Int
    var Aggregated: Bool
    var Data: [Bar]
    var TimeTo: Int
    var TimeFrom: Int
}
