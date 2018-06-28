//
//  ConocimientosViewController.swift
//  CVVisualization
//
//  Created by Fran Lucena on 27/6/18.
//  Copyright © 2018 Fran Lucena. All rights reserved.
//

import UIKit
import CoreData

class ConocimientosViewController: UIViewController, UITextFieldDelegate, UITextViewDelegate {
    @IBOutlet weak var tituloConocimientoTextField: UITextField!
    @IBOutlet weak var conocimientoDescriptionTextView: UITextView!
    @IBOutlet weak var doneButton: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    
    @IBAction func doneButtonPressed(_ sender: Any) {
        setConocimientos()
    }
    
    
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if textView == conocimientoDescriptionTextView {
            if text == "\n" {
                textView.resignFirstResponder()
                return false
            }
            return true
        }
        return true
    }
    
    func setConocimientos() {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        
        let context = appDelegate.persistentContainer.viewContext
        
        if let entity = NSEntityDescription.entity(forEntityName: "CV", in: context) {
            
            let newCV = NSManagedObject(entity: entity, insertInto: context)
            
            if let descriptionShort = tituloConocimientoTextField.text {
                newCV.setValue(descriptionShort, forKey: "descriptionShort")
            }
            if let descriptionLarge = conocimientoDescriptionTextView.text {
                newCV.setValue(descriptionLarge, forKey: "descriptionLarge")
            }
            
            do {
                try context.save()
                print("Saved")
            } catch {
                print("Failed saving")
            }
        }
    }
    
    
    func checkFields() -> Bool {
        if let titulo = tituloConocimientoTextField.text, titulo.isEmpty {
            return false
        } else if let conocimiento = conocimientoDescriptionTextView.text, conocimiento.isEmpty {
            return false
        } else {
            self.doneButton.isEnabled = true
            return true
        }
    }
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == tituloConocimientoTextField {
            conocimientoDescriptionTextView.becomeFirstResponder()
        }
        return true
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        _ = checkFields()
    }
    
}
