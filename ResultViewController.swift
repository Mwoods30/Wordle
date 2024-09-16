//
//  ResultViewController.swift
//  Wordle
//
//  Created by Matthew Woods on 2/21/24.
//

import UIKit

class ResultViewController: UIViewController {

    var guesses: [[Character?]] = Array(repeating: Array(repeating: nil, count: 5), count: 6)
        var answer = ""
        var attempts = 0
        let maxAttempts = 5
        
        // Function to handle the game result
        func handleGameResult() {
            if isWordGuessedCorrectly() {
                print("Congratulations! You won!")
                performWinningEffect()
            } else if isMaxAttemptsReached() {
                print("Try Again! You lose!")
                performLosingEffect()
            }
        }
        
        // Function to check if the word is guessed correctly
        func isWordGuessedCorrectly() -> Bool {
            let guessedWord = guesses.flatMap { $0 }.compactMap { $0 }
            let guessedString = String(guessedWord)
            return guessedString == answer
        }

        // Function to check if maximum attempts are reached
        func isMaxAttemptsReached() -> Bool {
            return attempts >= maxAttempts
        }

        // Function to perform winning effect
        func performWinningEffect() {
            let alertController = UIAlertController(title: "Congratulations!", message: "You win!", preferredStyle: .alert)
            alertController.addAction(UIAlertAction(title: "OK", style: .default))
            present(alertController, animated: true)
        }

        // Function to perform losing effect
        func performLosingEffect() {
            let alertController = UIAlertController(title: "Try Again!", message: "You lose! The word was \(answer).", preferredStyle: .alert)
            alertController.addAction(UIAlertAction(title: "OK", style: .default))
            present(alertController, animated: true)
        }
    }


