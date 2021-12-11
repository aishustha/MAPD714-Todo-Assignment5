/**
 * TodoViewController.swift
 * Second view to add todos
  * Students                 : Keshav Dulal (301209947), Aishwarya Shrestha (301138662)
  * Course                   : MAPD iOS App Development
  * Submission Date   : 11/28/2021
  * Exercise Number   : A5 - Todo App - Part 2 - Logic for Data Persistence
  * Github Repo          : https://github.com/aishustha/MAPD714-Todo-Assignment5
  */

import UIKit
import FirebaseDatabase

protocol TodoViewControllerDelegate: AnyObject {
    // called everytime Save button is clicked
    func todoViewController(_ vc: TodoViewController, didSaveTodo todo: Todo)
}

// when
class TodoViewController: UIViewController {
    private let database = Database.database().reference()

    
    @IBOutlet weak var textfield: UITextField!
    @IBOutlet weak var hasDueDateSwitch: UISwitch!
    @IBOutlet weak var notesTextField: UITextField!
    @IBOutlet weak var isCompletedSwitch2: UISwitch!
    
    var todo: Todo?
    
    weak var delegate: TodoViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        // pass value before loading
//        textfield.text = todo?.title
//
//        isCompletedSwitch2.isOn = ((todo?.isComplete) != nil) ? todo?.isComplete as! Bool : false;
//        //        hasDueDateSwitch.isOn=((todo?.hasDueDate) != nil)
//        hasDueDateSwitch.isOn=((todo?.hasDueDate) != nil) ? todo?.hasDueDate as! Bool : false;
//        notesTextField.text = todo?.notes
//
    }
    
    
    // create brand new todo
    @IBAction func save(_ sender: Any) {
        let todo = Todo(title: textfield.text!,isComplete: isCompletedSwitch2.isOn, hasDueDateSwitch: hasDueDateSwitch.isOn, notes: notesTextField.text!)
        
        //text
        database.child(textfield.text!).setValue(hasDueDateSwitch.isOn)
        //notes
        database.child(notesTextField.text!).setValue(hasDueDateSwitch.isOn)
        
        

        
        // send brand new todo back with delegate
        delegate?.todoViewController(self, didSaveTodo: todo)
    }
}

