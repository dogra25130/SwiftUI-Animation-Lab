//
//  AddExpense.swift
//  ExpenceTracker
//
//  Created by Abhishek Dogra on 03/09/23.
//

import SwiftUI
var globalId: Int = 27
struct AddExpense: View {
    @EnvironmentObject var transactionListVM: TransactionListViewModel
    @State private var amount: String = ""
    @State private var title: String = ""
    @State private var paymentMethod = ""
    @State private var date: Date = Date()
    @State private var contentHeight: CGFloat?
    @State private var transactionType = 0
    @State private var categoryId = 0
    
    
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        Form {
            Section {
                TextField("Title", text: $title)
                TextField("Payment method", text: $paymentMethod)
                HStack {
                    TextField("Add amount", text: $amount)
                    Picker("Credit / Debit", selection: $transactionType) {
                        Text("Debit").tag(0)
                        Text("Credit").tag(1)
                    }
                    .pickerStyle(.segmented)
                }
                .listRowSeparator(.visible)
                
                Picker("Category", selection: $categoryId) {
                    ForEach(Category.all, id: \.id) {item in
                        Text(item.name)
                    }
                }
                .listRowSeparator(.visible)
                
                DatePicker("Date", selection: $date, displayedComponents: .date)
                    .datePickerStyle(GraphicalDatePickerStyle())
                    .listRowSeparator(.hidden)
                    .foregroundColor(.accentColor)
            }
        header: {
            HStack {
                Text("Add Transaction")
                Spacer()
                Button {
                    transactionListVM.transactions.append(Transaction(id: globalId,
                                                                      date: date.usaFormatted(),
                                                                      institution:  "Desjardins",
                                                                      account: "Personal chequing account",
                                                                      merchant: title,
                                                                      amount: Double(amount)!,
                                                                      type: (transactionType == 0) ? "debit" : "credit",
                                                                      categoryId: categoryId,
                                                                      category: paymentMethod,
                                                                      isPending: false,
                                                                      isTransfer: true,
                                                                      isExpense: false,
                                                                      isEdited: false))
                    globalId += 1
                    dismiss()
                } label: {
                    Text("Save")
                        .padding()
                        .foregroundColor(.white)
                }
                .frame(height: 30)
                .disabled(amount.isEmpty || paymentMethod.isEmpty || title.isEmpty)
                .background(amount.isEmpty || paymentMethod.isEmpty || title.isEmpty ? Color.secondary.opacity(0.3) : Color.accentColor)
                .cornerRadius(25)
                
            }
        }
        .headerProminence(.increased)
        .padding(.top)
        }
    }
}

struct AddExpenseViewModel {
    var date: Date
    var amount: String
}

struct AddExpense_Previews: PreviewProvider {
    static let transactionListVM: TransactionListViewModel = {
        let transactionListVM = TransactionListViewModel()
        transactionListVM.transactions = transactionListPreviewData
        return transactionListVM
    }()
    
    static var previews: some View {
        AddExpense()
            .environmentObject(transactionListVM)
    }
}
