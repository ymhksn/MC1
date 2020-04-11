//
//  ViewController.swift
//  MC1
//
//  Created by Yohanes Markus Heksan on 11/04/20.
//  Copyright © 2020 Yohanes Markus Heksan. All rights reserved.
//

import UIKit

class CategoryVC: UIViewController {
    
    @IBOutlet weak var selectedCategoryTableView: UITableView!
    @IBOutlet weak var categoryTableView: UITableView!
 
    var selectedCategories = ["Please work", "I don't know what to do", "Yeay"]
    var categories = ["Gym", "Work", "Sleep"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //DataSource Protocol
        selectedCategoryTableView.dataSource = self
        categoryTableView.dataSource = self
        
        //Register custom Nib for cell
        selectedCategoryTableView.register(UINib(nibName: "CategoryTVCell", bundle: nil), forCellReuseIdentifier: "reusableTVCell")
        categoryTableView.register(UINib(nibName: "CategoryTVCell", bundle: nil), forCellReuseIdentifier: "reusableTVCell")
    }
    
}

//MARK: - Data Source
extension CategoryVC: UITableViewDataSource{
    func tableView(_ tableView: UITableView,  numberOfRowsInSection section: Int) -> Int {
        //Populate two tables at the same time
        var categoryRow = 1
        switch tableView {
        case selectedCategoryTableView:
            categoryRow = selectedCategories.count
        case categoryTableView:
            categoryRow = categories.count
        default:
            print("Can not count array")
        }
        return categoryRow
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //Populate two tables at the same time
        var cell = UITableViewCell()
        switch tableView {
        case selectedCategoryTableView:
            cell = tableView.dequeueReusableCell(withIdentifier: "reusableTVCell", for: indexPath) as! CategoryTVCell
            cell.textLabel?.text = selectedCategories[indexPath.row]
        case categoryTableView :
            cell = tableView.dequeueReusableCell(withIdentifier: "reusableTVCell", for: indexPath) as! CategoryTVCell
            cell.textLabel?.text = categories[indexPath.row]
        default:
            print("Can not populate row from array")
        }
        return cell
    }
}
