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
            DispatchQueue.main.async { [weak self] in
                guard let `self` = self else { return }
                self.tableView.reloadData()
            }
        }
    }
    
    override func loadView() {
        super.loadView()
        configureTableView()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        registerCustomCell()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        fetchItems()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func registerCustomCell() {
        self.tableView.register(HomeTableViewCell.self, forCellReuseIdentifier: TABLE_REUSE_IDENTIFIER)
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
        if reachability.connection.description == NETWORK_STATUS_OFFLINE {
            // TODO:- Show Alert
        }
        
        NetworkManager.sharedManager.fetchJSONData(from: JSON_URL_PATH) { [weak self] (data, error) in
            guard let utf8DataUnwrapped = data, let `self` = self else {
                return
            }

            do {
                let jsonResponses = try JSONSerialization.jsonObject(with: utf8DataUnwrapped, options: JSONSerialization.ReadingOptions())
                
                if let itemsDictionary = jsonResponses as? [String : Any], let title = itemsDictionary[JSON_ITEM_TITLE] as? String, let itemsArray = itemsDictionary[JSON_DATA_ROWS] as? NSArray {
                    // Update Navigation bar Title in Main Queue
                    DispatchQueue.main.async {
                        self.navigationItem.title = title
                    }
                    
                    // Decode each itemDictionary object from the array using map
                    let decoder = JSONDecoder()
                    self.itemsList = try itemsArray.map({
                        return try decoder.decode(ACModel.self, from: JSONSerialization.data(withJSONObject: $0, options: .prettyPrinted) as Data)
                    })
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
        return itemsList.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: TABLE_REUSE_IDENTIFIER, for: indexPath) as? HomeTableViewCell else { return UITableViewCell() }
        
        cell.itemTitle.text = itemsList[indexPath.row].itemTitle
        cell.itemDescription.text = itemsList[indexPath.row].itemDescription
        cell.itemImageView.image = nil
        cell.itemDescription.numberOfLines = 5
        
        if let imageCached = imageCache.object(forKey: itemsList[indexPath.row].imageString as AnyObject) as? UIImage {
            cell.itemImageView.image = imageCached
        } else {
            cell.itemImageView.loadImageWithURL(urlString: itemsList[indexPath.row].imageString)
        }
//        cell.imageView?.loadImageWithURL(urlString: itemsList[indexPath.row].imageString)
//        cell.updateConstraintsIfNeeded()
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
}
