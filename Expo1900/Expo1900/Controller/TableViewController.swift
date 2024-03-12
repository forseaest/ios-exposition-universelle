//
//  TableViewController.swift
//  Expo1900
//
//  Created by H on 3/12/24.
//

import UIKit

class TableViewController: UITableViewController {

    var list: [Item] = []
    
    @IBOutlet var itemsTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let asset = NSDataAsset.init(name: "items") else {
            return
        }
        
        let decoder = JSONDecoder()
        
        do {
            list = try decoder.decode([Item].self, from: asset.data)
        } catch {
            print(error.localizedDescription)
        }
        
        itemsTableView.delegate = self
        itemsTableView.dataSource = self
        
        itemsTableView.estimatedRowHeight = 100
        itemsTableView.rowHeight = UITableView.automaticDimension
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return list.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: TableViewCell = itemsTableView.dequeueReusableCell(withIdentifier: "itemCell", for: indexPath) as! TableViewCell
        let item: Item = list[indexPath.row]
        
        cell.nameLabel.text = "\(item.name)"
        cell.shortDescriptionLabel.text = "\(item.summary)"
        cell.itemImageView.image = UIImage(named: "\(item.imageUrl)")
        
        return cell
    }
}