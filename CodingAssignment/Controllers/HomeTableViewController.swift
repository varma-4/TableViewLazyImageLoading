//
//  HomeTableViewController.swift
//  CodingAssignment
//
//  Created by Mani on 13/06/18.
//  Copyright © 2018 mani. All rights reserved.
//

import UIKit

class HomeTableViewController: UITableViewController {
    
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
