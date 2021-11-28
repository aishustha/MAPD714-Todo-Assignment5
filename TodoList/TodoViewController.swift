//
//  TodoViewController.swift
//  TodoList
//
//  Created by Aishwarya Shrestha on 27/11/2021.
//

import UIKit

protocol TodoViewControllerDelegate: AnyObject {
  func todoViewController(_ vc: TodoViewController, didSaveTodo todo: Todo)
}

class TodoViewController: UIViewController {
    
    @IBOutlet weak var textfield: UITextField!
    var todo: Todo?
    
    weak var delegate: TodoViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        textfield.text = todo?.title
    }
    

    @IBAction func save(_ sender: Any) {
        let todo = Todo(title: textfield.text!)
        delegate?.todoViewController(self, didSaveTodo: todo)
    }
    
}

