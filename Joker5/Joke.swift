//
//  Joke.swift
//  Joker5
//
//  Created by Larry Holder on 1/31/17.
//  Copyright © 2017 Larry Holder. All rights reserved.
//

import Foundation

class Joke {
    var firstLine: String
    var secondLine: String
    var thirdLine: String
    var answerLine: String
    
    init(_ firstLine: String = "", _ secondLine: String = "", _ thirdLine: String = "", _ answerLine: String = "") {
        self.firstLine = firstLine
        self.secondLine = secondLine
        self.thirdLine = thirdLine
        self.answerLine = answerLine
    }
}

class JokeStore {
    var jokesArray: [Joke] = []
    
    func add(_ joke: Joke) {
        jokesArray.append(joke)
    }
    
    func remove(atIndex: Int) {
        jokesArray.remove(at: atIndex)
    }
    
    func getJoke(atIndex: Int) -> Joke {
        return jokesArray[atIndex]
    }
    
    func count() -> Int {
        return jokesArray.count
    }
}
