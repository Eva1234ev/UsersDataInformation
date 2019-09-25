//
//  Error.swift
//  Yungo
//
//  Created by ArtS on 1/24/19.
//  Copyright © 2019 Yungo. All rights reserved.
//

import Foundation

public enum AuthConfirmResponseError: Int, Error {
    case err400 = 400
    case err403 = 403
    case err404 = 404
}

extension AuthConfirmResponseError: LocalizedError {
    public var errorDescription: String? {
        switch self {
        case .err400:
            return R.string.localizable.verificationCodeWasWrongPleaseTryAgain()
        case .err403:
            return R.string.localizable.dearUserYouExceededTheLimitOfAllowableDevicePleaseContactYunGOSupportToIncreaseTheLimit()
        case .err404:
            return R.string.localizable.verificationCodeExpiredOrNotFound()
        }
    }
}

struct CustomError: LocalizedError {
    let errorDescription: String?
}
