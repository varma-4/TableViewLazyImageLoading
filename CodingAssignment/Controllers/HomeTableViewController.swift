//
//  HomeTableViewController.swift
//  CodingAssignment
//
//  Created by Mani on 13/06/18.
//  Copyright © 2018 mani. All rights reserved.
//

import UIKit

class HomeTableViewController: UITableViewController {
    
    lazy var tableRefreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action:
            #selector(self.handleRefresh(_:)),
                                 for: UIControlEvents.valueChanged)
        refreshControl.tintColor = UIColor.black
        return refreshControl
    }()
    
    var itemsList = [ACModel]() {
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
    
    @objc func handleRefresh(_ refreshControl: UIRefreshControl) {
        refreshControl.endRefreshing()
        fetchItems()
    }
    
    func registerCustomCell() {
        self.tableView.register(HomeTableViewCell.self, forCellReuseIdentifier: TABLE_REUSE_IDENTIFIER)
    }
    
    func configureTableView() {
        // Set Tableview background color
        self.view.backgroundColor = .white
        // Set TableView footerView
        self.tableView.tableFooterView = UIView()
        // Set refresh Control for tableView for pulling latest data from Server
        self.refreshControl = tableRefreshControl
        
        // Set tableView to SafeAreaGuides for clean design in iPhone X
        if #available(iOS 11.0, *) {
            let safeAreaGuide = self.view.safeAreaLayoutGuide
            self.tableView.leftAnchor.constraint(equalTo: safeAreaGuide.leftAnchor).isActive = true
            self.tableView.topAnchor.constraint(equalTo: safeAreaGuide.topAnchor).isActive = true
            self.tableView.rightAnchor.constraint(equalTo: safeAreaGuide.rightAnchor).isActive = true
            self.tableView.bottomAnchor.constraint(equalTo: safeAreaGuide.bottomAnchor).isActive = true
        }
        
    }
    
    func fetchItems() {
        // Show Alert to user when Network is Offline
        if !Reachability.isConnectedToNetwork() {
            showAlert(with: "No Internet Connection")
            return
        }
        
        NetworkManager.sharedManager.fetchJSONData(from: JSON_URL_PATH) { [weak self] (data, error) in
            guard let utf8DataUnwrapped = data, let `self` = self else {
                return
            }

            do {
                let jsonResponses = try JSONSerialization.jsonObject(with: utf8DataUnwrapped, options: JSONSerialization.ReadingOptions())
                
                if let itemsDictionary = jsonResponses as? [String : Any], let title = itemsDictionary[JSON_ITEM_TITLE] as? String, var itemsArray = itemsDictionary[JSON_DATA_ROWS] as? [[String: Any]] {
                    // Update Navigation bar Title in Main Queue
                    DispatchQueue.main.async {
                        self.navigationItem.title = title
                    }
                    
                    // Filter Array & remove objects where all values are null
                    itemsArray = itemsArray.filter({
                        !(($0[JSON_ITEM_TITLE] as? String) == nil && ($0[JSON_DATA_DESC] as? String) == nil && ($0[JSON_DATA_IMAGE] as? String) == nil)
                    })
                    
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
    
    func showAlert(with message: String) {
        let alertController = UIAlertController(title: ALERT_TITLE, message: message, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        self.present(alertController, animated: true, completion: nil)
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
        let item = itemsList[indexPath.row]
        
        cell.itemTitle.text = item.itemTitle
        cell.itemDescription.text = item.itemDescription
        cell.itemImageView.image = #imageLiteral(resourceName: "noImage")
        cell.itemDescription.numberOfLines = item.itemDescription != nil ? cell.itemDescription.numberOfLines : 0
        
        if let imageCached = imageCache.object(forKey: item.imageString as AnyObject) as? UIImage {
            cell.itemImageView.image = imageCached
        } else {
            cell.itemImageView.loadImageWithURL(urlString: item.imageString)
        }
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return TABLE_VIEW_ESTIMATED_ROW_HEIGHT
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
}
