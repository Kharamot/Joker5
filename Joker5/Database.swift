//
//  Database.swift
//  Joker5
//
//  Created by Kameron Haramoto on 4/3/17.
//  Copyright © 2017 Larry Holder. All rights reserved.
//

import Foundation
import CoreData
import UIKit

class Database {
    static let db = Database()
    
    func getContext () -> NSManagedObjectContext {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        return appDelegate.persistentContainer.viewContext
    }
    
    func insertJoke(_ joke: Joke){
        let context = getContext()
        let entity = NSEntityDescription.entity(forEntityName: "JokeData", in: context)
        let newJoke = NSManagedObject(entity: entity!, insertInto: context)
    
        newJoke.setValue(joke.firstLine, forKey: "line1")
        newJoke.setValue(joke.secondLine, forKey: "line2")
        newJoke.setValue(joke.thirdLine, forKey: "line3")
        newJoke.setValue(joke.answerLine, forKey: "answer")
        
        do{
            try context.save()
        } catch{
            print("Error")
        }
    }
    
    func editJoke(_ oldJoke: Joke, _ newJoke: Joke){
        let context = getContext()
        let fetchRequest: NSFetchRequest<JokeData> = JokeData.fetchRequest()
        let pred = NSPredicate(format: "line1 == %@", oldJoke.firstLine)
        fetchRequest.predicate = pred
        
        do{
            let result = try context.fetch(fetchRequest) as [NSManagedObject]
            let j = result.first!
            
            j.setValue(newJoke.firstLine, forKey: "line1")
            j.setValue(newJoke.secondLine, forKey: "line2")
            j.setValue(newJoke.thirdLine, forKey: "line3")
            j.setValue(newJoke.answerLine, forKey: "answer")
            
            try context.save()
            
        }catch{
            print("error")
        }
    }
    
    func getJoke() -> [NSManagedObject]? {
        let fetchRequest: NSFetchRequest<JokeData> = JokeData.fetchRequest()
        
        do{
            let results = try getContext().fetch(fetchRequest)
            
            for j in results as [NSManagedObject] {
                print("\(j.value(forKey: "line1"))")
            }
            
            return results as [NSManagedObject]
            
        }catch {
            print("error")
        }
        return nil
    }
    
    func removeJoke(_ joke:Joke){
        let context = getContext()
        let fetchRequest: NSFetchRequest<JokeData> = JokeData.fetchRequest()
        let pred = NSPredicate(format: "line1 == %@", joke.firstLine)
        fetchRequest.predicate = pred
        
        do{
            let result = try context.fetch(fetchRequest) as [NSManagedObject]
            let j = result.first!
            
            context.delete(j)
            try context.save()
            
        }catch{
            print("error")
        }
    }
}
