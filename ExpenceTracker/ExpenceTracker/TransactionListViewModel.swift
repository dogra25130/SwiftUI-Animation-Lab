//
//  TransactionListViewModel.swift
//  ExpenceTracker
//
//  Created by Abhishek Dogra on 03/09/23.
//

import Combine
import Collections
import Foundation

typealias TransactionGroup = OrderedDictionary<Date, [Transaction]>
typealias TransactionPrefixSum = [(String, Double)]

final class TransactionListViewModel: ObservableObject {
    @Published var transactions: [Transaction] = []
    private var cancellables = Set<AnyCancellable>()
    
    init() {
        getTransactions()
    }
    
    func getTransactions() {
        guard let url = URL(string: "https://designcode.io/data/transactions.json") else {
            print("Invalid URL")
            return
        }
        
        URLSession.shared.dataTaskPublisher(for: url)
            .tryMap { (data, response) -> Data in
                guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
                    dump(response)
                    throw URLError(.badServerResponse)
                }
                return data
            }
            .decode(type: [Transaction].self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .sink { completion in
                switch completion {
                case .failure(_):
                    print("error fetching transactions")
                case .finished:
                    break
                }
            } receiveValue: { [weak self] result in
                guard let self else { return }
                self.transactions = result
            }
            .store(in: &cancellables)
    }
    
    func groupTransactionByMonth() -> TransactionGroup {
        guard !transactions.isEmpty else { return [:] }
        var groupedTransactions = TransactionGroup(grouping: transactions) { $0.date.dateParsed() }
        groupedTransactions.sort { $0.key > $1.key }
        return groupedTransactions
    }
    
    func accumulateTransaction() -> TransactionPrefixSum {
        guard !transactions.isEmpty else { return [] }
        let today = "02/17/2022".dateParsed()
        let dateInterval = Calendar.current.dateInterval(of: .month, for: today)!
        var sum: Double = .zero
        var cummulatedSum = TransactionPrefixSum()
        for date in stride(from: dateInterval.start, to: today, by: 60 * 60 * 24) {
            let dailyExpenses = transactions.filter({ $0.dateParsed == date && $0.isExpense })
            let dailyTotal = dailyExpenses.reduce(0) { $0 - $1.signedAmount }
            
            sum += dailyTotal
            sum = sum.roundedTo2Digits()
            cummulatedSum.append((date.formatted(), sum))
        }
        return cummulatedSum
    }
}
