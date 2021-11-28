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

protocol TodoViewControllerDelegate: AnyObject {
    // called everytime Save button is clicked
  func todoViewController(_ vc: TodoViewController, didSaveTodo todo: Todo)
}

// when
class TodoViewController: UIViewController {
    
    @IBOutlet weak var textfield: UITextField!
    var todo: Todo?
     
    weak var delegate: TodoViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        textfield.text = todo?.title
    }
    

    // create brand new todo
    @IBAction func save(_ sender: Any) {
        let todo = Todo(title: textfield.text!)
        
        // send brand new todo back with delegate
        delegate?.todoViewController(self, didSaveTodo: todo)
    }
    
}

