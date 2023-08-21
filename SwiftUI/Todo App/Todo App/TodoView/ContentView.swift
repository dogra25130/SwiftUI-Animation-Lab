//
//  ContentView.swift
//  Todo App
//
//  Created by Abhishek Dogra on 17/06/23.
//

import SwiftUI

struct ContentView: View {
    @State private var showingAddToView: Bool = false
    
    @Environment(\.managedObjectContext) var managedObjectContext
    @FetchRequest(entity: Todo.entity(), sortDescriptors: [NSSortDescriptor(keyPath: \Todo.name, ascending: true)]) var todos: FetchedResults<Todo>
    var body: some View {
        NavigationView {
            List(0..<5) { item in
                Text("Hello world")
            }
            .navigationTitle("Todo")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                Button {
                    self.showingAddToView.toggle()
                } label: {
                    Image(systemName: "plus")
                }
                .sheet(isPresented: $showingAddToView) {
                    AddTodoView().environment(\.managedObjectContext, self.managedObjectContext)
                }
            }
        }
        
            
    }

}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environment(\.managedObjectContext, PersistenceController.shared.container.viewContext)
    }
}
