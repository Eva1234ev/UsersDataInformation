//
//  ValidatorError.swift
//  GuideOnCar
//
//  Created by ArtS on 12/24/18.
//  Copyright © 2018 guideoncar. All rights reserved.
//

public enum ValidatorError: Error {
    case clear
    case email
//    case paswordLength
    case mobileNumber
    case chooseCountry
    case isEmpty
}

extension ValidatorError: LocalizedError {
    public var errorDescription: String? {
        switch self {
        case .clear:
            return " "
        case .email:
            return R.string.localizable.pleaseEnterAValidEmail()
//        case .paswordLength:
//            return "Password must contain at least 8 characters"
        case .mobileNumber:
            return R.string.localizable.pleaseEnterAValidPhoneNumber()
        case .chooseCountry:
            return R.string.localizable.pleaseChooseYourCountry()
        case .isEmpty:
            return R.string.localizable.pleaseFillAllFields()
        }
    }
}
