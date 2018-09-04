//
//  TotalVC.swift
//  Punch
//
//  Created by Steven Ramirez on 8/14/18.
//  Copyright © 2018 Steven Ramirez. All rights reserved.
//

import UIKit

class TotalVC: UIViewController {

    @IBOutlet weak var resultLabel: UILabel!
    
    
    var totalInsulin : String?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        resultLabel.text = totalInsulin
    }

    
    

}
