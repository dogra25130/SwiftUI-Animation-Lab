//
//  GlobalVariables.swift
//  CurrencyConverter
//
//  Created by Abhishek Dogra on 15/06/23.
//

import Foundation
import UIKit

let cooldownTimeKey = "Timestamp"
let keyValueAPIData: String = "KeyValueCurrencyData"
let cooldownTimePeriod: Double = 30 * 60 // in seconds
let persistentStorage: String = "CurrencyConverterDatabase"
let universalID: UUID = UIDevice.current.identifierForVendor ?? UUID()
let refreshIndicatorShown: String = "RefreshIndicatorShown"
