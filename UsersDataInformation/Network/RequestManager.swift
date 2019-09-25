//
//  RequestManager.swift
//  TestSwiftforme
//
//  Created by Eva on 9/20/19.
//  Copyright © 2019 Eva. All rights reserved.
//

import UIKit

final class RequestManager: NSObject {
    

    private static let usersPath = "https://reqres.in/api/users?page="
    
    static func getUsersPage( number: String?, completionHandler: @escaping CompletionHandler<User>, errorHandler: @escaping ErrorHandler) {
        let escapedString = "https://reqres.in/api/users?page="//usersPath + number
        let url = URL(string: escapedString + number!)!
        URLSession.shared.executeTask(with: url, httpMethod: .get, completionHandler: { (data, response, error) in
            check(data: data, response: response, error: error, completionHandler: { (data) in
                data?.decodeToJSON(with: User.self, completionHandler: completionHandler, errorHandler: errorHandler)
            }, errorHandler: errorHandler, repeatHendler: {
               
                getUsersPage(number:number, completionHandler: completionHandler, errorHandler: errorHandler)
               
            })
        }).resume()
    }
    
    
    private static func check(data: Data?, response: URLResponse?, error: Error?, completionHandler: @escaping (Data?) -> Void, errorHandler: ErrorHandler, repeatHendler: (()->())?) {
        if let statusCode = (response as? HTTPURLResponse)?.statusCode, statusCode >= 200, statusCode < 300 {
            completionHandler(data)
        } else if let error = error as? URLError, ((error.code == .notConnectedToInternet) || (error.code == .networkConnectionLost)) {
            errorHandler(nil)
        } else if let statusCode = (response as? HTTPURLResponse)?.statusCode, statusCode == 423 {
            errorHandler(nil)

        } else if let statusCode = (response as? HTTPURLResponse)?.statusCode, statusCode == 401 {
            if let repeatHendler = repeatHendler {
                repeatHendler()
            } else {
                errorHandler(CustomError(errorDescription: HTTPURLResponse.localizedString(forStatusCode: statusCode)))
            }
        } else if let error = error {
            errorHandler(error)
        } else if let statusCode = (response as? HTTPURLResponse)?.statusCode {
            errorHandler(CustomError(errorDescription: HTTPURLResponse.localizedString(forStatusCode: statusCode)))
        } else {
            errorHandler(CustomError(errorDescription: "Unknown Error"))
        }
}
    
}
