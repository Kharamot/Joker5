//
//  ViewController.swift
//  Joker5
//
//  Created by Larry Holder on 1/30/17.
//  Copyright © 2017 Larry Holder. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var jokeStore = JokeStore()
    
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
        initializeJokes()
        chooseJoke()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func initializeJokes() {
        var joke = Joke("How many programmers", "does it take to", "change a lightbulb?", "Zero. That's a hardware problem.")
        self.jokeStore.add(joke)
        joke = Joke("What did the fish say", "when it ran into a wall?", "", "Dam.")
        self.jokeStore.add(joke)
        joke = Joke("A horse walked into a bar,", "and the bartender said...", "", "Why the long face?")
        self.jokeStore.add(joke)
    }
    
    func chooseJoke() {
        // change button to "Answer"
        answerButton.setTitle("Answer", for: .normal)
        // hide answer label
        answerLineLabel.isHidden = true
        // choose a joke from the array at random
        let randomJokeIndex = Int(arc4random_uniform(UInt32(self.jokeStore.count())))
        let joke = self.jokeStore.getJoke(atIndex: randomJokeIndex)
        self.displayJoke(joke)
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
            jokesTableVC.jokeStore = self.jokeStore
        }
    }

}

