//
//  ContentView.swift
//  WeSplit
//
//  Created by Abhishek Dogra on 20/08/23.
//

import SwiftUI
import Charts

struct Ratios: Identifiable {
    let id = UUID()
    let tag: String
    let price: Double
    
    init(tag: String, price: Double) {
        self.tag = tag
        self.price = price
    }
}
struct ContentView: View {
    @State private var indexOfFriends: Int = 2
    @State private var checkAmount = 5000.0
    @State private var tipPercentage = 0.2
    
    private var finalAmount: Int {
        let totalAmount = checkAmount + (checkAmount * tipPercentage) + checkAmount * 0.18 + checkAmount * 0.18
        let val = Double(totalAmount / Double(indexOfFriends + 2))
        return Int(ceil(val))
    }
    
    private var ratios: [Ratios] {
        let checkAmount = checkAmount / Double(indexOfFriends + 2)
        return [Ratios(tag: "Amount", price: checkAmount),
                Ratios(tag: "Tip", price: checkAmount * tipPercentage),
                Ratios(tag: "CGST", price: checkAmount * 0.18),
                Ratios(tag: "SGST", price: checkAmount * 0.18)]
    }
    
    var body: some View {
        NavigationStack {
            VStack {
                Form {
                    Section {
                        HStack {
                            Text("Enter the amount")
                            Spacer()
                            TextField("Amount", value: $checkAmount, format: .currency(code: "INR"))
                                .multilineTextAlignment(.trailing)
                        }
                        
                        HStack {
                            Text("Enter the Tip")
                            Spacer()
                            TextField("Amount", value: $tipPercentage, format: .percent)
                                .multilineTextAlignment(.trailing)
                        }
                        
                        Picker("Number of friends", selection: $indexOfFriends) {
                            ForEach(2..<100) { friends in
                                Text("\(friends)")
                            }
                        }
                    }
                    
                    Section {
                        HStack {
                            Text("Amount per person: ")
                            Spacer()
                            Text("\(finalAmount)")
                        }
                        
                        VStack {
                            GroupBox ( "Bill breakdown in percentage") {
                                Chart(ratios) {
                                    let value: Double = ((($0.price) / Double(finalAmount)) * 100)
                                    BarMark(
                                        x: .value("Week Day", $0.tag),
                                        y: .value("Step Count", $0.price)
                                    )
                                    .foregroundStyle(Color.blue)
                                    .annotation(position: .overlay, alignment: .top, spacing: 3) {
                                        Text(String(format: "%.1f", value))
                                            .font(.footnote)
                                            .foregroundColor(.white)
                                    }
                                }
                            }
                            .frame(height: 300)
                            Spacer()
                        }
                    }
                    .listRowSeparator(.hidden)
                }
            }
            .navigationTitle("Split the bill")
        }
        
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
