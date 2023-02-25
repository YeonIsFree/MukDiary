//
//  DataManager.swift
//  MukDiary
//
//  Created by Seryun Chun on 2023/02/18.
//

import Foundation
import CoreData
import UIKit

class DataManager {
    static let shared = DataManager()
    private init() {
        
    }
    
    var mainContext: NSManagedObjectContext {
        return persistentContainer.viewContext
    }
    
    var diaryList = [Diary]()
    
    func fetchDiary() {
        let request: NSFetchRequest<Diary> = Diary.fetchRequest()
        let sortByDateDesc = NSSortDescriptor(key: "insertDate", ascending: false)
        request.sortDescriptors = [sortByDateDesc]
        
        do {
            diaryList = try mainContext.fetch(request)
        } catch {
            print(error)
        }
    }
   
    func addNewDiary(diaryPhoto: Data?, diaryTitle: String?, diaryContent: String?) {
        let newDiary = Diary(context: mainContext)
        newDiary.photo = diaryPhoto
        newDiary.title = diaryTitle
        newDiary.insertDate = Date()
        newDiary.content = diaryContent
        
        diaryList.insert(newDiary, at: 0)
        saveContext()
    }
    
    func deleteDiary(_ diary: Diary?) {
        if let diary = diary {
            mainContext.delete(diary)
            saveContext()
        }
    }
    
    

    // MARK: - Core Data stack

    lazy var persistentContainer: NSPersistentContainer = {
        
        let container = NSPersistentContainer(name: "MukDiary")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()

    // MARK: - Core Data Saving support

    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
}
