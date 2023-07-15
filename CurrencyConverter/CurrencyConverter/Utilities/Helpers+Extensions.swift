//
//  Color+Extension.swift
//  CurrencyConverter
//
//  Created by Abhishek Dogra on 14/06/23.
//

import Foundation
import UIKit

extension Double {
    public func truncate(places : Int)-> Double {
        return Double(floor(pow(10.0, Double(places)) * self)/pow(10.0, Double(places)))
    }
}

func addShadow(view: UIView) {
    view.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.25).cgColor
    view.layer.shadowOffset = CGSize(width: 0.0, height: 2.0)
    view.layer.shadowOpacity = 1.0
    view.layer.shadowRadius = 0.0
    view.layer.masksToBounds = false
    view.layer.cornerRadius = 4.0
}
