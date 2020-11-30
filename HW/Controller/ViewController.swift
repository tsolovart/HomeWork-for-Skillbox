//
//  ViewController.swift
//  HW
//
//  Created by Artem Tsolov on 27.10.2020.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var surnameTextField: UITextField!
    
    @IBOutlet weak var nameTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        nameTextField.text = SavedName.shared.userName
        surnameTextField.text = SavedName.shared.userSurname
        
    }

    @IBAction func save(_ sender: Any) {
        SavedName.shared.userName = nameTextField.text
        SavedName.shared.userSurname = surnameTextField.text
        
        print(SavedName.shared.userName)
        print(SavedName.shared.userSurname)
    }
    
}

