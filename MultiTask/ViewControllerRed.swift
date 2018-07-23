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
    var noteItem: [NSManagedObject] = []
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Task")
        
        do{
            noteItem = try context.fetch(fetchRequest)
        } catch {
            print ("Error loading data")
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

    var textField: UITextField!
    
    func titleTextField(mTextField: UITextField!) {
        textField = mTextField
        textField.placeholder = "Bilješka"
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return noteItem.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let note = noteItem[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = note.value(forKey: "note") as? String
        return cell
    }
    
    @IBAction func addNote(_ sender: UIButton) {
        let popup = UIAlertController(title: "Dodaj bilješku", message: "", preferredStyle: .alert)
        let addAction = UIAlertAction(title: "Save", style: .default, handler: self.save)
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        popup.addAction(addAction)
        popup.addAction(cancelAction)
        popup.addTextField(configurationHandler: titleTextField)
        self.present(popup, animated: true, completion: nil)
    }
    
    func save(alert : UIAlertAction){
        if(textField.text != ""){
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            let context = appDelegate.persistentContainer.viewContext
            let entity = NSEntityDescription.entity(forEntityName: "Task", in: context)
            let theTask = NSManagedObject(entity: entity!, insertInto: context)
            theTask.setValue(textField.text, forKey: "note")
            
            do{
                try context.save()
                noteItem.append(theTask)
            } catch {
                print ("Error saving")
            }
            
            self.tableView.reloadData()
        }
    }
    
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == UITableViewCellEditingStyle.delete{
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            let context = appDelegate.persistentContainer.viewContext
            context.delete(noteItem[indexPath.row])
            noteItem.remove(at: indexPath.row)
        
            do{
                try context.save()
            } catch {
                print ("Error deleting")
            }
            
            self.tableView.reloadData()
        }
    }
    
}
