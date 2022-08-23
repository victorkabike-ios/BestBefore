//
//  itemViewModel.swift
//  BestBefore
//
//  Created by victor kabike on 2022/08/04.
//

import Foundation
import CoreData
import UserNotifications

class ItemViewModel: ObservableObject {
    @Published var newitem:Bool = false
    let container: NSPersistentContainer
    @Published var savedEntity: [DataEntity] = []
    init() {
        container = NSPersistentContainer(name: "BestBefore")
        container.loadPersistentStores { description, error in
            if let error = error{
                print("Error Loading Core Data \(error.localizedDescription)")
            }
        }
        fetchData()
    }
    
    
    // Mark: Fetching Core Data
    func fetchData() {
        let request = NSFetchRequest<DataEntity>(entityName: "DataEntity")
        do{
            savedEntity =  try container.viewContext.fetch(request)
        }catch let error{
            print("Error fetching data \(error.localizedDescription)")
        }
    }
    
    //Mark: Adding New entity into Core Data
    func addNewEntity(title: String,category: String ,expirationDate: Date,notificationDate: Date){
        let newEntity = DataEntity(context: container.viewContext)
        newEntity.id = UUID()
        newEntity.itemTitle = title
        newEntity.category = category
        newEntity.expirationDate = expirationDate
        newEntity.notificationDate = notificationDate
        
        // call save data
        savedData()
    }
    
    //Mark Saving Data into Core Data
    func savedData(){
        do{
            try container.viewContext.save()
            fetchData()
        } catch let error {
            print("Error Saving Data \(error.localizedDescription)")
        }
    }
    
    func deleteData(at offset: IndexSet){
        for index in offset {
            let entity = savedEntity[index]
            container.viewContext.delete(entity)
            savedData()
        }
    }
    
    
    //Mark Sdelete
    
    
    
}
