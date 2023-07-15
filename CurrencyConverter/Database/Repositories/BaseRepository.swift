//
//  BaseRepository.swift
//  CurrencyConverter
//
//  Created by Abhishek Dogra on 16/06/23.
//

import Foundation
protocol BaseRepository {
    func create(record: ExchangeRateModel)
    func get(byIdentifier id: UUID) -> ExchangeRateModel?
    func update(record: ExchangeRateModel) -> Bool
}
