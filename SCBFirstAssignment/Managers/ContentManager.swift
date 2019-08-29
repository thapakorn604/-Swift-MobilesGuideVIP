//
//  ContentManager.swift
//  SCBFirstAssignment
//
//  Created by Thapakorn Tuwaemuesa on 28/8/2562 BE.
//  Copyright © 2562 SCB. All rights reserved.
//

import Foundation
import UIKit
import CoreData

struct Mobile {
    var mobile : PurpleMobileResponse!
    var isFav : Bool!
}

class ContentManager {
    
    var allMobiles = [Mobile]()
    var favMobiles = [Mobile]()
    
    static let shared = ContentManager()
    
    let appDelegate = UIApplication.shared.delegate as? AppDelegate
    
    func loadContent(completion: @escaping ([Mobile]) -> ()) {
        
        if allMobiles.count > 0 {
            completion(allMobiles)
            return
        }
        
        NetworkManager.shared.feedMobiles(url: "https://scb-test-mobile.herokuapp.com/api/mobiles/") { (result) in
            for i in 0...result.count - 1 {
                    let newMobile = Mobile(mobile: result[i], isFav: false)
                    self.allMobiles.append(newMobile)
                }
                completion(self.allMobiles)
            }
        }
    
    
    func saveToEntity(mobile: [Mobile], entity: String) {
        
        let managedContext = appDelegate!.persistentContainer.viewContext
        
        print("$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$")
        print(mobile.count)
        
        let entity =
            NSEntityDescription.entity(forEntityName: entity,
                                       in: managedContext)!
    
        
        for i in 0...mobile.count - 1 {
            //create new entity
            let phone = NSManagedObject(entity: entity,
                                        insertInto: managedContext)
            
            let newMobile = mobile[i].mobile
            print(newMobile)
            phone.setValue(newMobile?.brand, forKeyPath: "brand")
            phone.setValue(newMobile?.id, forKey: "id")
            phone.setValue(newMobile?.description, forKey: "detail")
            phone.setValue(newMobile?.name, forKey: "name")
            phone.setValue(newMobile?.price, forKey: "price")
            phone.setValue(newMobile?.rating, forKey: "rating")
            phone.setValue(newMobile?.thumbImageURL, forKey: "thumbImageURL")
            phone.setValue(mobile[i].isFav, forKey: "isFav")
            
            do {
                try managedContext.save()
                //people.append(person)
            } catch let error as NSError {
                print("Could not save. \(error), \(error.userInfo)")
            }
        }
    }
    
    func isEntityEmpty(entity: String) -> Bool{
        
        let managedContext = appDelegate!.persistentContainer.viewContext
        
        do{
            let request = NSFetchRequest<NSFetchRequestResult>(entityName: entity)
            let count  = try managedContext.count(for: request)
            print(count)
            return count == 0 ? true : false
        }catch{
            return true
        }
    }
    
    func getDataFromEntity(entity : String) {
        
        let managedContext = appDelegate!.persistentContainer.viewContext
        
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: entity)
        //request.predicate = NSPredicate(format: "age = %@", "12")
        request.returnsObjectsAsFaults = false
        do {
            let result = try managedContext.fetch(request)
            for data in result as! [NSManagedObject] {
                print(data.value(forKey: "name") as! String)
            }
        } catch {
            print("Failed")
        }
    }
}

