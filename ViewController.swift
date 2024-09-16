//
//  ViewController.swift
//  Wordle
//
//  Created by Matthew Woods on 2/20/24.
//

import UIKit


// UI
// Keyboard
// Game Board
// Orange/green
class ViewController: UIViewController{
    
    
    let answers = [
        "later", "bloke","books","happy","issue",
        "noise",
        "trial",
        "prior",
        "title",
        "eight",
        "anger",
        "march",
        "range",
        "front",
        "nurse",
        "paper",
        "pound",
        "grass",
        "trade",
        "plant",
        "minor",
        "shirt",
        "catch",
        "sight",
        "begin",
        "wrote",
        "river",
        "major",
        "white",
        "metal",
        "frame",
        "clear",
        "stick",
        "match",
        "cycle",
        "china",
        "bench",
        "coach",
        "beach",
        "upset",
        "pilot",
        "carry",
        "wheel",
        "major",
        "staff",
        "apple",
        "green",
        "split",
        "tower",
        "guest",
        "cross",
        "round",
        "track",
        "maria",
        "broad",
        "draft",
        "smith",
        "flash",
        "guide",
        "death",
        "voice",
        "level",
        "lives",
        "while",
        "stick",
        "joint",
        "basis",
        "gross",
        "mayor",
        "gross",
        "worst",
        "smith",
        "built",
        "proof",
        "store",
        "touch",
        "tries",
        "wrote",
        "rapid",
        "below",
        "every",
        "audit",
        "alter",
        "agree",
        "learn",
        "where",
        "aware",
        "billy",
        "scale",
        "photo",
        "noise",
        "drawn",
        "train",
        "reach",
        "dealt",
        "index",
        
        "leave",
        "tower",
        "worth",
        "needs",
        "tried",
        "coach",
        "newly",
        "dance",
        "clean",
        "audit",
        "guest",
        "error",
        "glass",
        "truck",
        "claim",
        "alarm",
        "peace",
        "flash",
        "daily",
        "funny",
        "terry",
        "flash",
        "print",
        "lucky",
        "sport",
        "mixed",
        "cheap",
        "error",
        "build",
        
        "inner",
        "album",
        "valid",
        "ideal",
        "whole",
        "waste",
        "front",
        "dance",
        
        "fruit",
        "crown",
        "billy",
        "offer",
        "yield",
        "guard",
        
        "paint",
        "argue",
        "could",
        "glass",
        "drive",
        "array",
        "theft",
        "force",
        "sleep",
        "women",
        "cause",
        "apple",
        "title",
        "grace",
        "known",
        "theft",
        "style",
        "sugar",
        "hotel",
        "basic",
        "doing",
        "stuck",
        "leave",
        "meant",
        "sleep",
        "slide",
        "often",
        "treat",
        "going",
        "exact",
        "under",
        "drawn",
        "month",
        "asset",
        "these",
        "cause",
        "drink",
        "sixty",
        "lower",
        "dated",
        "shape",
        "plane",
        "sixty",
        "eight",
        "since",
        "wrong",
        "north",
        "upper",
        "voice",
        "aware",
        "dealt",
        "forum",
        "class",
        "movie",
        "until",
        "dance",
        "fully",
        "tired",
        "hotel",
        "given",
        "split",
        "yield",
        "aside",
        "serve"
    ]
    
    
    var answer = ""
    private var guesses: [[Character?]] = Array(repeating: Array(repeating: nil, count: 5), count: 6)
    var attempts = 5
    let maxAttempts = 5
    
