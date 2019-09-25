//
//  Encodable.swift
//  TestSwiftforme
//
//  Created by Eva on 9/20/19.
//  Copyright © 2019 Eva. All rights reserved.
//

import Foundation

extension Encodable {
    
    func toJSONData() -> Data? {
        return try? JSONEncoder().encode(self)
    }
    
}
