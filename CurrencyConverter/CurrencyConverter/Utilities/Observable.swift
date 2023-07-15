//
//  Observable.swift
//  CurrencyConverter
//
//  Created by Abhishek Dogra on 13/06/23.
//

import Foundation
class Observable<T> {
    var listner: ((T?) -> ())?
    var value: T? {
        didSet {
            self.listner?(value)
        }
    }
    
    init(value: T?) {
        self.value = value
    }
    
    func bind(listner: ((T?) -> ())?) {
        self.listner = listner
    }
}
