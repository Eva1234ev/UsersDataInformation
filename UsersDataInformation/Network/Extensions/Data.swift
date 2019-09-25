//
//  Data.swift
//  TestSwiftforme
//
//  Created by Eva on 9/20/19.
//  Copyright © 2019 Eva. All rights reserved.
//

import Foundation
typealias CompletionHandler<T> = (_ data: T)->()
typealias ErrorHandler = (_ error: Error?)->()
extension Data {
    
    func decodeToJSON<T: Decodable>(with type: T.Type, completionHandler: CompletionHandler<T>, errorHandler: ErrorHandler) {
        do {
            let json = try JSONDecoder().decode(T.self, from: self)
            completionHandler(json)
        } catch {
            errorHandler(error)
        }
    }
    
    func convertToJSON() -> Any? {
        do {
            return try JSONSerialization.jsonObject(with: self, options: .allowFragments)
        } catch {
            print("JSONSerialization error ---------- ", error.localizedDescription)
        }
        return nil
    }
    
    var hexString: String {
        let hexString = map { String(format: "%02.2hhx", $0) }.joined()
        return hexString
    }
}
