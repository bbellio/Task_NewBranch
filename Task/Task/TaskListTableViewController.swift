//
//  TaskListTableViewController.swift
//  Task
//
//  Created by Bethany Wride on 9/25/19.
//  Copyright © 2019 Bethany Wride. All rights reserved.
//

import UIKit
import CoreData

class TaskListTableViewController: UITableViewController, ButtonTableViewCellDelegate {
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        TaskController.sharedInstance.fetchedResultsController.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }
    // MARK: - Functions
    func buttonCellButtonTapped(_ sender: ButtonTableViewCell) {
        guard let index = tableView.indexPath(for: sender) else { return }
        let task = TaskController.sharedInstance.fetchedResultsController.object(at: index)
        TaskController.sharedInstance.toggleIsCompleteFor(task: task)
        sender.update(with: task)
    }
    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return TaskController.sharedInstance.fetchedResultsController.sectionIndexTitles[section] == "1" ? "Complete" : "Incomplete"
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return TaskController.sharedInstance.fetchedResultsController.sections?.count ?? 0
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return TaskController.sharedInstance.fetchedResultsController.sections?[section].numberOfObjects ?? 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell: ButtonTableViewCell! = tableView.dequeueReusableCell(withIdentifier: "taskCell", for: indexPath) as? ButtonTableViewCell
        if cell == nil { cell = ButtonTableViewCell()}
        let task = TaskController.sharedInstance.fetchedResultsController.object(at: indexPath)
        cell?.update(with: task)
        cell?.delegate = self
        return cell
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let taskToDelete = TaskController.sharedInstance.fetchedResultsController.object(at: indexPath)
            TaskController.sharedInstance.remove(task: taskToDelete)
        }    
    }
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toTaskDetailVC" {
            if let indexForSelectedCell = tableView.indexPathForSelectedRow {
                guard let destinationVC = segue.destination as? TaskDetailTableViewController else { return }
                let taskToSend = TaskController.sharedInstance.fetchedResultsController.object(at: indexForSelectedCell)
                destinationVC.taskToReceive = taskToSend
                destinationVC.dueDateValue = taskToSend.due
            }
        }
    }
}

extension TaskListTableViewController: NSFetchedResultsControllerDelegate {
    
    func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.beginUpdates()
    }

    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.endUpdates()
    }
    
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
        
        switch type {
            
        case .delete:
            guard let indexPath = indexPath else {return}
            tableView.deleteRows(at: [indexPath], with: .automatic)
            
        case .insert:
            guard let newIndexPath = newIndexPath else {return}
            tableView.insertRows(at: [newIndexPath], with: .automatic)
            
        case .move:
            guard let oldIndexPath = indexPath, let newIndexPath = newIndexPath else {return}
            tableView.moveRow(at: oldIndexPath, to: newIndexPath)
            
        case .update:
            guard let indexPath = indexPath else {return}
            tableView.reloadRows(at: [indexPath], with: .automatic)
        @unknown default:
            fatalError()
        }
    }

    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange sectionInfo: NSFetchedResultsSectionInfo, atSectionIndex sectionIndex: Int, for type: NSFetchedResultsChangeType) {
        
        switch type {
        case .insert:
            tableView.insertSections(IndexSet(integer: sectionIndex), with: .fade)
        case .delete:
            tableView.deleteSections(IndexSet(integer: sectionIndex), with: .fade)
        case .move:
            break
        case .update:
            break
        default: return
        }
    }
}

