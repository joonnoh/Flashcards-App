//
//  ViewController.swift
//  Flashcards App
//
//  Created by Joon Noh on 2/26/22.
//

import UIKit

class ViewController: UIViewController {

    // Question + Answer Card Variables
    @IBOutlet weak var cardContainer: UIView!
    @IBOutlet weak var answerLabel: UILabel!
    @IBOutlet weak var questionLabel: UILabel!
    
    // Buttons Variables
    @IBOutlet weak var buttonOne: UIButton!
    @IBOutlet weak var buttonTwo: UIButton!
    @IBOutlet weak var buttonThree: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Card styling
        cardContainer.layer.cornerRadius = 20.0
        cardContainer.layer.shadowRadius = 15.0
        cardContainer.layer.shadowOpacity = 0.2
        
        // Question Label styling
        questionLabel.clipsToBounds = true
        questionLabel.layer.cornerRadius = 20.0
        
        // Answer Label styling
        answerLabel.clipsToBounds = true
        answerLabel.layer.cornerRadius = 20.0
        
        // Button One styling
        buttonOne.clipsToBounds = true
        buttonOne.layer.cornerRadius = 20.0
        buttonOne.layer.borderWidth = 3.0
        buttonOne.layer.borderColor = #colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1) // #colorLiteral()
        
        // Button Two styling
        buttonTwo.clipsToBounds = true
        buttonTwo.layer.cornerRadius = 20.0
        buttonTwo.layer.borderWidth = 3.0
        buttonTwo.layer.borderColor = #colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1)
        
        // Button Three styling
        buttonThree.clipsToBounds = true
        buttonThree.layer.cornerRadius = 20.0
        buttonThree.layer.borderWidth = 3.0
        buttonThree.layer.borderColor = #colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1)
    }

    @IBAction func tapOnButtonOne(_ sender: Any) {
        buttonOne.isHidden = true
    }
    
    @IBAction func tapOnButtonTwo(_ sender: Any) {
        questionLabel.isHidden = true
    }
    
    @IBAction func tapOnButtonThree(_ sender: Any) {
        buttonThree.isHidden = true
    }
    
    @IBAction func tapOnFlashcard(_ sender: Any) {
        if questionLabel.isHidden == false {
            questionLabel.isHidden = true
        }
        else {
            questionLabel.isHidden = false
        }
        
    }
    
    
}

