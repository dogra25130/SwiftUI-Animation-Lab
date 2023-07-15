//
//  ExchangeRateEntity+CoreDataProperties.swift
//  CurrencyConverter
//
//  Created by Abhishek Dogra on 15/06/23.
//
//

import Foundation
import CoreData


extension ExchangeRateEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ExchangeRateEntity> {
        return NSFetchRequest<ExchangeRateEntity>(entityName: "ExchangeRateEntity")
    }
    @NSManaged public var id: UUID?
    @NSManaged public var disclaimer: String?
    @NSManaged public var license: String?
    @NSManaged public var base: String?
    @NSManaged public var timestamp: Double
    @NSManaged public var keyValueEntity: Set<KeyValueEntity>?

}

// MARK: Generated accessors for keyValueEntity
extension ExchangeRateEntity {

    @objc(addKeyValueEntityObject:)
    @NSManaged public func addToKeyValueEntity(_ value: KeyValueEntity)

    @objc(removeKeyValueEntityObject:)
    @NSManaged public func removeFromKeyValueEntity(_ value: KeyValueEntity)

    @objc(addKeyValueEntity:)
    @NSManaged public func addToKeyValueEntity(_ values: Set<KeyValueEntity>)

    @objc(removeKeyValueEntity:)
    @NSManaged public func removeFromKeyValueEntity(_ values: Set<KeyValueEntity>)

}

extension ExchangeRateEntity : Identifiable {

}
