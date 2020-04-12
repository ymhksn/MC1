//
//  ViewController.swift
//  MC1
//
//  Created by Yohanes Markus Heksan on 11/04/20.
//  Copyright © 2020 Yohanes Markus Heksan. All rights reserved.
//

import UIKit
import CoreData

class CategoryVC: UIViewController {
    
    @IBOutlet weak var selectedCategoryTableView: UITableView!
    @IBOutlet weak var categoryTableView: UITableView!
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    //var to store data from CoreData DB temp
    var selectedCategories = [Category]()
    var categories = [Category]()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //DataSource & Delegate Protocol
        selectedCategoryTableView.dataSource = self
        selectedCategoryTableView.delegate = self
        categoryTableView.dataSource = self
        categoryTableView.delegate = self
        
        //Register custom Nib for cell
        selectedCategoryTableView.register(UINib(nibName: "CategoryTVCell", bundle: nil), forCellReuseIdentifier: "reusableTVCell")
        categoryTableView.register(UINib(nibName: "CategoryTVCell", bundle: nil), forCellReuseIdentifier: "reusableTVCell")
        
        /*
        //Save data to CoreData
        let categories = Category(context: context)
        categories.name = "Work"
        categories.color = "red1"
        saveCategory()
        */
        
        loadCategory()
    }
    
    //MARK: - CoreData Func
    //CoreData Create
    func saveCategory() {
        do {
            try context.save()
        } catch {
            print("Error saving to DB \(error)")
        }
        
    }
    
    //CoreData Read
    func loadCategory() {
        //Fetch Data
        let requestCheck: NSFetchRequest<Category> = Category.fetchRequest()
        let requestUncheck: NSFetchRequest<Category> = Category.fetchRequest()
        
        //Query Data
        let checkPredicate = NSPredicate(format: "checked MATCHES %@", "check")
        let uncheckPredicate = NSPredicate(format: "checked MATCHES %@", "uncheck")
        
        requestCheck.predicate = checkPredicate
        requestUncheck.predicate = uncheckPredicate
        
        do {
            selectedCategories = try context.fetch(requestCheck)
            categories = try context.fetch(requestUncheck)
        } catch {
            print("Error loading from DB \(error)")
        }
        
    }
}

//MARK: - TableView DataSource
extension CategoryVC: UITableViewDataSource{
    func tableView(_ tableView: UITableView,  numberOfRowsInSection section: Int) -> Int {
        //Populate two tables at the same time
        var categoryRow = 0
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
            cell.textLabel?.text = selectedCategories[indexPath.row].name
        case categoryTableView :
            cell = tableView.dequeueReusableCell(withIdentifier: "reusableTVCell", for: indexPath) as! CategoryTVCell
            cell.textLabel?.text = categories[indexPath.row].name
        default:
            print("Can not populate row from array")
        }
        return cell
    }
}

//MARK: - TableView Delegate
extension CategoryVC: UITableViewDelegate{
    //update category from user click
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if tableView == selectedCategoryTableView {
            selectedCategories[indexPath.row].checked = "uncheck"
            selectedCategories.remove(at: indexPath.row)
        } else if tableView == categoryTableView{
            categories[indexPath.row].checked = "check"
            categories.remove(at: indexPath.row)
        }
        
        saveCategory()
        loadCategory()
        tableView.deselectRow(at: indexPath, animated: true)
        categoryTableView.reloadData()
        selectedCategoryTableView.reloadData()
    }
}

