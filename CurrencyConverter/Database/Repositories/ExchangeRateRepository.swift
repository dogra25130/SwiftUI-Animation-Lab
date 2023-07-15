//
//  ExchangeRateRepository.swift
//  CurrencyConverter
//
//  Created by Abhishek Dogra on 16/06/23.
//


import Foundation
import CoreData

struct ExchangeRateRepository : BaseRepository {
    // MARK: - Crate Exchange Rate Model in database
    func create(record: ExchangeRateModel) {

        let exchangeRateEntity = ExchangeRateEntity(context: PersistentStorage.shared.persistentContainer.viewContext)
        exchangeRateEntity.id = record.id
        exchangeRateEntity.disclaimer = record.disclaimer
        exchangeRateEntity.license = record.license
        exchangeRateEntity.timestamp = record.timestamp
        exchangeRateEntity.base = record.base

        if(record.keyValueRatios.isEmpty == false) {
            var kvRatiosSet = Set<KeyValueEntity>()
            record.keyValueRatios.forEach({ (kvRatio) in
                let kvEntity = KeyValueEntity(context: PersistentStorage.shared.persistentContainer.viewContext)
                kvEntity.value = kvRatio.value
                kvEntity.key = kvRatio.key
                kvRatiosSet.insert(kvEntity)
            })

            exchangeRateEntity.keyValueEntity = kvRatiosSet
        }

        PersistentStorage.shared.saveContext()
    }
    
    // MARK: - Get Exchange Rate Model from database
    func get(byIdentifier id: UUID) -> ExchangeRateModel? {

        let exchangeRateEntity = getExchangeRateEntity(byId: id)
        guard let exchangeRateEntity = exchangeRateEntity else { return nil }

        return exchangeRateEntity.convertToExchangeRateModel()
    }

    // MARK: - Update Exchange Rate Model in database
    func update(record: ExchangeRateModel) -> Bool {
        
        let exchangeRateEntity = getExchangeRateEntity(byId: record.id)
        guard let exchangeRateEntity = exchangeRateEntity else { return false }
        exchangeRateEntity.base = record.base
        exchangeRateEntity.disclaimer = record.disclaimer
        exchangeRateEntity.timestamp = record.timestamp
        exchangeRateEntity.license = record.license
        if(record.keyValueRatios.isEmpty == false) {
            var kvRatiosSet = Set<KeyValueEntity>()
            record.keyValueRatios.forEach({ (kvRatio) in
                let kvEntity = KeyValueEntity(context: PersistentStorage.shared.persistentContainer.viewContext)
                kvEntity.value = kvRatio.value
                kvEntity.key = kvRatio.key
                kvRatiosSet.insert(kvEntity)
            })

            exchangeRateEntity.keyValueEntity = kvRatiosSet
        }
        
        PersistentStorage.shared.saveContext()
        return true
    }

    // MARK: - Private func
    private func getExchangeRateEntity(byId id: UUID) -> ExchangeRateEntity? {
        let fetchRequest = NSFetchRequest<ExchangeRateEntity>(entityName: "ExchangeRateEntity")
        let fetchById = NSPredicate(format: "id==%@", id as CVarArg)
        fetchRequest.predicate = fetchById

        let result = try? PersistentStorage.shared.persistentContainer.viewContext.fetch(fetchRequest)
        guard result?.count != 0 else {return nil}

        return result?.first
    }
}

