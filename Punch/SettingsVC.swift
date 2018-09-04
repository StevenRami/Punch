//
//  SettingsVC.swift
//  Punch
//
//  Created by Steven Ramirez on 8/14/18.
//  Copyright © 2018 Steven Ramirez. All rights reserved.
//

import UIKit

class SettingsVC: UIViewController {
    
    @IBOutlet weak var targetBloodSugarTextField: UITextField!
    
    @IBOutlet weak var longActingMorningTextField: UITextField!
    
    @IBOutlet weak var longActingEveningTextField: UITextField!
    
    @IBOutlet weak var beforeBreakfastRatioTextField: UITextField!
    
    @IBOutlet weak var beforeBreakfastCorrectionFactorTextField: UITextField!
    
    @IBOutlet weak var beforeLunchTextRatioField: UITextField!
    
    @IBOutlet weak var beforeLunchCorrectionFactorTextField: UITextField!
    
    @IBOutlet weak var beforeDinnerTextRatioField: UITextField!
    
    @IBOutlet weak var beforeDinnerCorrectionFactorTextField: UITextField!
    
    @IBOutlet weak var bedtimeRatioTextField: UITextField!
    
    @IBOutlet weak var bedtimeCorrectionFatorTextField: UITextField!
    
    @IBOutlet weak var unitPenRadioButton1: DLRadioButton!
    
    @IBOutlet weak var unitPenRadioButton2: DLRadioButton!
    
   
    override func viewDidLoad() {
        super.viewDidLoad()
        
        getUserSettings()
    }
    
    func calculateInsulin(carbs: Double, bloodSugar: Double, icRatio: Double = 8, correctionFactor: Double = 30) -> Double {
        
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
        
        if fractionBloodResult < 0.49 {
            roundedFraction = 0
        } else if fractionBloodResult > 0.50{
            roundedFraction = 1
        }
        
        let finalBloodResult = wholeBloodResult + roundedFraction
        
        let insulinResult = carbResult + finalBloodResult
        
        return insulinResult
    }

    
    
    @IBAction func didTapHalfUnit(_ sender: Any) {
        unitPenRadioButton2.isSelected = false
    }
    
    @IBAction func didTapWholeUnit(_ sender: Any) {
        unitPenRadioButton1.isSelected = false
    }
    
    func getUserSettings() {
        guard let userData = UserDefaults.standard.data(forKey: "UserSettings") else { return }
        do {
            let userSettings = try JSONDecoder().decode(UserSettings.self, from: userData)
            
            let targetBloodSugarText = String(userSettings.targetBloodSugar)
            targetBloodSugarTextField.text = targetBloodSugarText
            let longActingMorningText = String(userSettings.longActingMorning)
            longActingMorningTextField.text = longActingMorningText
            let longActingEveingText = String(userSettings.longActingEvening)
            longActingEveningTextField.text = longActingEveingText
            let beforeBreakfastRatioText = String(userSettings.beforeBreakfastRatio)
            beforeBreakfastRatioTextField.text = beforeBreakfastRatioText
            let beforeLunchRatioText = String(userSettings.beforeLunchRatio)
            beforeLunchTextRatioField.text = beforeLunchRatioText
            let beforeDinnerRatioText = String(userSettings.beforeDinnerRatio)
            beforeDinnerTextRatioField.text = beforeDinnerRatioText
            let beforeBreakfastCorrectionFactorText = String(userSettings.beforeBreakfastCorrectionFactor)
            beforeBreakfastCorrectionFactorTextField.text = beforeBreakfastCorrectionFactorText
            let beforeLunchCorrectionFactorText = String(userSettings.beforeLunchCorrectionFactor)
            beforeLunchCorrectionFactorTextField.text = beforeLunchCorrectionFactorText
            let beforeDinnerCorrectionFactorText = String(userSettings.beforeDinnerCorrectionFactor)
            beforeDinnerCorrectionFactorTextField.text = beforeDinnerCorrectionFactorText
            let bedtimeRatioText = String(userSettings.bedtimeRatio)
            bedtimeRatioTextField.text = bedtimeRatioText
            let bedtimeCorretionFactor = String(userSettings.bedtimeCorrectionFactor)
            bedtimeCorrectionFatorTextField.text = bedtimeCorretionFactor
            
        } catch {
            print(error)
        }
    }
    
    
    @IBAction func didTapDone(_ sender: Any) {
        
        guard
            let targetBloodSugarText = targetBloodSugarTextField.text,
            let targetBloodSugar = Double(targetBloodSugarText),
            let longActingMorningText = longActingMorningTextField.text,
            let longActingMorning = Double(longActingMorningText),
            let longActingEveningText = longActingEveningTextField.text,
            let longActingEvening = Double(longActingEveningText),
            let beforeBreakfastRatioText = beforeBreakfastRatioTextField.text,
            let beforeBreakfastRatio = Double(beforeBreakfastRatioText),
            let beforeBreafastCorrectionFactorText = beforeBreakfastCorrectionFactorTextField.text,
            let beforeBreakfastCorrectionFactor = Double(beforeBreafastCorrectionFactorText),
            let beforeLunchRatioText = beforeLunchTextRatioField.text,
            let beforeLunchRatio = Double(beforeLunchRatioText),
            let beforeLunchCorrectionFactorText = beforeLunchCorrectionFactorTextField.text,
            let beforeLunchCorrectionFactor = Double(beforeLunchCorrectionFactorText),
            let beforeDinnerRatioText = beforeDinnerTextRatioField.text,
            let beforeDinnerRatio = Double(beforeDinnerRatioText),
            let beforeDinnerCorrectionFactorText = beforeDinnerCorrectionFactorTextField.text,
            let beforeDinnerCorrectionFactor = Double(beforeDinnerCorrectionFactorText),
            let bedtimeRatioText = bedtimeRatioTextField.text,
            let bedtimeRatio = Double(bedtimeRatioText),
            let bedtimeCorrectionFactorText = bedtimeCorrectionFatorTextField.text,
            let bedtimeCorrectionFactor = Double(bedtimeCorrectionFactorText)
            else { return }
        
        
        let settings = UserSettings(isHalfPenType: unitPenRadioButton1.isSelected, targetBloodSugar: targetBloodSugar, longActingMorning: longActingMorning, longActingEvening: longActingEvening, beforeBreakfastRatio: beforeBreakfastRatio, beforeLunchRatio: beforeLunchRatio, beforeDinnerRatio: beforeDinnerRatio, bedtimeRatio: bedtimeRatio, icRatio: beforeBreakfastRatio, correctionFactor: beforeBreakfastCorrectionFactor, beforeBreakfastCorrectionFactor: beforeBreakfastCorrectionFactor, beforeLunchCorrectionFactor: beforeLunchCorrectionFactor, beforeDinnerCorrectionFactor: beforeDinnerCorrectionFactor, bedtimeCorrectionFactor: bedtimeCorrectionFactor)
        
        do {
            
            let settingsData = try JSONEncoder().encode(settings)
            
            UserDefaults.standard.set(settingsData, forKey: "UserSettings")
            
            UserDefaults.standard.synchronize()
            
            print("Saved")
            
        } catch {
            print(error)
        }
    
    }
}