    let keyboardVC = KeyboardViewController()
    let boardVC = BoardViewController()
    let newGameButton = UIButton(type: .system)
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        startNewGame()
    }
    private func setupUI() {
        view.backgroundColor = .black
        
        addChild(keyboardVC)
        keyboardVC.didMove(toParent: self)
        keyboardVC.delegate = self
        keyboardVC.view.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(keyboardVC.view)
        
        addChild(boardVC)
        boardVC.didMove(toParent: self)
        boardVC.datasource = self
        boardVC.view.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(boardVC.view)
        
        setupNewGameButton()
        setupConstraints()
    }
    
    private func setupNewGameButton() {
        newGameButton.setTitle("New Game", for: .normal)
        newGameButton.addTarget(self, action: #selector(startNewGame), for: .touchUpInside)
        newGameButton.translatesAutoresizingMaskIntoConstraints = false
        newGameButton.backgroundColor = .white
        view.addSubview(newGameButton)
        newGameButton.isHidden = false
        
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            // Board View Controller Constraints
            boardVC.view.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            boardVC.view.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            boardVC.view.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            boardVC.view.bottomAnchor.constraint(equalTo: keyboardVC.view.topAnchor),
            boardVC.view.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.6),
            
            // Keyboard View Controller Constraints
            keyboardVC.view.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            keyboardVC.view.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            keyboardVC.view.topAnchor.constraint(equalTo: boardVC.view.bottomAnchor),
            keyboardVC.view.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            
            // New Game Button Constraints
            newGameButton.centerXAnchor.constraint(equalTo: keyboardVC.view.centerXAnchor),
            newGameButton.bottomAnchor.constraint(equalTo: boardVC.view.bottomAnchor,constant: -15)
            
            
        ])
    }
    
    
    @objc private func startNewGame() {
        answer = getRandomWord()
        attempts = 0
        guesses = Array(repeating: Array(repeating: nil, count: 5), count: 6)
        boardVC.reloadData()
        newGameButton.isHidden = false
    }
    
    private func getRandomWord() -> String {
        return answers.randomElement() ?? "after"
    }
}

extension ViewController: KeyboardViewControllerDelegate {
    func keyboardViewController(_ vc: KeyboardViewController, didTapKey letter: Character) {
        if letter == "<" { // Check if the tapped key is the backspace button
            removeLastGuess()
        } else {
            // Update guesses
            var stop = false
            
            for i in 0..<guesses.count {
                for j in 0..<guesses[i].count {
                    if guesses[i][j] == nil {
                        guesses[i][j] = letter
                        stop = true
                        break
                    }
                }
                
                if stop {
                    break
                }
            }
        }
        boardVC.reloadData()
        handleGameResult()
    }
    
    func removeLastGuess() {
            // Iterate through the guesses starting from the last row
            for rowIndex in (0..<guesses.count).reversed() {
                // Check if the current row is complete
                if guesses[rowIndex].contains(nil) {
                    // If the row is not complete, remove the last guess in this row
                    for columnIndex in (0..<guesses[rowIndex].count).reversed() {
                        // Find the last non-nil guess in the row
                        if let _ = guesses[rowIndex][columnIndex] {
                            // Remove the last guess
                            guesses[rowIndex][columnIndex] = nil
                            // Reload the board view controller to reflect the changes
                            boardVC.reloadData()
                            // Exit the function after erasing the last guess
                            return
                        }
                    }
                }
            }
        }
        
        func handleGameResult() {
            if isWordGuessedCorrectly() {
                print("Congratulations! You won!")
                performWinningEffect()
            } else if isMaxAttemptsReached() {
                print("Try Again! You lose!")
                performLosingEffect()
            }
        }
        
        func isWordGuessedCorrectly() -> Bool {
            let guessedWord = guesses.flatMap { $0 }.compactMap { $0 }
            let guessedString = String(guessedWord)
            return guessedString == answer
        }
        
        func isMaxAttemptsReached() -> Bool {
            return attempts >= maxAttempts
        }
        
        func performWinningEffect() {
            let alertController = UIAlertController(title: "Congratulations!", message: "You win!", preferredStyle: .alert)
            alertController.addAction(UIAlertAction(title: "OK", style: .default))
            present(alertController, animated: true)
        }
        
        func performLosingEffect() {
            let alertController = UIAlertController(title: "Try Again!", message: "You lose! The word was \(answer).", preferredStyle: .alert)
            alertController.addAction(UIAlertAction(title: "OK", style: .default))
            present(alertController, animated: true)
        }
    }

    extension ViewController: BoardViewControllerDataSource {
        var currentGuesses: [[Character?]] {
            return guesses
        }
        
        func boxColor(at indexPath: IndexPath) -> UIColor? {
            let rowIndex = indexPath.section
            
            let count = guesses[rowIndex].compactMap({ $0 }).count
            guard count == 5 else {
                return nil
            }
            
            let indexedAnswer = Array(answer)
            
            guard let letter = guesses[indexPath.section][indexPath.row],
                  indexedAnswer.contains(letter) else {
                return nil
            }
            
            if indexedAnswer[indexPath.row] == letter {
                return .systemGreen
            }
            
            return .systemOrange
        }
    }
