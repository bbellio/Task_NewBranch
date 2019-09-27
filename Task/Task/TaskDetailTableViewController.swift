//
//  TaskDetailTableViewController.swift
//  Task
//
//  Created by Bethany Wride on 9/25/19.
//  Copyright © 2019 Bethany Wride. All rights reserved.
//

import UIKit

class TaskDetailTableViewController: UITableViewController {
    // MARK: - Global Variables
    // Receiver
    var taskToReceive: Task? {
        didSet {
            updateViews()
        }
    }
    
    var dueDateValue: Date?
    
    // MARK: - Outlets
    @IBOutlet weak var taskNameTextField: UITextField!
    @IBOutlet weak var taskDateTextField: UITextField!
    @IBOutlet weak var taskNotesTextView: UITextView!
    @IBOutlet var dueDatePicker: UIDatePicker!
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        updateViews()
        taskDateTextField.inputView = dueDatePicker
    }
    
    // MARK: - Actions
    
    @IBAction func datePickerValueChanged(_ sender: UIDatePicker) {
        taskDateTextField.text = sender.date.stringValue()
        dueDateValue = sender.date
    }
    
    @IBAction func userTappedView(_ sender: Any) {
        taskNameTextField.resignFirstResponder()
        taskDateTextField.resignFirstResponder()
        taskNotesTextView.resignFirstResponder()
    }
    
    @IBAction func saveButtonTapped(_ sender: Any) {
        guard let taskName = taskNameTextField.text,
            let taskNotes = taskNotesTextView.text,
            let taskDueDate = dueDateValue
            else { return }
        if let task = taskToReceive {
            TaskController.sharedInstance.update(task: task, name: taskName, notes: taskNotes, due: taskDueDate)
        } else {
            TaskController.sharedInstance.addTask(with: taskName, notes: taskNotes, due: taskDueDate)
        }
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func cancelButtonTapped(_ sender: Any) {
        updateViews()
        navigationController?.popViewController(animated: true)
    }
    
    func updateViews(){
        guard let task = taskToReceive, isViewLoaded else { return }
        taskNameTextField.text = task.name
        taskDateTextField.text = task.due?.stringValue()
        taskNotesTextView.text = task.notes
        // could also put the second receiver here
        // dueDateValue.date = task.due
        
    }
}
