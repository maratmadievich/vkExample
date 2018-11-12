//
//  CrossRoadController.swift
//  homeWork_1
//
//  Created by Admin on 12.11.2018.
//  Copyright © 2018 Марат Нургалиев. All rights reserved.
//

import UIKit

class CrossRoadController: UIViewController {

    private var selectedHomework = -1
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func buttonHomeWork1Clicked(_ sender: Any) {
        selectedHomework = 1
        performSegue(withIdentifier: "showVkAuth", sender: nil)
    }
    
    
    @IBAction func buttonHomeWork2Clicked(_ sender: Any) {
        selectedHomework = 2
        performSegue(withIdentifier: "showVkAuth", sender: nil)
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showVkAuth" {
            let upcoming = segue.destination as! LoginVkViewController
            upcoming.selectedHomework = selectedHomework
            
        }
    }

}
