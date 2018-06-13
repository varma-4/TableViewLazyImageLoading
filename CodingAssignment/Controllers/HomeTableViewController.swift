//
//  HomeTableViewController.swift
//  CodingAssignment
//
//  Created by Mani on 13/06/18.
//  Copyright © 2018 mani. All rights reserved.
//

import UIKit

class HomeTableViewController: UITableViewController {
    
    fileprivate var itemsList = [ACModel]() {
        didSet {
            self.tableView.reloadData()
        }
    }
    
    override func loadView() {
        super.loadView()
        configureTableView()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        fetchItems()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func configureTableView() {
        // Set Tableview background color
        self.view.backgroundColor = .white
        // Set TableView footerView
        self.tableView.tableFooterView = UIView()
    }
    
    func fetchItems() {
        guard let reachability = Reachability.init() else {
            // TODO:- showAlert
            return
        }
        
        // Show Alert to user when Network is Offline
        if reachability.connection.description == NetworkStatusOffline {
            // TODO:- Show Alert
        }
        
        NetworkManager.sharedManager.fetchJSONData(from: JSON_URL_PATH) { [weak self] (data, error) in
            guard let utf8DataUnwrapped = data, let `self` = self else {
                return
            }

            do {
                let jsonResponses = try JSONSerialization.jsonObject(with: utf8DataUnwrapped, options: JSONSerialization.ReadingOptions())
                
                if let itemsDictionary = jsonResponses as? [String : Any], let title = itemsDictionary[JSON_ITEM_TITLE] as? String, let items = itemsDictionary[JSON_DATA_ROWS] as? [[String: Any]] {
                    // Update Navigation bar Title in Main Queue
                    DispatchQueue.main.async {
                        self.navigationItem.title = title
                        self.itemsList = items.map({
                            return ACModel(dictionary: $0)
                        })
                    }
                }
            } catch {
                print(error.localizedDescription)
            }
        }
        
    }

}

// MARK: - Table view data source
extension HomeTableViewController {

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
    
}
