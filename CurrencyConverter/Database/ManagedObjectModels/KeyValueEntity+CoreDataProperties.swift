//
//  KeyValueEntity+CoreDataProperties.swift
//  CurrencyConverter
//
//  Created by Abhishek Dogra on 16/06/23.
//
//

import Foundation
import CoreData


extension KeyValueEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<KeyValueEntity> {
        return NSFetchRequest<KeyValueEntity>(entityName: "KeyValueEntity")
    }

    @NSManaged public var key: String?
    @NSManaged public var value: Double

}

extension KeyValueEntity : Identifiable {

}
