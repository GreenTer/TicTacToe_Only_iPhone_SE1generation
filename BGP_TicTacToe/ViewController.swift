//
//  ViewController.swift
//  Tic-Tac
//
//  Created by Baravitski Aliaksandr on 19.03.21.
//

import UIKit

class ViewController: UIViewController {
    
    
    
    // DEFAULT SHINGS
    // PARAMS to know, who is now MOVE (X or O)
    var whoseMove = 0
    // ARR for "Player X" (turns)
    var arrPlayerX = [Int]()
    // ARR for "Player O" (turns)
    var arrPlayerO = [Int]()
    // GAME if true - can move, if false - can't
    var game = true
    

    
    // FUNCTION'S
    func checkForWin (gMeArr: [Int]) -> Int {
        // arr for wins (all combinations)
        let arrBlcoksForWin = [
            [1,2,3],
            [1,5,9],
            [1,4,7],
            [2,5,8],
            [3,5,7],
            [3,6,9],
            [4,5,6],
            [7,8,9]]
        
        for blockForWin in arrBlcoksForWin {
            // PARAMS for win (if == 3 - WIN!)
            var checkForWin = 0
            
            // block for compare players turns and results for win
            for winTurn in blockForWin {
                
                // block Player turns
                for playerTurns in gMeArr {

                    // compare blockForWins and PlayerTurns
                    if winTurn == playerTurns {
                        checkForWin += 1
                        
                        // check for win
                        if checkForWin == 3 {
                            return checkForWin
                        }
                    }
                }
            }
            
            // DRAW conditions
            if arrPlayerX.count + arrPlayerO.count == 9 && checkForWin < 3 {
                showScreenX.text = "DRAW"
                showScreenO.text = "DRAW"
            }
        }
        return 0
    }
    
    
    
    // Outlet
    // LABEL for X and O
    @IBOutlet weak var showScreenX: UILabel!
    @IBOutlet weak var showScreenO: UILabel!
    // BUTTON's from 0 to 8
    @IBOutlet var buttons: [UIButton]!
    
    
    @IBAction func onClickRestart(_ sender: UIButton) {

        for i in 0...8 {
            buttons[i].setTitle("", for: .normal)
        }
        
        // LABEL's who move after win
        if whoseMove == 0 {
            showScreenX.text = "X"
            showScreenO.text = ""
        } else {
            showScreenX.text = ""
            showScreenO.text = "O"
        }
        
        // RESET all param's for new game
        game = true
        arrPlayerO.removeAll()
        arrPlayerX.removeAll()
        
    }
    
    // Actions
    @IBAction func buttonsField(_ sender: UIButton) {
        
        // if game = 0, you can move! If not - you didn't
        if game == true {

            // ALL turns
            switch sender.tag {
            case _:

                // PROTECT - from used twise one button
                if sender.currentTitle == "X" || sender.currentTitle == "O" {
                    // do nothing
                } else {
                    
                    
                    
                    // "Player X" - conditions
                    if whoseMove % 2 == 0 {
                        
                        // LABEL's
                        showScreenX.text = ""
                        showScreenO.text = "O"
                        // BUTTON - params for X
                        sender.setTitleColor(.systemPink, for: .normal)
                        sender.setTitle("X", for: .normal)

                        // ADD turn for player "X" in array
                        arrPlayerX.append(sender.tag)
                        // ADD turn's (X or O)
                        whoseMove = 1
                        
                        
                        // CHECK for win - Player X
                        if checkForWin(gMeArr: arrPlayerX) == 3 {
                            showScreenX.text = "X - Win !"
                            showScreenO.text = "O - Lose !"
                            
                            // block next turn
                            game = false
                            // block first turn for Player X
                            whoseMove = 1
                        }
                        
                        
                        
                    // "Player O" - conditions
                    } else {
                        
                        // LABEL's
                        showScreenO.text = ""
                        showScreenX.text = "X"
                        // BUTTON - params for O
                        sender.setTitleColor(.systemBlue, for: .normal)
                        sender.setTitle("O", for: .normal)
                        
                        // ADD turn for player "O" in array
                        arrPlayerO.append(sender.tag)
                        // ADD turn's (X or O)
                        whoseMove = 0

                        
                        // CHECK for win - Player O
                        if checkForWin(gMeArr: arrPlayerO) == 3 {
                            showScreenO.text = "O - Win !"
                            showScreenX.text = "X - Lose !"
                            
                            // block next turn
                            game = false
                            // block first turn for Player O
                            whoseMove = 0
                        }
                    }
                }
            }
        }
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
}
