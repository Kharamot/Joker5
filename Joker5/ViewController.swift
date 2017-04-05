//
//  ViewController.swift
//  Joker5
//
//  Created by Larry Holder on 1/30/17.
//  Copyright © 2017 Larry Holder. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController {

    var jokes: [NSManagedObject] = []
    var jokeStore = JokeStore()
    let appRun = UserDefaults.standard
    
    @IBOutlet weak var firstLineLabel: UILabel!
    @IBOutlet weak var secondLineLabel: UILabel!
    @IBOutlet weak var thirdLineLabel: UILabel!
    @IBOutlet weak var answerLineLabel: UILabel!
    @IBOutlet weak var answerButton: UIButton!
    
    @IBAction func answerButtonTapped(_ sender: UIButton) {
        // if Answer hidden, then unhide answer line and change button to New Joke
        // else choose new joke
        if (answerLineLabel.isHidden) {
            answerLineLabel.isHidden = false
            answerButton.setTitle("New Joke", for: .normal)
        } else {
            self.chooseJoke()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        let hasAppRan = "AppHasRan"
        
        if(appRun.object(forKey: hasAppRan) == nil)
        {
            
            initializeJokes()
            appRun.set(true, forKey: hasAppRan)
            appRun.synchronize()
        }
        chooseJoke()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func initializeJokes() {
        
        var joke = Joke("How many programmers", "does it take to", "change a lightbulb?", "Zero. That's a hardware problem.")
        Database.db.insertJoke(joke)
        joke = Joke("What did the fish say", "when it ran into a wall?", "", "Dam.")
        Database.db.insertJoke(joke)
        joke = Joke("A horse walked into a bar,", "and the bartender said...", "", "Why the long face?")
        Database.db.insertJoke(joke)
    }
    
    func chooseJoke() {
        
        // change button to "Answer"
        answerButton.setTitle("Answer", for: .normal)
        // hide answer label
        answerLineLabel.isHidden = true
        // choose a joke from the array at random
//        let randomJokeIndex = Int(arc4random_uniform(UInt32(self.jokeStore.count())))
//        let joke = self.jokeStore.getJoke(atIndex: randomJokeIndex)
//        self.displayJoke(joke)
        getJokes()
    }
    
    func getJokes() {
        jokes = Database.db.getJoke()!
        let randomJokeIndex = Int(arc4random_uniform(UInt32(self.jokes.count)))
        
        let line1 = jokes[randomJokeIndex].value(forKey: "line1") as! String
        let line2 = jokes[randomJokeIndex].value(forKey: "line2") as! String
        let line3 = jokes[randomJokeIndex].value(forKey: "line3") as! String
        let answer = jokes[randomJokeIndex].value(forKey: "answer") as! String
        
        let j = Joke(line1, line2, line3, answer)
        
        self.displayJoke(j)
    }
    
    func displayJoke (_ joke: Joke) {
        // Making sure each label has something will keep the Answer button from jumping around
        if (joke.firstLine.isEmpty) {
            firstLineLabel.text = " "
        } else {
            firstLineLabel.text = joke.firstLine
        }
        if (joke.secondLine.isEmpty) {
            secondLineLabel.text = " "
        } else {
            secondLineLabel.text = joke.secondLine
        }
        if (joke.thirdLine.isEmpty) {
            thirdLineLabel.text = " "
        } else {
            thirdLineLabel.text = joke.thirdLine
        }
        if (joke.answerLine.isEmpty) {
            answerLineLabel.text = " "
        } else {
            answerLineLabel.text = joke.answerLine
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "toJokesTable") {
            let jokesTableVC = segue.destination as! TableViewController
            jokesTableVC.jokes = self.jokes
        }
    }

}

