//
//  CoreDataManager.swift
//  Practice
//
//  Created by Vishal Manhas on 06/12/24.
//

import Foundation
import CoreData

class CoreDataManager {
    
    static let shared = CoreDataManager()
    private init() {}
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "Todoapp")
        container.loadPersistentStores { description, error in
            if let error = error {
                fatalError("Error loading persistent stores: \(error)")
            }
        }
        return container
    }()
    
    var context: NSManagedObjectContext {
        return persistentContainer.viewContext
    }
    func createTask(taskName:String,taskid:Int16,taskStatus:Bool){
        var data = Task(context: context)
        data.taskName = taskName
        data.taskid = taskid
        data.taskStatus = taskStatus
        saveContext()
    }
    func fetchTasks()->[Task]{
        let fetchRequest:NSFetchRequest<Task> = Task.fetchRequest()
        
        do {
            return try context.fetch(fetchRequest)
        } catch {
            print("Error fetching persons: \(error)")
            return []
        }
    }
    func saveContext(){
        if context.hasChanges{
            do{
                try context.save()
            }catch{
                print("error to save the data ")
            }
        }
    }
}
