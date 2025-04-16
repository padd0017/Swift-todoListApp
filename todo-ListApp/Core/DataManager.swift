//import SwiftData
//
//@MainActor
//class DataManager: ObservableObject {
//    static let shared = DataManager()
//    let container: ModelContainer
//    
//    init() {
//        do {
//            container = try ModelContainer(for: Profile.self, Task.self)
//        } catch {
//            fatalError("Failed to initialize SwiftData container")
//        }
//    }
//    
//    func deleteAllUserData() {
//        do {
//            try container.mainContext.delete(model: Profile.self)
//            try container.mainContext.delete(model: Task.self)
//        } catch {
//            print("Error deleting data: \(error)")
//        }
//    }
//}
