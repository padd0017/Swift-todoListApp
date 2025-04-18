import Foundation
import FirebaseFirestore
import SwiftData

class FirestoreManager {
    static let shared = FirestoreManager()
    let db = Firestore.firestore()
    private init() {}
    
    func saveTask(task: Tasks) async throws -> String {
        let taskData: [String: Any] = [
            "title": task.title,
            "notes": task.notes ?? "",
            "dueDate": task.dueDate?.timeIntervalSince1970 ?? 0,
            "location": task.location ?? "",
            "category": task.category ?? "",
            "isDone": task.isDone
        ]
        
        do {
            let ref = try await db.collection("tasks").addDocument(data: taskData)
            task.firebaseId = ref.documentID
            print("i saved it to firestore done sir")
            return ref.documentID
        } catch {
            print("Error saving the task data: \(error)")
            throw error
        }
    }
    
    
    func deleteTask(task: Tasks) async throws {
        guard let firebaseId = task.firebaseId else {
            print("Error deleting the task: No firebase ID found.")
            return
        }
        
        do {
            try await db.collection("tasks").document(firebaseId).delete()
            print("deleted from firestore")
        } catch {
            print("Error deleting the task data: \(error)")
        }
    }
    
    
    func updateTask(task: Tasks) async throws {
        
        let updatedTask: [String: Any] = [
            "title": task.title,
            "notes": task.notes ?? "",
            "dueDate": task.dueDate ?? "",
            "location": task.location ?? "",
            "category": task.category ?? "",
            "isDone": task.isDone
        ]
        
        do {
            try await db.collection("tasks").document(task.firebaseId!).updateData(updatedTask)
            
        } catch {
            print("Error updating the task data: \(error)")
        }
    }
    
    
//    func listAllTasks() async throws -> [Task] {
//        var tasks: [Task] = []
//        
//        do {
//            let snapshot = try await db.collection("tasks").getDocuments()
//            
//            for document in snapshot.documents {
//                do {
//                    let task = try  document.data(as: Task.self)
//                    tasks.append(task)
//                    
//                }catch {
//                    print("error decoding task: \(error)")
//                }
//            }
//            return tasks
//        }
//    }
}
