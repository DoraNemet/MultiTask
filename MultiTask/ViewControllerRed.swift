//
//  ViewControllerRed.swift
//  MultiTask
//
//  Created by Dora Fundak on 21/07/2018.
//  Copyright © 2018 Dora Fundak. All rights reserved.
//

import UIKit
import CoreData

class ViewControllerRed: UIViewController, UITextFieldDelegate, UITableViewDelegate, UITableViewDataSource {

    
    @IBOutlet weak var tableView: UITableView!
    
    var itemName: [NSManagedObject] = []
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Task")
        
        do{
            itemName = try context.fetch(fetchRequest)
        } catch {
            print ("Error in loading data")
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    var titleTextField: UITextField!
    
    func titleTextField(textField: UITextField!) {
        titleTextField = textField
        titleTextField.placeholder = "note"
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemName.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let title = itemName[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = title.value(forKey: "name") as? String
        return cell
    }
    

    @IBAction func addNote(_ sender: UIButton) {
        
        let alert = UIAlertController(title: "Add your note", message: "Add your item name", preferredStyle: .alert)
        let addAction = UIAlertAction(title: "Save", style: .default, handler: self.save)
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alert.addAction(addAction)
        alert.addAction(cancelAction)
        alert.addTextField(configurationHandler: titleTextField)
        self.present(alert, animated: true, completion: nil)
    }
    
    func save(alert : UIAlertAction){
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        let entity = NSEntityDescription.entity(forEntityName: "Task", in: context)
        let theTask = NSManagedObject(entity: entity!, insertInto: context)
        theTask.setValue(titleTextField.text, forKey: "name")
        
        do{
            try context.save()
            itemName.append(theTask)
        } catch {
            print ("Error in saving")
        }
        self.tableView.reloadData()
    }
    
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == UITableViewCellEditingStyle.delete{
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            let context = appDelegate.persistentContainer.viewContext
            context.delete(itemName[indexPath.row])
            itemName.remove(at: indexPath.row)
        
        do{
            try context.save()
        } catch {
            print ("Error in deleting")
        }
        self.tableView.reloadData()
        }
    }
    
}
