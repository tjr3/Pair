//
//  PairRandomizerTableViewController.swift
//  List Randomizer
//
//  Created by Tyler on 7/8/16.
//  Copyright © 2016 Tyler. All rights reserved.
//

import UIKit
import CoreData

class PairRandomizerTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        PersonController.sharedController.fetchedResultsController.delegate = self
    }
    

    // MARK: - Action Buttons
    
    @IBAction func addButtonTapped(sender: AnyObject) {
        presentAlertController()
    }
    
    @IBAction func randomizerTapped(sender: AnyObject) {
        
    }
    
    
    
    // MARK: - Alert Controller
    
    func presentAlertController() {
        
        var nameTextField: UITextField?
        
        let alertController = UIAlertController(title: "Add Person", message: "Add someone new to the list.", preferredStyle: .Alert)
        alertController.addTextFieldWithConfigurationHandler { (textField) in
            textField.placeholder = "Full Name" 
            nameTextField = textField
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .Cancel, handler: nil)
        let confirmAction = UIAlertAction(title: "Add", style: .Default) { (_) in
            guard let name = nameTextField?.text where name.characters.count > 0 else { return }
            PersonController.sharedController.addPerson(name)
        }
        
        alertController.addAction(cancelAction)
        alertController.addAction(confirmAction)
        
        presentViewController(alertController, animated: true, completion: nil)

    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        guard let sections = PersonController.sharedController.fetchedResultsController.sections else { return 0 }
        return sections.count
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let sections = PersonController.sharedController.fetchedResultsController.sections else { return 0 }
        return sections[section].numberOfObjects ?? 2 
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
       guard let cell = tableView.dequeueReusableCellWithIdentifier("nameCell", forIndexPath: indexPath) as? NameTableViewCell,
        person = PersonController.sharedController.fetchedResultsController.objectAtIndexPath(indexPath) as? Person else {
            return UITableViewCell()
        }
        cell.updateWithPerson(person)
        return cell
    }
    
    override func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        guard let sections = PersonController.sharedController.fetchedResultsController.sections else { return nil }
        let value = Int(sections[section].name)
        if value == 0 {
            return "Group 2"
        } else {
            return "Group 1"
        }
        
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

extension PairRandomizerTableViewController: NSFetchedResultsControllerDelegate {
    
    func controllerWillChangeContent(controller: NSFetchedResultsController) {
        tableView.beginUpdates()
    }
    
    func controller(controller: NSFetchedResultsController, didChangeSection sectionInfo: NSFetchedResultsSectionInfo, atIndex sectionIndex: Int, forChangeType type: NSFetchedResultsChangeType) {
        switch type {
        case .Delete:
            tableView.deleteSections(NSIndexSet(index: sectionIndex), withRowAnimation: .Automatic)
        case .Insert:
            tableView.insertSections(NSIndexSet(index: sectionIndex), withRowAnimation: .Automatic)
        default:
            break
        }
    }
    func controller(controller: NSFetchedResultsController, didChangeObject anObject: AnyObject, atIndexPath indexPath: NSIndexPath?, forChangeType type: NSFetchedResultsChangeType, newIndexPath: NSIndexPath?) {
        switch type {
        case .Delete:
            guard let indexPath = indexPath else {return}
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Automatic)
        case .Insert:
            guard let newIndexPath = newIndexPath else {return}
            tableView.insertRowsAtIndexPaths([newIndexPath], withRowAnimation: .Automatic)
        case .Update:
            guard let indexPath = indexPath else {return}
            tableView.reloadRowsAtIndexPaths([indexPath], withRowAnimation: .Automatic)
        case .Move:
            guard let indexPath = indexPath, newIndexPath = newIndexPath else {return}
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Automatic)
            tableView.insertRowsAtIndexPaths([newIndexPath], withRowAnimation: .Automatic)
        }
    }
    
    func controllerDidChangeContent(controller: NSFetchedResultsController) {
        tableView.endUpdates()
    }
}
