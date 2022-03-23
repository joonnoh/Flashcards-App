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
        questionLabel.isHidden = false
        buttonOne.isHidden = false
        buttonTwo.isHidden = false
        buttonThree.isHidden = false
    }
    
    @IBAction func tapOnPrev(_ sender: Any) {
        // Decrease current card index
        currentCardIndex = currentCardIndex - 1
        
        // Update labels
        updateLabels()
        
        // Update buttons
        updateNextPrevButtons()
        
        questionLabel.isHidden = false
        buttonOne.isHidden = false
        buttonTwo.isHidden = false
        buttonThree.isHidden = false
        
        saveToDisk()
    }
    
    @IBAction func tapOnNext(_ sender: Any) {
        // Increase current card index
        currentCardIndex = currentCardIndex + 1
        
        // Update labels
        updateLabels()
        
        // Update buttons
        updateNextPrevButtons()
        
        questionLabel.isHidden = false
        buttonOne.isHidden = false
        buttonTwo.isHidden = false
        buttonThree.isHidden = false
        
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
        buttonOne.setTitle(currentFlashcard.wrongAnswer1, for: .normal)
        buttonTwo.setTitle(currentFlashcard.answer, for: .normal)
        buttonThree.setTitle(currentFlashcard.wrongAnswer2, for: .normal)
    }
    
    
    func updateFlashcard(question: String, answer: String, isExisting: Bool, wrongAnswer1: String, wrongAnswer2: String) {
        
        let flashcard = Flashcard(question: question, answer: answer, wrongAnswer1: wrongAnswer1, wrongAnswer2: wrongAnswer2)
        
        if isExisting {
            flashcards[currentCardIndex] = flashcard
            print("* Edited flashcard at index \(currentCardIndex)")
            updateNextPrevButtons()
            updateLabels()
            
            // Update multiple choice buttons
            buttonOne.setTitle(wrongAnswer1, for: .normal)
            buttonTwo.setTitle(answer, for: .normal)
            buttonThree.setTitle(wrongAnswer2, for: .normal)
            
            // Reset card and buttons
            questionLabel.isHidden = false
            buttonOne.isHidden = false
            buttonTwo.isHidden = false
            buttonThree.isHidden = false
            
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
            
            // Update multiple choice buttons
            buttonOne.setTitle(wrongAnswer1, for: .normal)
            buttonTwo.setTitle(answer, for: .normal)
            buttonThree.setTitle(wrongAnswer2, for: .normal)
            
            // Reset card and buttons
            questionLabel.isHidden = false
            buttonOne.isHidden = false
            buttonTwo.isHidden = false
            buttonThree.isHidden = false
            
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
