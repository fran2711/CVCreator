//
//  ChangeCvViewController.swift
//  CVVisualization
//
//  Created by Fran Lucena on 26/6/18.
//  Copyright © 2018 Fran Lucena. All rights reserved.
//

import UIKit
import CoreData

class ChangeCvViewController: UIViewController, UITextFieldDelegate, UITextViewDelegate {
    
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var companyTextField: UITextField!
    @IBOutlet weak var fromDateTextField: UITextField!
    @IBOutlet weak var untilDateTextField: UITextField!
    @IBOutlet weak var experienceTextView: UITextView!
    @IBOutlet weak var navItem: UINavigationItem!
    @IBOutlet weak var doneButton: UIBarButtonItem!
    
    var isFromList = false
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if isFromList == true {
            navItem.title = NSLocalizedString("AñadirCV", comment: "")
        } else {
            setLabels()
        }
    }

    @IBAction func fromDateButtonPressed(_ sender: Any) {
        let dateDefault = Date()
        
        let strDone = NSLocalizedString("Continue", comment: "")
        let strCancel = NSLocalizedString("Cancel", comment: "")
        
        DatePickerDialog().show(NSLocalizedString("Desde", comment: ""), doneButtonTitle: strDone, cancelButtonTitle: strCancel, defaultDate: dateDefault, minimumDate: nil, maximumDate: Date(), datePickerMode: .date) {(date) in
            if let d = date {
                self.fromDateTextField.text = d.getLongDate()
                
            }
        }
        _ = checkFields()
    }
    
    @IBAction func untilButtonPressed(_ sender: Any) {
        let dateDefault = Date()
        
        let strDone = NSLocalizedString("Continue", comment: "")
        let strCancel = NSLocalizedString("Cancel", comment: "")
        
        DatePickerDialog().show(NSLocalizedString("Hasta", comment: ""), doneButtonTitle: strDone, cancelButtonTitle: strCancel, defaultDate: dateDefault, minimumDate: nil, maximumDate: Date(), datePickerMode: .date) {(date) in
            if let d = date {
                self.untilDateTextField.text = d.getLongDate()
                
            }
        }
        _ = checkFields()
    }
    
    @IBAction func doneButtonPressed(_ sender: Any) {
        setData()
    }
    @IBAction func addConocimientoButtonPressed(_ sender: Any) {
        self.performSegue(withIdentifier: "AddConocimientos", sender: self)
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        _ = checkFields()
    }
    
    func setLabels() {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        
        let context = appDelegate.persistentContainer.viewContext
        
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "CV")
        request.returnsObjectsAsFaults = false
        
        do {
            let result = try context.fetch(request)
            for data in result as! [NSManagedObject] {
                
                if let name = data.value(forKey: "name") as? String {
                    nameTextField.text = name
                }
                
                if let company = data.value(forKey: "company") as? String {
                    companyTextField.text = company
                }
                
                if let fromDate = data.value(forKey: "fromDate") as? String {
                    fromDateTextField.text = fromDate
                }
                
                if let untilDate = data.value(forKey: "untilDate") as? String {
                    untilDateTextField.text = untilDate
                }
                
                if let experience = data.value(forKey: "experience") as? String {
                    experienceTextView.text = experience
                }
                
                print(data)
            }
        } catch {
            print("Error fetching objects")
        }
    }
    
    func setData() {
        
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        
        let context = appDelegate.persistentContainer.viewContext
        
        if let entity = NSEntityDescription.entity(forEntityName: "CV", in: context) {
            let newCV = NSManagedObject(entity: entity, insertInto: context)
            
            
            if let name = nameTextField.text {
                newCV.setValue(name, forKey: "name")
            }
            if let company = companyTextField.text {
                newCV.setValue(company, forKey: "company")
            }
            if let fromDate = fromDateTextField.text {
                newCV.setValue(fromDate, forKey: "fromDate")
            }
            if let untilDate = untilDateTextField.text {
                newCV.setValue(untilDate, forKey: "untilDate")
            }
            if let experience = experienceTextView.text {
                newCV.setValue(experience, forKey: "experience")
            }
            
            let createdAt = Date().timeIntervalSince1970
            newCV.setValue(createdAt, forKey: "createdAt")
            
            do {
                try context.save()
                print("Saved")
            } catch {
                print("Failed saving")
            }
        }
    }
    
    func checkFields() -> Bool {
        if let name = nameTextField.text, name.isEmpty {
            return false
        } else if let company = companyTextField.text, company.isEmpty {
            return false
        } else if let fromDate = fromDateTextField.text, fromDate.isEmpty {
            return false
        } else if let untilDate = untilDateTextField.text, untilDate.isEmpty {
            return false
        } else if let experience = experienceTextView.text, experience.isEmpty {
            return false
        } else {
            self.doneButton.isEnabled = true
            return true
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == companyTextField {
            textField.resignFirstResponder()
        } else if textField == nameTextField {
            companyTextField.becomeFirstResponder()
        }
        return true
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        _ = checkFields()
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if textView == experienceTextView {
            if text == "\n" {
                textView.resignFirstResponder()
                return false
            }
            return true
        }
        return true
    }

}
