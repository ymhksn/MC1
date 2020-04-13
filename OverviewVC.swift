//
//  OverviewVC.swift
//  MC1
//
//  Created by Yohanes Markus Heksan on 12/04/20.
//  Copyright © 2020 Yohanes Markus Heksan. All rights reserved.
//

import UIKit
import CoreData

private let reuseIdentifier = "categoryCV"

class OverviewVC: UIViewController{
    @IBOutlet weak var workLifeBalancer: UISlider!
    @IBOutlet weak var selectedCategoryCollectionView: UICollectionView!
    
    //CoreData
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    var categories = [Category]()
    var userSelectedActivityIndexPath = 0
  
    override func viewDidLoad() {
        super.viewDidLoad()
        workLifeBalancer.setThumbImage(UIImage(), for: .normal)
        navigationController?.isNavigationBarHidden = true
        
        //DataSource & Delegate Protocol
        selectedCategoryCollectionView.dataSource = self
        selectedCategoryCollectionView.delegate = self
                        
        loadCategory()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        loadCategory()
        selectedCategoryCollectionView.reloadData()
    }
    
    //MARK: - CoreData Func
    func loadCategory() {
        //Fetch Data
        let request: NSFetchRequest<Category> = Category.fetchRequest()
        
        //Query Data
        let predicate = NSPredicate(format: "checked MATCHES %@", "check")
        request.predicate = predicate
        
        //Sort Data
        let sortDescriptor = NSSortDescriptor(key: "color", ascending: false)
        request.sortDescriptors = [sortDescriptor]
        
        do {
            categories = try context.fetch(request)
        } catch {
            print("Error loading from DB \(error)")
        }
    }
}
//MARK: - Collection View Data Source
extension OverviewVC: UICollectionViewDataSource{
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return (section == 0) ? categories.count : 1
    }
       
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "categoryCV", for: indexPath) as! CategoryCVCell
        //Rounded corner for cell
        cell.categoryViewCell.layer.cornerRadius = cell.categoryViewCell.frame.size.height/8
        
        //Populate data from CoreData for sect. 1 and 2 using conditional statement.
        if indexPath.section == 0 {
            //Data from CoreData
            cell.categoryTitleCV?.text = categories[indexPath.row].name

            let colorSwitcher = categories[indexPath.row].color
            switch colorSwitcher {
            case "red1":
                cell.categoryImageCV.image = UIImage(named: "iconWork")
            case "red2":
                cell.categoryImageCV.image = UIImage(named: "iconSelfDev")
            case "red3":
                cell.categoryImageCV.image = UIImage(named: "iconHousehold")
            case "green1":
                cell.categoryImageCV.image = UIImage(named: "iconMeditate")
            case "green2":
                cell.categoryImageCV.image = UIImage(named: "iconHobby")
            case "green3":
                cell.categoryImageCV.image = UIImage(named: "iconFamily")
            case "green4":
                cell.categoryImageCV.image = UIImage(named: "iconHangout")
            case "green5":
                cell.categoryImageCV.image = UIImage(named: "iconEntertainment")
            case "green6":
                cell.categoryImageCV.image = UIImage(named: "iconExercise")
            case "green7":
                cell.categoryImageCV.image = UIImage(named: "iconSleep")
            default:
                print("Error get data from CoreData")
            }
        } else {
            cell.categoryTitleCV?.text = "Add"
            cell.categoryImageCV.image = UIImage(named: "iconAdd")
        }
        return cell
    }
}

//MARK: - Collection View Delegate
extension OverviewVC: UICollectionViewDelegate{
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if indexPath.section == 0 {
            performSegue(withIdentifier: "goToReports", sender: self)
            userSelectedActivityIndexPath = indexPath.row
        } else {
            performSegue(withIdentifier: "goToAddActivity", sender: self)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        //check if it really go to the right segue
        if segue.identifier == "goToReports" {
            //assign the value from this VC to destinationVC and get the method & properties of destinationVC
            let destinationVC = segue.destination as? ActivityVC
            destinationVC?.selectedActivity = categories[userSelectedActivityIndexPath]
        }
            
    }
}

//MARK: - Custom Height for UISlider
class CustomSlider: UISlider {
    override func trackRect(forBounds bounds: CGRect) -> CGRect {
        let point = CGPoint(x: bounds.minX, y: bounds.midY)
        return CGRect(origin: point, size: CGSize(width: bounds.width, height: 20))
    }
}
