//
//  CryptoService.swift
//  CryptoWallet
//
//  Created by Kirill Khudiakov on 21/03/2019.
//  Copyright © 2019 Kirill Khudiakov. All rights reserved.
//

import Foundation
import Moya


class CryptoService {
    static let shared = CryptoService()
    
    fileprivate let provider = MoyaProvider<CryptoAPI>()
    
    func get(from: String, to: String, limit: Int, onSuccess: @escaping (HistoryData)->Void) {
        provider.request(.histoday(from, to, limit)) { result in
            switch result {
            case .success(let response):
                do {
                    let countries = try self.decodeCountries(from: response.data)
                    onSuccess(countries)
                } catch {
                    print("error in \(type(of: self))->\(#function)\n\(error.localizedDescription)")
                }
            case .failure(let error):
                print("error in \(type(of: self))->\(#function)\n\(String(describing: error.errorDescription))")
            }
        }
        
    }
    
    private func decodeCountries(from data: Data) throws -> HistoryData {
        return try JSONDecoder().decode(HistoryData.self, from: data)
    }
    
}
