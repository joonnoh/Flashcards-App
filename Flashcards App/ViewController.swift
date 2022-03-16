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
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        // Destination of the segue is the Navigation Controller
        let navigationController = segue.destination as! UINavigationController
        
        // Navigation Controller only contains Creation View Controller
        let creationController = navigationController.topViewController as! CreationViewController
        
        // Set flashcardsController property to self
        creationController.flashcardsController = self
        
        // Set initial question and answer if edit segue
        if segue.identifier == "EditSegue" {
            creationController.initialQuestion = questionLabel.text
            creationController.initialAnswer = answerLabel.text
            creationController.initialwrongAnswer1 = buttonOne.currentTitle
            creationController.initialwrongAnswer2 = buttonThree.currentTitle
        }
        
    }
    
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
    
    @IBAction func tapOnResetButton(_ sender: Any) {
        questionLabel.isHidden = false
        buttonOne.isHidden = false
        buttonTwo.isHidden = false
        buttonThree.isHidden = false
    }
    
    func updateFlashcard(question: String, answer: String, wrongAnswer1: String?, wrongAnswer2: String?) {
        
        // Update question and answer cards
        questionLabel.text = question
        answerLabel.text = answer
        
        // Update multiple choice buttons
        buttonOne.setTitle(wrongAnswer1, for: .normal)
        buttonTwo.setTitle(answer, for: .normal)
        buttonThree.setTitle(wrongAnswer2, for: .normal)
        
        // Reset card and buttons
        questionLabel.isHidden = false
        buttonOne.isHidden = false
        buttonTwo.isHidden = false
        buttonThree.isHidden = false
    }
    
}

