//
//  CvVisualizationViewController.swift
//  CVVisualization
//
//  Created by Fran Lucena on 26/6/18.
//  Copyright © 2018 Fran Lucena. All rights reserved.
//

import UIKit
import CoreData

class CvVisualizationViewController: UIViewController {
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var companyLabel: UILabel!
    @IBOutlet weak var fromDateLabel: UILabel!
    @IBOutlet weak var untilDateLabel: UILabel!
    @IBOutlet weak var experienceTextView: UITextView!
    @IBOutlet weak var conocimientoLabel: UILabel!
    @IBOutlet weak var conocimientosDescriptionTextView: UITextView!
    
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    let request = NSFetchRequest<NSFetchRequestResult>(entityName: "CV")
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setLabels()
    }
    
    func setLabels() {
        
        let context = appDelegate.persistentContainer.viewContext
        
        do {
            let result = try context.fetch(request)
            for data in result as! [NSManagedObject] {
                
                if let name = data.value(forKey: "name") as? String {
                    nameLabel.text = name
                }
                
                if let company = data.value(forKey: "company") as? String {
                    companyLabel.text = company
                }
                
                if let fromDate = data.value(forKey: "fromDate") as? String {
                    fromDateLabel.text = fromDate
                }
                
                if let untilDate = data.value(forKey: "untilDate") as? String {
                    untilDateLabel.text = untilDate
                }
                
                if let experience = data.value(forKey: "experience") as? String {
                    experienceTextView.text = experience
                }
                
                if let shortDescription = data.value(forKey: "descriptionShort") as? String {
                    conocimientoLabel.text = shortDescription
                }
                
                if let largeDescription = data.value(forKey: "descriptionLarge") as? String {
                    conocimientosDescriptionTextView.text = largeDescription
                }
                
                print(data)
            }
        } catch {
            print("Error fetching objects")
        }
    }
    
    @IBAction func editButtonPressed(_ sender: Any) {
        self.performSegue(withIdentifier: "GoToModificarCV", sender: self)
    }
    
}
