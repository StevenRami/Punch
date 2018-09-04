//
//  UserSettings.swift
//  Punch
//
//  Created by Steven Ramirez on 8/25/18.
//  Copyright © 2018 Steven Ramirez. All rights reserved.
//

import UIKit

struct UserSettings: Codable {
    let isHalfPenType: Bool
    let targetBloodSugar: Double
    let longActingMorning: Double
    let longActingEvening: Double
    let beforeBreakfastRatio: Double
    let beforeLunchRatio: Double
    let beforeDinnerRatio: Double
    let bedtimeRatio: Double
    let icRatio: Double
    let correctionFactor: Double
    let beforeBreakfastCorrectionFactor: Double
    let beforeLunchCorrectionFactor: Double
    let beforeDinnerCorrectionFactor: Double
    let bedtimeCorrectionFactor: Double
}
