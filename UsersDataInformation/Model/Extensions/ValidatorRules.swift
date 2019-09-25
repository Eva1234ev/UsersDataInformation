//
//  ValidatorRule.swift
//  Yungo
//
//  Created by ArtS on 1/11/19.
//  Copyright © 2019 Yungo. All rights reserved.
//

import PhoneNumberKit

struct ValidationRuleMobileNumber: ValidationRule {
    
    typealias InputType = String
    var error: Error
    
    init(error: Error) {
        self.error = error
    }
    
    func validate(input: String?) -> Bool {
        guard let input = input else { return false }
        
        do {
            let _ = try phoneNumberKit.parse(input, withRegion: AppManager.userCountry)
            return true
        } catch {
            return false
        }
    }
    
}
