//
//  ViewController.swift
//  TodoList
//
//  Created by Aishwarya Shrestha on 27/11/2021.
//

import UIKit

class ViewController: UIViewController {
    
    //array of todo items
    let todos = [
        Todo(title: "Make vanilla pudding."),
        Todo(title: "Put pudding in a mayo jar."),
        Todo(title: "Eat it in a public place."),
    ]

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func checkChanged(_ sender: Checkbox) {
        print("Checkbox \(sender.checked ? "Checked" : "Unchecked")")
    }
    
}

extension ViewController: UITableViewDataSource {
  
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //how many rows goes in each section
        return todos.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //what is the content goes in each row
        //get current items out of array
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "checked cell", for: indexPath) as! CheckTableViewCell
        
        let todo = todos[indexPath.row]
        
       
        cell.set(title: todo.title, checked: todo.isComplete)
        return cell
    }
}
