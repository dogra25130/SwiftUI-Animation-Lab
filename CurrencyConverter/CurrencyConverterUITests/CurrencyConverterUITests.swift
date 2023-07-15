//
//  CurrencyConverterUITests.swift
//  CurrencyConverterUITests
//
//  Created by Abhishek Dogra on 13/06/23.
//

import XCTest

final class CurrencyConverterUITests: XCTestCase {

    override func setUpWithError() throws {
        continueAfterFailure = false
    }

    override func tearDownWithError() throws {
    }

    func testLaunchPerformance() throws {
        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 7.0, *) {
            // This measures how long it takes to launch your application.
            measure(metrics: [XCTApplicationLaunchMetric()]) {
                XCUIApplication().launch()
            }
        }
    }
    
    func testScrollPerformance() throws {
        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 7.0, *) {
            let app = XCUIApplication()
            app.launch()
            
            let window = app.windows["currency_converted_window"].firstMatch
            let tableView = window.tables["tableView"].firstMatch
            measure(metrics: [XCTOSSignpostMetric.scrollDecelerationMetric]) {
                
                tableView.swipeUp(velocity: XCUIGestureVelocity.fast)
                tableView.swipeUp(velocity: XCUIGestureVelocity.fast)
                tableView.swipeUp(velocity: XCUIGestureVelocity.fast)
                tableView.swipeDown(velocity: XCUIGestureVelocity.fast)
                tableView.swipeDown(velocity: XCUIGestureVelocity.fast)
                tableView.swipeDown(velocity: XCUIGestureVelocity.fast)
            }
        }
    }
}
