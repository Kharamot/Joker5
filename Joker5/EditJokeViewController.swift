//
//  EditJokeViewController.swift
//  Joker5
//
//  Created by Kameron Haramoto on 4/4/17.
//  Copyright © 2017 Larry Holder. All rights reserved.
//

import UIKit
import CoreData

class EditJokeViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var TextFieldLine1: UITextField!
    @IBOutlet weak var TextFieldLine2: UITextField!
    @IBOutlet weak var TextViewLine3: UITextField!
    @IBOutlet weak var TextFieldAnswer: UITextField!
    
    var oldJoke: Joke = Joke()
    var newJoke: Joke = Joke()
    var cancelled = false
    
    var jokes: [NSManagedObject] = []
    var indexRow: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        TextFieldLine1.delegate = self
        TextFieldLine2.delegate = self
        TextViewLine3.delegate = self
        TextFieldAnswer.delegate = self
        
        let line1 = jokes[indexRow].value(forKey: "line1") as! String
        let line2 = jokes[indexRow].value(forKey: "line2") as! String
        let line3 = jokes[indexRow].value(forKey: "line3") as! String
        let answer = jokes[indexRow].value(forKey: "answer") as! String
        
        TextFieldLine1.text = line1
        TextFieldLine2.text = line2
        TextViewLine3.text = line3
        TextFieldAnswer.text = answer
        
        oldJoke = Joke(line1, line2, line3, answer)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func saveTapped(_ sender: UIBarButtonItem) {
        if (!TextFieldLine1.text!.isEmpty) {
            //canceled = false
            newJoke.firstLine = TextFieldLine1.text!
            newJoke.secondLine = TextFieldLine2.text!
            newJoke.thirdLine = TextViewLine3.text!
            newJoke.answerLine = TextFieldAnswer.text!
            
            Database.db.editJoke(oldJoke, newJoke)
            self.cancelled = false
            performSegue(withIdentifier: "unwindToTableFromEdit", sender: nil)
        }
    }
    
    @IBAction func cancelTapped(_ sender: UIBarButtonItem) {
        self.cancelled = true
        performSegue(withIdentifier: "unwindToTableFromEdit", sender: nil)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder() // hide keyboard
        return false
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
