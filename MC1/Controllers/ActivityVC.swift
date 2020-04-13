//
//  ActivityVC.swift
//  MC1
//
//  Created by Yohanes Markus Heksan on 13/04/20.
//  Copyright © 2020 Yohanes Markus Heksan. All rights reserved.
//

import UIKit
import CoreData

class ActivityVC: UIViewController {
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

//    var selectedActivity : Category? {
//        didSet{
//            loadActivity()
//        }
//    }
    var selectedActivity = Category()

    override func viewDidLoad() {
        super.viewDidLoad()
        print(selectedActivity.name)
    }

}
