//
//  SurveyViewController.swift
//  Survey2
//
//  Created by Laura O'Brien on 10/5/17.
//  Copyright © 2017 Laura O'Brien. All rights reserved.
//

import UIKit

class SurveyViewController: UIViewController {

    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var emojiTextField: UITextField!
    
    @IBAction func submitButtonTapped(_ sender: Any) {
    
        guard let name = nameTextField.text, let emoji = emojiTextField.text, name != "", emoji != "" else { return }
    
        SurveyController.shared.putSurvey(with: name, emoji: emoji) { (success) in
            guard success else { return }
            DispatchQueue.main.async {
                self.nameTextField.text = ""
                self.emojiTextField.text = ""
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
}
