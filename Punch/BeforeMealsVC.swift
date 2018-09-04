//
//  BeforeMealsVC.swift
//  Punch
//
//  Created by Steven Ramirez on 8/18/18.
//  Copyright © 2018 Steven Ramirez. All rights reserved.
//

import UIKit

class BeforeMealsVC: UIViewController {

    @IBOutlet weak var totalCarbsTextField: UITextField!
    
    @IBOutlet weak var bloodSugarTextField: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    
    func calculateInsulin(carbs: Double, bloodSugar: Double, icRatio: Double, correctionFactor: Double) -> Double {
        
        let carbResult = Double(round(carbs / icRatio))
        
        var bloodResult: Double = 0
        
        if bloodSugar - 150 > 1 {
            bloodResult = (bloodSugar - 150) / correctionFactor
        }
        
        let wholeBloodResult = Double(Int(bloodResult))
        
        let fractionBloodResult = bloodResult - wholeBloodResult
        
        var roundedFraction: Double
        
        if fractionBloodResult < 0.25 {
            roundedFraction = 0
        } else if fractionBloodResult >= 0.25 && fractionBloodResult < 0.75 {
            roundedFraction = 0.5
        } else {
            roundedFraction = 1
        }
        
        let finalBloodResult = wholeBloodResult + roundedFraction
        
        let insulinResult = carbResult + finalBloodResult
        
        return insulinResult
    }

    

    @IBAction func didTapeCalculate(_ sender: Any) {
        
        guard
            let totalCarbsText = totalCarbsTextField.text,
            let totalCarbs = Double(totalCarbsText),
            let bloodSugarText = bloodSugarTextField.text,
            let bloodSugar = Double(bloodSugarText),
            let userData = UserDefaults.standard.data(forKey: "UserSettings")
            else { return }

        
        do {
            
            let userSettings = try JSONDecoder().decode(UserSettings.self, from: userData)
            
            let totalInsulin = calculateInsulin(carbs: totalCarbs, bloodSugar: bloodSugar, icRatio: userSettings.beforeBreakfastCorrectionFactor, correctionFactor: userSettings.beforeBreakfastCorrectionFactor)
            
            performSegue(withIdentifier: "segue.Main.beforeMealsToTotal", sender: totalInsulin)
            
        } catch {
            print(error)
        }
        

        
    }
    
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        
        
        
        if let totalVC = segue.destination as? TotalVC, let insulin = sender as? Double {
            let insulinString = String(insulin)
            totalVC.totalInsulin = insulinString
            
        }
    }
    
    
    
    
    
}
