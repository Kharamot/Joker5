//
//  AddJokeViewController.swift
//  Joker5
//
//  Created by Larry Holder on 1/31/17.
//  Copyright © 2017 Larry Holder. All rights reserved.
//

import UIKit

class AddJokeViewController: UIViewController, UITextFieldDelegate {
    
    var numJokes = 0
    var newJoke: Joke = Joke()
    var canceled = false

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var firstLineTextField: UITextField!
    @IBOutlet weak var secondLineTextField: UITextField!
    @IBOutlet weak var thirdLineTextField: UITextField!
    @IBOutlet weak var answerLineTextField: UITextField!
    
    @IBAction func cancelTapped(_ sender: UIBarButtonItem) {
        canceled = true
        performSegue(withIdentifier: "unwindToTable", sender: nil)
    }
    
    @IBAction func saveTapped(_ sender: UIBarButtonItem) {
        if (!firstLineTextField.text!.isEmpty) {
            canceled = false
            newJoke.firstLine = firstLineTextField.text!
            newJoke.secondLine = secondLineTextField.text!
            newJoke.thirdLine = thirdLineTextField.text!
            newJoke.answerLine = answerLineTextField.text!
            performSegue(withIdentifier: "unwindToTable", sender: nil)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        firstLineTextField.delegate = self
        secondLineTextField.delegate = self
        thirdLineTextField.delegate = self
        answerLineTextField.delegate = self
        titleLabel.text = "Enter New Joke #\(numJokes+1)"
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder() // hide keyboard
        return false
    }
}
