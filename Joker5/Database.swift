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
    static let cb = Database()
    
    func getContext () -> NSManagedObjectContext {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        return appDelegate.persistentContainer.viewContext
    }
    
    func insertJoke(_ joke: Joke){
        let context = getContext()
        let newJoke = NSEntityDescription.insertNewObject(forEntityName: "JokeData", into: self.getContext())
        
        newJoke.setValue(joke.firstLine, forKey: "line1")
        newJoke.setValue(joke.secondLine, forKey: "line2")
        newJoke.setValue(joke.thirdLine, forKey: "line3")
        newJoke.setValue(joke.answerLine, forKey: "answer")
        
        do{
            try context.save()
        } catch{
            
        }
    }
    
    func removeJoke(_ joke:Joke){
        let context = getContext()
        let fetchRequest: NSFetchRequest<Jokes>(entityName:"JokeData")
        fetchRequest.predicate = NSpredicate(format: "line1 == %@", joke.firstLine)
        let jokePred = NSPredicate(format: <#T##String#>, argumentArray: <#T##[Any]?#>)
    }
}
