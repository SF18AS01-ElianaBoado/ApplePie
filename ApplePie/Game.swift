//
//  Game.swift
//  ApplePie
//
//  Created by Eliana Boado on 1/31/19.
//  Copyright © 2019 Eliana Boado. All rights reserved.
//

import Foundation

struct Game {
    var word: String;
    var incorrectMovesRemaining: Int;
    var guessedLetters: [Character];
    
    mutating func playerGuessed(letter: Character) {
        guessedLetters.append(letter);
        
        if !word.characters.contains(letter) {
            incorrectMovesRemaining -= 1;
        }
    }
    
    var formattedWord: String {
        var guessedWord = "";
        for letter in word.characters {
            if guessedLetters.contains(letter) {
                guessedWord += "\(letter)"
            } else {
                guessedWord += "_";
            }
        }
        return guessedWord;
    }
    

}
