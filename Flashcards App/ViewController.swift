//
//  ViewController.swift
//  Flashcards App
//
//  Created by Joon Noh on 2/26/22.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var answerLabel: UILabel!
    @IBOutlet weak var questionLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
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

