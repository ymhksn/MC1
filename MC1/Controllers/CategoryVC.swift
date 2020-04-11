//
//  ViewController.swift
//  MC1
//
//  Created by Yohanes Markus Heksan on 11/04/20.
//  Copyright © 2020 Yohanes Markus Heksan. All rights reserved.
//

import UIKit

class CategoryVC: UIViewController {
    
    @IBOutlet weak var categoryTableView: UITableView!
    
    var categories = ["Gym", "Work", "Sleep"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //DataSource Protocol
        categoryTableView.dataSource = self
    }
    
}

//MARK: - Data Source
extension CategoryVC: UITableViewDataSource{
    func tableView(_ tableView: UITableView,  numberOfRowsInSection section: Int) -> Int {
        return categories.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "categoryCell", for: indexPath)
        cell.textLabel?.text = categories[indexPath.row]
        return cell
    }
}
