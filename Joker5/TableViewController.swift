//
//  TableViewController.swift
//  Joker5
//
//  Created by Larry Holder on 2/8/17.
//  Copyright © 2017 Larry Holder. All rights reserved.
//

import UIKit
import CoreData

class TableViewController: UITableViewController {
    
    var jokeStore: JokeStore!
    var jokes: [NSManagedObject] = []
    var selectedRow: Int = 0

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return self.jokes.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "jokeCell", for: indexPath)
        
        // Configure the cell...
        let joke = self.jokes[indexPath.row]
        cell.textLabel?.text = joke.value(forKey: "line1") as? String
        return cell
    }
    

    
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    

    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            let line1 = jokes[indexPath.row].value(forKey: "line1") as! String
            let line2 = jokes[indexPath.row].value(forKey: "line2") as! String
            let line3 = jokes[indexPath.row].value(forKey: "line3") as! String
            let answer = jokes[indexPath.row].value(forKey: "answer") as! String
            
            let j = Joke(line1, line2, line3, answer)
            
            Database.db.removeJoke(j)
            self.jokes.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
            
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if (segue.identifier == "toAddJoke") {
            let addJokeVC = segue.destination as! AddJokeViewController
            addJokeVC.numJokes = self.jokes.count
        }
        if (segue.identifier == "toEditJoke"){
            let editJokeVC = segue.destination as! EditJokeViewController
            editJokeVC.jokes = jokes
            editJokeVC.indexRow = self.selectedRow
            
        }
        
        
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.selectedRow = indexPath.row
        performSegue(withIdentifier: "toEditJoke", sender: nil)

    }
    
    @IBAction func unwindToTable (sender: UIStoryboardSegue) {
        let addJokeVC = sender.source as! AddJokeViewController
        if (!addJokeVC.canceled) {
            let joke = addJokeVC.newJoke
            Database.db.insertJoke(joke)
            self.jokes = Database.db.getJoke()!
            self.tableView.reloadData()
        }
    }
    
    @IBAction func unwindToTableFromEdit (sender: UIStoryboardSegue) {
        //let addJokeVC = sender.source as! AddJokeViewController
        //if (!addJokeVC.canceled) {
            //let joke = addJokeVC.newJoke
            //Database.db.insertJoke(joke)
            self.jokes = Database.db.getJoke()!
            self.tableView.reloadData()
        //}
    }


}
