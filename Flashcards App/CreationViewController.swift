//
//  CreationViewController.swift
//  Flashcards App
//
//  Created by Joon Noh on 3/12/22.
//

import UIKit

class CreationViewController: UIViewController {
    
    var flashcardsController: ViewController!
    
    var initialQuestion: String?
    
    var initialAnswer: String?
    
    var initialwrongAnswer1: String?
    
    var initialwrongAnswer2: String?

    @IBOutlet weak var questionField: UITextField!
    
    @IBOutlet weak var answerField: UITextField!
    
    @IBOutlet weak var wrongAnswer1Field: UITextField!
    
    @IBOutlet weak var wrongAnswer2Field: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        questionField.text = initialQuestion
        answerField.text = initialAnswer
        wrongAnswer1Field.text = initialwrongAnswer1
        wrongAnswer2Field.text = initialwrongAnswer2
    }
    
    @IBAction func didTapOnCancel(_ sender: Any) {
        
        // Dismiss creation screen
        dismiss(animated: true)
    }
    
    @IBAction func didTapOnDone(_ sender: Any) {
        
        // Get text from fields
        let questionText = questionField.text
        let answerText = answerField.text
        let wrongAnswer1Text = wrongAnswer1Field.text
        let wrongAnswer2Text = wrongAnswer2Field.text
        
        // Check if fields are empty
        if questionText == nil || answerText == nil || wrongAnswer1Text == nil || wrongAnswer2Text == nil || questionText!.isEmpty || answerText!.isEmpty || wrongAnswer1Text!.isEmpty || wrongAnswer2Text!.isEmpty {
            
            // Create alert for empty fields
            let emptyAlert = UIAlertController(title: "Missing Text", message: "Fill out all fields", preferredStyle: .alert)
            
            // Create ok button to dismiss alert
            let okAction = UIAlertAction(title: "Ok", style: .default)
            emptyAlert.addAction(okAction)
            
            // Show alert message
            present(emptyAlert, animated: true)
        }
        else {
            
            // Update flashcard
            flashcardsController.updateFlashcard(question: questionText!, answer: answerText!, wrongAnswer1: wrongAnswer1Text!, wrongAnswer2: wrongAnswer2Text!)
            
            // Dismiss creation screen
            dismiss(animated: true)
        }
        
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
