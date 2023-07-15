//
//  CurrencyConverterTests.swift
//  CurrencyConverterTests
//
//  Created by Abhishek Dogra on 13/06/23.
//

import XCTest
@testable import CurrencyConverter

final class CurrencyConverterTests: XCTestCase {

    var modelMock: ExchangeRateModel!
    
    override func setUp() {
        super.setUp()
        
        if let data = JSONToDataConverter.loadData(at: "currency_data"),
           let responseModel = ExchangeRateResponse(with: data) {
            var model = responseModel.getModel()
            model.keyValueRatios.sort{ $0.key < $1.key }
            modelMock = model
        }
    }
    
    override func setUpWithError() throws {
        
    }

    override func tearDownWithError() throws {
        
    }

    func testSearch() throws {
        let searchManager = SearchManager()
        let filteredData1 = searchManager.filterData(char: "USD", originalData: modelMock)
        let filteredData2 = searchManager.filterData(char: "r", originalData: modelMock)
        XCTAssertEqual(filteredData1.count, 1)
        XCTAssertEqual(filteredData2.count, 3)
    }
    
    func testConversion() throws {
        let currencyManager = CurrencyConverterManager()
        let data1 = currencyManager.getAmount(baseCurrency: KeyValueRatio(key: "USD", value: 1),
                                                      currentCurrency: modelMock.keyValueRatios[10],
                                                      factor: 1)
        
        let data2 = currencyManager.getAmount(baseCurrency: KeyValueRatio(key: "USD", value: 1),
                                                      currentCurrency: modelMock.keyValueRatios[8],
                                                      factor: 10)
        XCTAssertEqual(data1, "1.0")
        XCTAssertEqual(data2, "810.0")
    }

}
