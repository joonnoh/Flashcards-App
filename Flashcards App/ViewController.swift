//
//  ViewController.swift
//  Flashcards App
//
//  Created by Joon Noh on 2/26/22.
//

import UIKit

struct Flashcard {
    var question: String
    var answer: String
    var wrongAnswer1: String
    var wrongAnswer2: String
}

class ViewController: UIViewController {

    // Question + Answer Card Variables
    @IBOutlet weak var cardContainer: UIView!
    @IBOutlet weak var answerLabel: UILabel!
    @IBOutlet weak var questionLabel: UILabel!
    
    // Buttons Variables
    @IBOutlet weak var buttonOne: UIButton!
    @IBOutlet weak var buttonTwo: UIButton!
    @IBOutlet weak var buttonThree: UIButton!
    @IBOutlet weak var buttonPrev: UIButton!
    @IBOutlet weak var buttonNext: UIButton!
    
    // Button to remember correct answer
    var correctAnswerButton: UIButton!
    
    // Array to hold flashcards
    var flashcards = [Flashcard]()
    
    // Current flashcards index
    var currentCardIndex = 0
    
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
        
        // Read saved flashcards
        readSavedFlashcards()
        
        // Add initial flashcard if needed
        if flashcards.count == 0 {
            updateFlashcard(question: "What's the current capital of Brazil?", answer: "Brasilia", isExisting: false, wrongAnswer1: "Rio", wrongAnswer2: "Salvador")
        }
        else {
            updateLabels()
            updateNextPrevButtons()
        }
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Start with the flashcard invisible and slightly smaller in size
        cardContainer.alpha = 0.0
        cardContainer.transform = CGAffineTransform.identity.scaledBy(x: 0.75, y: 0.75)
        buttonOne.alpha = 0.0
        buttonOne.transform = CGAffineTransform.identity.scaledBy(x: 0.75, y: 0.75)
        buttonTwo.alpha = 0.0
        buttonTwo.transform = CGAffineTransform.identity.scaledBy(x: 0.75, y: 0.75)
        buttonThree.alpha = 0.0
        buttonThree.transform = CGAffineTransform.identity.scaledBy(x: 0.75, y: 0.75)
        
