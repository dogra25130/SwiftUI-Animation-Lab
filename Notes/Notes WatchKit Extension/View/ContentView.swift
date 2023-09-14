//
//  Created by Robert Petras
//  Credo Academy ♥ Design and Code
//  https://credo.academy 
//

import SwiftUI

struct ContentView: View {
  // MARK: - PROPERTY
  
  @AppStorage("lineCount") var lineCount: Int = 1
  
  @State private var notes: [Note] = [Note]()
  @State private var text: String = ""
  
  // MARK: - FUNCTION
  
  func getDocumentDirectory() -> URL {
    let path = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
    return path[0]
  }
  
  func save() {
    // dump(notes)
    
    do {
      // 1. Convert the notes array to data using JSONEncoder
      let data = try JSONEncoder().encode(notes)
      
      // 2. Create a new URL to save the file using the getDocumentDirectory
      let url = getDocumentDirectory().appendingPathComponent("notes")
      
      // 3. Write the data to the given URL
      try data.write(to: url)
    } catch {
      print("Saving data has failed!")
    }
  }
  
  func load() {
    DispatchQueue.main.async {
      do {
        // 1. Get the notes URL path
        let url = getDocumentDirectory().appendingPathComponent("notes")
        
        // 2. Create a new property for the data
        let data = try Data(contentsOf: url)
        
        // 3. Decode the data
        notes = try JSONDecoder().decode([Note].self, from: data)
      } catch {
        // Do nothing
      }
    }
  }
  
  func delete(offsets: IndexSet) {
    withAnimation {
      notes.remove(atOffsets: offsets)
      save()
    }
  }

  // MARK: - BODY
  
  var body: some View {
    VStack {
      HStack(alignment: .center, spacing: 6) {
        TextField("Add New Note", text: $text)
        
        Button {
          // 1. Only run the button's action when the text field is not empty
          guard text.isEmpty == false else { return }
          
          // 2. Create a new note item and initialize it with the text value
          let note = Note(id: UUID(), text: text)
          
          // 3. Add the new note item to the notes array (append)
          notes.append(note)
          
          // 4. Make the text field empty
          text = ""
          
          // 5. Save the notes (function)
          save()
        } label: {
          Image(systemName: "plus.circle")
            .font(.system(size: 42, weight: .semibold))
        }
        .fixedSize()
        .buttonStyle(PlainButtonStyle())
        .foregroundColor(.accentColor)
        //.buttonStyle(BorderedButtonStyle(tint: .accentColor))
      } //: HSTACK
      
      Spacer()
      
      if notes.count >= 1 {
        List {
          ForEach(0..<notes.count, id: \.self) { i in
            NavigationLink(destination: DetailView(note: notes[i], count: notes.count, index: i)) {
              HStack {
                Capsule()
                  .frame(width: 4)
                  .foregroundColor(.accentColor)
                Text(notes[i].text)
                  .lineLimit(lineCount)
                  .padding(.leading, 5)
              }
            } //: HSTACK
          } //: LOOP
          .onDelete(perform: delete)
        }
      } else {
        Spacer()
        Image(systemName: "note.text")
          .resizable()
          .scaledToFit()
          .foregroundColor(.gray)
          .opacity(0.25)
          .padding(25)
        Spacer()
      } //: LIST
    } //: VSTACK
    .navigationTitle("Notes")
    .onAppear(perform: {
      load()
    })
  }
}

// MARK: - PREVIEW

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView()
  }
}
