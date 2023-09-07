//
//  ContentView.swift
//  ExpenceTracker
//
//  Created by Abhishek Dogra on 03/09/23.
//

import SwiftUI
import SwiftUICharts

struct ContentView: View {
    @EnvironmentObject var transactionListVM: TransactionListViewModel
    @State private var showingSheet = false

    var body: some View {
        NavigationView {
            ScrollView {
                VStack(alignment: .leading, spacing: 24) {
                    HStack {
                        Text("Overview")
                            .font(.title2)
                            .bold()
                        
                        Spacer()
                        Button {
                            showingSheet.toggle()
                            
                        } label: {
                            HStack(spacing: 4) {
                                Text("+")
                                    .fontWeight(.medium)
                            }
                            .padding()
                        }
                        .sheet(isPresented: $showingSheet, content: {
                            AddExpense()
                        })
                        .frame(maxHeight: 40)
                        .background(Color.icon.opacity(0.3))
                        .cornerRadius(25)
                    }
                    
                    
                    let data = transactionListVM.accumulateTransaction()
                    if !data.isEmpty {
                        let totalExpense = data.last?.1 ?? .zero
                        CardView {
                            VStack(alignment: .leading) {
                                ChartLabel(totalExpense.formatted(.currency(code: "INR")), type: .title, format: "$%0.2f")
                                LineChart()
                                    .style
                            }
                            .padding(.leading)
                            .background(Color.systemBackground)
                            
                        }
                        .data(data)
                        .chartStyle(ChartStyle(backgroundColor: Color.systemBackground, foregroundColor: ColorGradient(Color.icon.opacity(0.4), Color.icon)))
                        .frame(height: 300)
                    }
                                        
                    RecentTransactionList()
                }
                .padding()
                .frame(maxWidth: .infinity)
            }
            .background(Color.backgound)
            .navigationBarTitleDisplayMode(.inline)
        }
        .navigationViewStyle(.stack)
        .accentColor(.primary)
    }
}

struct ContentView_Previews: PreviewProvider {
    static let transactionListVM: TransactionListViewModel = {
        let transactionListVM = TransactionListViewModel()
        transactionListVM.transactions = transactionListPreviewData
        return transactionListVM
    }()
    static var previews: some View {
        ContentView()
            .environmentObject(transactionListVM)
    }
}
