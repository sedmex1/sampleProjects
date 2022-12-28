//
//  ViewModel.swift
//  FirebaseLearining
//
//  Created by Dominik Kowalewski on 09/11/2022.
//

import Foundation
import Firebase

class ViewModel: ObservableObject {    
    
    @Published var list = [Todo]()
    
    func getData() {
        
        //Get reference to the database
        let db = Firestore.firestore()
        
        //Read the documents at a specific path
        db.collection("todos").getDocuments { snapshot, error in
            
            // Check for errors
            if error == nil {
                // No errors
                
                if let snapshot = snapshot {
                    
                    // Update the list property in the main thread
                    DispatchQueue.main.async {
                        // Get all the documents and create Todos
                        self.list = snapshot.documents.map { d in
                            
                            // Create Todo for each document
                            return Todo(id: d.documentID,
                                        name: d["name"] as? String ?? "",
                                        notes: d["notes"] as? String ?? "")
                        }
                    }
                    

                }
                
            } else {
                // Handle the error
            }
        }
    }
    
    func addData(name: String, notes: String) {
        
        // Get reference to the database
        let db = Firestore.firestore()
        
        // Add document to a colection
        db.collection("todos").addDocument(data: ["name":name, "notes":notes]) { error in
            if error == nil {
                // No errors
                
                // call get data to retrive lates data
                self.getData()
                
            } else {
                // Handle error
            }
        }
    }
    
    func deleteData(todoToDelete: Todo) {
        
        let db = Firestore.firestore()
        
        db.collection("todos").document(todoToDelete.id).delete { error in
            
            if error == nil {
                
                // Update the UI from the main thread
                DispatchQueue.main.async {
                    
                    // Remove the todo that was just deleted
                    self.list.removeAll { todo in
                        
                        //Check for the todo to remove
                        
                        return todo.id == todoToDelete.id
                    }
                }
            } else {
                
                // Handle error
            }
        }
    }
    
}
