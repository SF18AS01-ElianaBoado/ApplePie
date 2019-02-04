//
//  ViewController.swift
//  ApplePie
//
//  Created by Eliana Boado on 1/29/19.
//  Copyright © 2019 Eliana Boado. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var listOfWords = [
                    "buccaneer",
                    "swift",
                    "glorious",
                    "incandescent",
                    "bug",
                    "program"
    ];
    
    let incorrectMovesAllowed: Int = 7;
    var currentGame: Game!
    var totalWins: Int = 0 {
        didSet {
            newRound();
        }
    }
    var totalLosses: Int = 0 {
        didSet {
            newRound();
        }
    }
    
    @IBOutlet weak var treeImageView: UIImageView!
    @IBOutlet weak var correctWordLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet var letterButtons: [UIButton]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        newRound(); //Start the first game.
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    func enableLetterButtons(_ enable: Bool) {      //Called by newRound.
        for button in letterButtons {
            button.isEnabled = enable;
        }
    }
    
    func newRound(){            //Called by viewDidLoad, and at end of each game.
        if !listOfWords.isEmpty {
        let newWord = listOfWords.removeFirst();
        currentGame = Game(word: newWord, incorrectMovesRemaining: incorrectMovesAllowed, guessedLetters: []);
            enableLetterButtons(true);
            updateUI();
        } else {
            enableLetterButtons(false)
        }
    }
    
    func updateUI() {               //Called by newRound & updateGameState.
        /*
        var letters = [String]();
        for letter in currentGame.formattedWord.characters {
            letters.append(String(letter));
        }
         */
        let letters: [String] = currentGame.formattedWord.map {String($0)} //simpler way
        let wordWithSpacing = letters.joined(separator: " ");
        correctWordLabel.text = currentGame.formattedWord;
        scoreLabel.text = "Wins: \(totalWins), Losses: \(totalLosses)";
        treeImageView.image = UIImage(named: "Tree \(currentGame.incorrectMovesRemaining)");
    }

    @IBAction func buttonTapped(_ sender: UIButton) {
        sender.isEnabled = false;
        let letterString: String = sender.title(for: .normal)!;
        let letter: Character = Character(letterString.lowercased());
        currentGame.playerGuessed(letter: letter);
        updateGameState();
    }
    
    func updateGameState() {//Called only by buttonTapped.  If game is over, start a new one.
        if currentGame.incorrectMovesRemaining == 0 {
            totalLosses += 1;       //Current game is over; no need to updateUI.
        } else if currentGame.word == currentGame.formattedWord {
            totalWins += 1;         //Current game is over; no need to updateUI.
        }else {
            updateUI() ;            //Current game is not over.
        }
    }
}
