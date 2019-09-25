//
//  UsersViewModel.swift
//  UsersDataInformation
//
//  Created by Eva on 9/23/19.
//  Copyright © 2019 Eva. All rights reserved.
//

import UIKit
import Foundation

protocol UsersViewModelDelegate: class {
    func onFetchCompleted(with newIndexPathsToReload: [IndexPath]?)
    func onFetchFailed(with reason: String)
}

final class UsersViewModel {
    private weak var delegate: UsersViewModelDelegate?
    
    private var users: [UserDataForm] = []
    private var userPage: User?
    private var currentPage = 1
    private var isFetchInProgress = false

    init(delegate: UsersViewModelDelegate) {

        self.delegate = delegate
       
    }
    var userPagingData: Int {
        return userPage?.per_page ?? 0
    }
    var totalCount: Int {
        return userPage?.total ?? 0
    }
    
    var currentCount: Int {
        return users.count
    }
    
    func user(at index: Int) -> UserDataForm {
        return users[index]
    }
    
    func fetchUsers() {
       
        guard !isFetchInProgress else {
            return
        }

        isFetchInProgress = true
        
        RequestManager.getUsersPage(number: String(currentPage),completionHandler: { response in

            self.currentPage += 1
            self.isFetchInProgress = false
            
            self.userPage = response
            self.users+=response.data

            if response.page > 1 {
                   
                    let indexPathsToReload = self.calculateIndexPathsToReload(from: response.data)
                    self.delegate?.onFetchCompleted(with: indexPathsToReload)
                
            } else {
                self.delegate?.onFetchCompleted(with: .none)
            }
            
        }, errorHandler: { error in
            DispatchQueue.main.async {
                self.isFetchInProgress = false
                self.delegate?.onFetchFailed(with: "No data")
            }
        })

    }
    
    private func calculateIndexPathsToReload(from newUsers: [UserDataForm]) -> [IndexPath] {
        let startIndex = users.count - newUsers.count
        let endIndex = startIndex + newUsers.count
        return (startIndex..<endIndex).map { IndexPath(row: $0, section: 0) }
    }
    
}
