//
//  MyBase.swift
//  Lesson_14
//
//  Created by Александр Бельчиков on 19.10.2021.
//

import UIKit
import Foundation
import RealmSwift
//import Realm
import CoreData

//TODO - вынести в отдельный файлик
class MyBase {
    
    static let shared = MyBase()
    
    var tasksCore: [NSManagedObject] = []

    //task 1 UserDefaults
    private let kUserNameKey = "MyBase.kUserNameKey"
    private let kUserNameKey2 = "MyBase.kUserNameKey2"
    
    var userName: String{
        set { UserDefaults.standard.set(newValue, forKey: kUserNameKey) }
        get { return UserDefaults.standard.string(forKey: kUserNameKey) ?? "" }
    }
    var userName2: String{
        set { UserDefaults.standard.set(newValue, forKey: kUserNameKey2) }
        get { return UserDefaults.standard.string(forKey: kUserNameKey2) ?? "" }
    }
    
    
    //task 2 - realm
    private let realm = try! Realm()
    
    //добавление в базу realm
    public func AddTaskToRealm(_ taskName : String){
        let task = ToDoTasks()
        task.taskName = taskName
        try! realm.write {
            self.realm.add(task)
        }
    }
    //Листинг из базы из realm
    func GetAllTaskFromRealm() -> [String] {
        let allTask = realm.objects(ToDoTasks.self)
        var allTaskArray : [String] = []
        for Task in allTask {
            allTaskArray.append(Task.taskName)
        }
        return allTaskArray
    }
    //Удаление по значению из realm
    func DeletTaskByName(_ taskName : String) -> [String] {
        if let TaskToDelet = realm.objects(ToDoTasks.self).filter("taskName = %@", taskName).first {
            try! realm.write {
                realm.delete(TaskToDelet)
            }
        }
        return GetAllTaskFromRealm()
    }
    //Удаление по индексу из realm
    func DeletTaskByIndex(_ taskIndex : Int)-> [String]{
        let allTask = realm.objects(ToDoTasks.self)
        for (index , task) in allTask.enumerated() {
            if(taskIndex == index){
                return DeletTaskByName(task.taskName)
            }
        }
        return GetAllTaskFromRealm()
    }
    
    
    //task 3 - coredata
    public func AddTaskToCore(_ taskName : String) -> [String]{
        //let appDelegate = UIApplication.shared.delegate as? AppDelegate
        //let managedContext = appDelegate?.persistentContainer.viewContext
        let managedContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        
        let entity = NSEntityDescription.entity(forEntityName: "ToDoTasksCore", in: managedContext)!
        let task = NSManagedObject(entity: entity, insertInto: managedContext)
        task.setValue(taskName, forKeyPath: "task")
        do {
            try managedContext.save()
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
        return GetAllTaskFromCore()
    }
    
    func GetAllTaskFromCore() -> [String]{
        let appDelegate = UIApplication.shared.delegate as? AppDelegate
        let managedContext = appDelegate?.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "ToDoTasksCore")
        var array : [String] = []
        do{
            let res = try! managedContext?.fetch(fetchRequest)
            for task in res! {
                array.append(task.value(forKey: "task") as! String)
            }
        }
        return array
    }
    
    func DeletTaskByIndexCore(_ taskIndex : Int)-> [String]{
        let appDelegate = UIApplication.shared.delegate as? AppDelegate
        let managedContext = appDelegate?.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "ToDoTasksCore")
        do{
            let res = try! managedContext?.fetch(fetchRequest)
            for (index , task) in res!.enumerated() {
                if index == taskIndex {
                    managedContext?.delete(task as NSManagedObject)
                }
            }
        }
        return GetAllTaskFromCore()
    }
    
}


//модель для realm
class ToDoTasks: Object{
    @objc dynamic var taskName = ""
}
