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
    @Published var WastedFoodEntity:[DataEntity] = []
    
    init() {
        container = NSPersistentContainer(name: "BestBefore")
        container.loadPersistentStores { description, error in
            if let error = error{
                print("Error Loading Core Data \(error.localizedDescription)")
            }
        }
        fetchData()
        fetchWastedData()
    }
    
    func fetchWastedData(){
        let request = NSFetchRequest<DataEntity>(entityName: "DataEntity")
        let sortDescriptor = NSSortDescriptor(key: "iswasted", ascending: false)
        let predicate = NSPredicate(format: "iswasted == %@",NSNumber(value: true))
        request.sortDescriptors = [sortDescriptor]
        request.predicate = predicate
        do{
            WastedFoodEntity =  try container.viewContext.fetch(request)
        }catch let error{
            print("Error fetching data \(error.localizedDescription)")
        }
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
    func addNewEntity(title: String,category: String ,expirationDate: Date,notificationDate: Date, perishability: String, emoji: String, notificationTime: Date){
        let newEntity = DataEntity(context: container.viewContext)
        newEntity.id = UUID()
        newEntity.itemTitle = title
        newEntity.category = category
        newEntity.expirationDate = expirationDate
        newEntity.notificationDate = notificationDate
        newEntity.notificationTime  = notificationTime
        newEntity.emoji = emoji
        newEntity.perishability = perishability
        
        // call save data
        savedData()
    }
    
    //Mark Saving Data into Core Data
    func savedData(){
        do{
            try container.viewContext.save()
            fetchData()
            fetchWastedData()
        } catch let error {
            print("Error Saving Data \(error.localizedDescription)")
        }
    }
    
    
    
    //Mark Sdelete
    func deleteData(id: UUID){
        for entity in savedEntity {
            if id == entity.id {
                container.viewContext.delete(entity)
            }
        }
        savedData()
        fetchData()
    }
    
    func isConsumed(id: UUID){
        for entity in savedEntity {
            if id == entity.id{
                entity.isConsumed = true
               savedData()
            }
        }
    }
    
    func isWasted(id: UUID){
        for entity in savedEntity {
            if id == entity.id {
                entity.iswasted = true
                savedData()
            }
        }
    }
    
    func isExpired(expiryDate: Date) -> Bool {
        var expired = false
        
        let day = Calendar.current.dateComponents([.day], from: Date(), to: expiryDate).day!
        if day <= 0 {
           expired = true
        }
return expired
    }
 
    
}
