//
//  ViewController.swift
//  UsersDataInformation
//
//  Created by Eva on 9/23/19.
//  Copyright © 2019 Eva. All rights reserved.
//

import UIKit
import KRPullLoader

class ViewController: UIViewController , AlertDisplayer {
    private enum CellIdentifiers {
        static let list = "UserTableViewCell"
    }
    
    @IBOutlet var indicatorView: UIActivityIndicatorView!
    @IBOutlet var tableView: UITableView!

    private var viewModel: UsersViewModel!
    private var shouldShowLoadingCell = false
    @IBOutlet var leadingC: NSLayoutConstraint!
    @IBOutlet var trailingC: NSLayoutConstraint!
    
    @IBOutlet var ubeView: UIView!
     var menuIsVisible = false
    
    @IBAction func menuBtnTapped(_ sender: Any) {
        if !menuIsVisible {
            leadingC.constant = 150
            trailingC.constant = -150
             menuIsVisible = true
        } else {
            leadingC.constant = 0
            trailingC.constant = 0
            menuIsVisible = false
        }
        
        UIView.animate(withDuration: 0.2, delay: 0.0, options: .curveEaseIn, animations: {
            self.view.layoutIfNeeded()
        }) { (animationComplete) in
            print("The animation is complete!")
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        indicatorView.startAnimating()
        tableView.dataSource = self
       
        let loadMoreView = KRPullLoadView()
        loadMoreView.delegate = self
        tableView.addPullLoadableView(loadMoreView, type: .loadMore)
        
        tableView.contentInset.top = 50
        tableView.contentInset.bottom = 50

        viewModel = UsersViewModel(delegate: self)
        viewModel.fetchUsers()
    }
    
}
// MARK: - KRPullLoadView delegate -------------------
extension ViewController: KRPullLoadViewDelegate {
    func pullLoadView(_ pullLoadView: KRPullLoadView, didChangeState state: KRPullLoaderState, viewType type: KRPullLoaderType) {
        if type == .loadMore {
            switch state {
            case let .loading(completionHandler):
                
                DispatchQueue.main.asyncAfter(deadline: DispatchTime.now()+1) {
                    completionHandler()
                   self.viewModel.fetchUsers()
                }
            default: break
            }
            return
        }
    }
    
}



extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    
        return viewModel.currentCount
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CellIdentifiers.list, for: indexPath) as! UserTableViewCell
       
        if isLoadingCell(for: indexPath) {
            cell.configure(with: .none)
        } else {
            cell.configure(with: viewModel.user(at: indexPath.row))
        }
        return cell
    }
}


extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return (tableView.frame.size.height-(CGFloat(viewModel.userPagingData)*10))/CGFloat(viewModel.userPagingData);
    }

}


extension ViewController: UsersViewModelDelegate {
    func onFetchCompleted(with newIndexPathsToReload: [IndexPath]?) {
       
            indicatorView.stopAnimating()
           
        tableView.reloadData()
//        let indexPathsToReload = visibleIndexPathsToReload(intersecting: newIndexPathsToReload)
//        tableView.reloadRows(at: indexPathsToReload, with: .automatic)
    }
    
    func onFetchFailed(with reason: String) {
        indicatorView.stopAnimating()
        let action = UIAlertAction(title: "OK", style: .default)
        displayAlert(with: "Heey" , message: reason, actions: [action])
    }
}

private extension ViewController {
    func isLoadingCell(for indexPath: IndexPath) -> Bool {
        return indexPath.row >= viewModel.currentCount
    }
    
}