        //Spring animation
        UIView.animate(withDuration: 0.6, delay: 0.5, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.5, options: [], animations: {
            self.cardContainer.alpha = 1.0
            self.cardContainer.transform = CGAffineTransform.identity
            self.buttonOne.alpha = 1.0
            self.buttonOne.transform = CGAffineTransform.identity
            self.buttonTwo.alpha = 1.0
            self.buttonTwo.transform = CGAffineTransform.identity
            self.buttonThree.alpha = 1.0
            self.buttonThree.transform = CGAffineTransform.identity
        })
    }

    @IBAction func tapOnButtonOne(_ sender: Any) {
        // If correct answer is selected, flip flashcard. Else, disable button
        if buttonOne == correctAnswerButton {
            questionLabel.isHidden = true
            buttonOne.tintColor = UIColor.green
            buttonTwo.isEnabled = false
            buttonThree.isEnabled = false
        }
        else {
            buttonOne.isEnabled = false
        }
    }
    
    @IBAction func tapOnButtonTwo(_ sender: Any) {
        // If correct answer is selected, flip flashcard. Else, disable button
        if buttonTwo == correctAnswerButton {
            questionLabel.isHidden = true
            buttonTwo.tintColor = UIColor.green
            buttonOne.isEnabled = false
            buttonThree.isEnabled = false
        }
        else {
            buttonTwo.isEnabled = false
        }
    }
    
    @IBAction func tapOnButtonThree(_ sender: Any) {
        // If correct answer is selected, flip flashcard. Else, disable button
        if buttonThree == correctAnswerButton {
            questionLabel.isHidden = true
            buttonThree.tintColor = UIColor.green
            buttonOne.isEnabled = false
            buttonTwo.isEnabled = false
        }
        else {
            buttonThree.isEnabled = false
        }
    }
    
    @IBAction func tapOnFlashcard(_ sender: Any) {
        flipFlashcard()
    }
    
    func flipFlashcard() {
        
        UIView.transition(with: cardContainer, duration: 0.3, options: .transitionFlipFromRight, animations: {
            if self.questionLabel.isHidden == false {
                self.questionLabel.isHidden = true
            }
            else {
                self.questionLabel.isHidden = false
            }
        })
    }
    
    func animateCardOut(direction: String) {
        if direction == "next" {
            UIView.animate(withDuration: 0.4, animations: {
                self.cardContainer.transform = CGAffineTransform.identity.translatedBy(x: -500.0, y: 0.0)
                self.buttonOne.transform = CGAffineTransform.identity.translatedBy(x: -500.0, y: 0.0)
                self.buttonTwo.transform = CGAffineTransform.identity.translatedBy(x: -500.0, y: 0.0)
                self.buttonThree.transform = CGAffineTransform.identity.translatedBy(x: -500.0, y: 0.0)
            }, completion: { finished in
                // Increase current card index
                self.currentCardIndex = self.currentCardIndex + 1
                
                // Update labels and buttons
                self.updateLabels()
                self.updateNextPrevButtons()
                
                self.animateCardIn(direction: "next")
            })
        }
        // Direction is "prev"
        else {
            UIView.animate(withDuration: 0.4, animations: {
                self.cardContainer.transform = CGAffineTransform.identity.translatedBy(x: 500.0, y: 0.0)
                self.buttonOne.transform = CGAffineTransform.identity.translatedBy(x: 500.0, y: 0.0)
                self.buttonTwo.transform = CGAffineTransform.identity.translatedBy(x: 500.0, y: 0.0)
                self.buttonThree.transform = CGAffineTransform.identity.translatedBy(x: 500.0, y: 0.0)
            }, completion: { finished in
                // Decrease current card index
                self.currentCardIndex = self.currentCardIndex - 1
                
                // Update labels and buttons
                self.updateLabels()
                self.updateNextPrevButtons()
                
                self.animateCardIn(direction: "prev")
            })
        }
    }
    
    func animateCardIn(direction: String) {
        if direction == "next" {
            // Start on the right side and don't animate this
            cardContainer.transform = CGAffineTransform.identity.translatedBy(x: 500.0, y: 0.0)
            buttonOne.transform = CGAffineTransform.identity.translatedBy(x: 500.0, y: 0.0)
            buttonTwo.transform = CGAffineTransform.identity.translatedBy(x: 500.0, y: 0.0)
            buttonThree.transform = CGAffineTransform.identity.translatedBy(x: 500.0, y: 0.0)
            // Animate card going back to its original position
            UIView.animate(withDuration: 0.4) {
                self.cardContainer.transform = CGAffineTransform.identity
                self.buttonOne.transform = CGAffineTransform.identity
                self.buttonTwo.transform = CGAffineTransform.identity
                self.buttonThree.transform = CGAffineTransform.identity
            }
        }
        else {
            // Start on the left side and don't animate this
            cardContainer.transform = CGAffineTransform.identity.translatedBy(x: -500.0, y: 0.0)
            buttonOne.transform = CGAffineTransform.identity.translatedBy(x: -500.0, y: 0.0)
            buttonTwo.transform = CGAffineTransform.identity.translatedBy(x: -500.0, y: 0.0)
            buttonThree.transform = CGAffineTransform.identity.translatedBy(x: -500.0, y: 0.0)
            // Animate card going back to its original position
            UIView.animate(withDuration: 0.4) {
                self.cardContainer.transform = CGAffineTransform.identity
                self.buttonOne.transform = CGAffineTransform.identity
                self.buttonTwo.transform = CGAffineTransform.identity
                self.buttonThree.transform = CGAffineTransform.identity
            }
        }
    }
    
    @IBAction func tapOnDelete(_ sender: Any) {
        // Check if only one flashcard in array
        if flashcards.count == 1 {
            print("* User tried to delete the final flashcard")
            // Create alert for deleting final flashcard
            let finalAlert = UIAlertController(title: "Only one card left", message: "Cannot delete the final card", preferredStyle: .alert)
            
            // Create ok button to dismiss alert
            let okAction = UIAlertAction(title: "Ok", style: .default)
            finalAlert.addAction(okAction)
            
            // Show alert message
            present(finalAlert, animated: true)
        }
        
        else {
            // Ask user confirmation
            let deleteAlert = UIAlertController(title: "Delete flashcard", message: "Are you sure you want to delete?", preferredStyle: .actionSheet)
            
            let deleteAction = UIAlertAction(title: "Delete", style: .destructive) {
                action in self.deleteFlashcard()
            }
            deleteAlert.addAction(deleteAction)
            
            let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
            deleteAlert.addAction(cancelAction)
            
            // Show alert message
            present(deleteAlert, animated: true)
        }
        
    }
    
    @IBAction func tapOnResetButton(_ sender: Any) {
        updateLabels()
    }
    
    @IBAction func tapOnPrev(_ sender: Any) {
        
        animateCardOut(direction: "prev")
        saveToDisk()
    }
    
    @IBAction func tapOnNext(_ sender: Any) {
        
        animateCardOut(direction: "next")
        saveToDisk()
    }
    
    func deleteFlashcard() {

        // Delete current flashcard
        flashcards.remove(at: currentCardIndex
        )
        print("* Flashcard deleted")
        print("* There are \(flashcards.count) flashcards")
        // Check if card in last position was deleted
        if currentCardIndex > flashcards.count - 1 {
                currentCardIndex = flashcards.count - 1
        }
        updateLabels()
        updateNextPrevButtons()
        saveToDisk()
        
    }
    
    func saveToDisk() {
        
        // From flashcard array to dictionary array
        let dictionaryArray = flashcards.map {
            (card) -> [String:String] in return ["question": card.question, "answer": card.answer, "wrongAnswer1": card.wrongAnswer1, "wrongAnswer2": card.wrongAnswer2]
        }
        
        // Save array on disk using UserDefaults
        UserDefaults.standard.set(dictionaryArray, forKey: "flashcards")
        UserDefaults.standard.set(currentCardIndex, forKey: "currentCardIndex")
        
        print("* Flashcards saved to UserDefaults")
    }
    
    func readSavedFlashcards() {
        
        // Read dictionary array from disk (if any)
        if let dictionaryArray = UserDefaults.standard.array(forKey: "flashcards") as? [[String:String]] {
            // In here, we know for sure we have a dictionary array
            let savedCards = dictionaryArray.map { dictionary -> Flashcard in return Flashcard(question: dictionary["question"]!, answer: dictionary["answer"]!, wrongAnswer1: dictionary["wrongAnswer1"]!, wrongAnswer2: dictionary["wrongAnswer2"]!)
            }
            
            // Put all these cards in flashcards array
            flashcards.append(contentsOf: savedCards)
            
            currentCardIndex = UserDefaults.standard.integer(forKey: "currentCardIndex")
        }
    }
    
    func updateLabels() {
        // Get current flashcard
        let currentFlashcard = flashcards[currentCardIndex]
        
        // Update labels
        questionLabel.text = currentFlashcard.question
        answerLabel.text = currentFlashcard.answer
        
        // Update buttons
        let buttons = [buttonOne, buttonTwo, buttonThree].shuffled()
        let answers = [currentFlashcard.answer, currentFlashcard.wrongAnswer1, currentFlashcard.wrongAnswer2].shuffled()
        
        // Iterate over both arrays at same time
        for (button, answer) in zip(buttons, answers) {
            
            // Set title of random button with random answer
            button?.setTitle(answer, for: .normal)
            
            // If this is the correct answer, save the button
            if answer == currentFlashcard.answer {
                correctAnswerButton = button
            }
        }
        
        questionLabel.isHidden = false
        buttonOne.tintColor = #colorLiteral(red: 0, green: 0.4591832161, blue: 0.8913863301, alpha: 1)
        buttonTwo.tintColor = #colorLiteral(red: 0, green: 0.4591832161, blue: 0.8913863301, alpha: 1)
        buttonThree.tintColor = #colorLiteral(red: 0, green: 0.4591832161, blue: 0.8913863301, alpha: 1)
        buttonOne.isEnabled = true
        buttonTwo.isEnabled = true
        buttonThree.isEnabled = true
        
    }
    
    
    func updateFlashcard(question: String, answer: String, isExisting: Bool, wrongAnswer1: String, wrongAnswer2: String) {
        
        let flashcard = Flashcard(question: question, answer: answer, wrongAnswer1: wrongAnswer1, wrongAnswer2: wrongAnswer2)
        
        if isExisting {
            flashcards[currentCardIndex] = flashcard
            print("* Edited flashcard at index \(currentCardIndex)")
            updateNextPrevButtons()
            updateLabels()
            
            saveToDisk()
        }
        else {
            // Add flashcard to the flashcards array
            flashcards.append(flashcard)
            print("* Added new flashcard")
            print("* There are \(flashcards.count) flashcards")
            
            // Update current index
            currentCardIndex = flashcards.count - 1
            print("* The current index is \(currentCardIndex)")
            
            // Update prev and next buttons
            updateNextPrevButtons()
            
            // Update question and answer cards
            updateLabels()
            
            // Save flashcards
            saveToDisk()
        }
        
    }
    
    func updateNextPrevButtons() {
        // Disable next button if at the end
        if currentCardIndex == flashcards.count - 1 {
            buttonNext.isEnabled = false
        }
        else {
            buttonNext.isEnabled = true
        }
        
        // Disable prev button if at the beginning
        if currentCardIndex == 0 {
            buttonPrev.isEnabled = false
        }
        else {
            buttonPrev.isEnabled = true
        }
    }
    
}
