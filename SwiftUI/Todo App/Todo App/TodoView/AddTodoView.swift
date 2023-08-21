//
//  AddTodoView.swift
//  Todo App
//
//  Created by Abhishek Dogra on 17/06/23.
//

import SwiftUI

struct AddTodoView: View {
    @Environment(\.dismiss) var dismiss
    @Environment(\.managedObjectContext) var managedObjectContext
    @State private var name: String = ""
    @State private var priority: String = "Normal"
    @State private var errorShowing: Bool = false
    @State private var errorTitle: String = ""
    @State private var errorMessage: String = ""
    
    let priorities = ["High", "Normal", "Low"]
    
    var body: some View {
        NavigationView {
            VStack {
                Form {
                    TextField("Todo", text: $name)
                    Picker("Priority", selection: $priority) {
                        ForEach(priorities, id: \.self) {
                            Text($0)
                        }
                    }
                    .pickerStyle(.segmented)
                    Button {
                        let todo = Todo(context: self.managedObjectContext)
                        todo.name = self.name
                        todo.priority = self.priority
                        if self.name != "" {
                            do {
                                try self.managedObjectContext.save()
                                self.dismiss.callAsFunction()
                            } catch {
                                print(error )
                            }
                            
                        }else {
                            errorShowing = true
                            errorTitle = "Invalid Name"
                            errorMessage = "Make sure you enter something"
                        }
                        
                    } label: {
                        Text("Save")
                    }

                }
                Spacer()
            } // END: VStack
            .navigationTitle("New Todo")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                Button {
                    dismiss.callAsFunction()
                } label: {
                    Image(systemName: "xmark")
                }
            }
            .alert(errorTitle, isPresented: $errorShowing) {
                Button("OK", role: .cancel) { }
            } message: {
                Text(errorMessage)
            }
        } // END: navigaiton view
    }
}

struct AddTodoView_Previews: PreviewProvider {
    static var previews: some View {
        AddTodoView()
    }
}
