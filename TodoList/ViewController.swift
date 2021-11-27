//
//  ViewController.swift
//  TodoList
//
//  Created by Aishwarya Shrestha on 27/11/2021.
//

import UIKit

class ViewController: UIViewController {
    
    //array of todo items
    var todos = [
        Todo(title: "Make vanilla pudding."),
        Todo(title: "Put pudding in a mayo jar."),
        Todo(title: "Eat it in a public place."),
    ]

    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func checkChanged(_ sender: Checkbox) {
        print("Checkbox \(sender.checked ? "Checked" : "Unchecked")")
    }
    
    @IBAction func startEditing(_ sender: Any) {
        tableView.isEditing = !tableView.isEditing
    }
}

extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let action = UIContextualAction(style: .normal, title: "Complete") {
            action, view, complete in
            let todo = self.todos[indexPath.row].completeToggled()
            self.todos[indexPath.row] = todo
            
            let cell = tableView.cellForRow(at: indexPath) as! CheckTableViewCell
            cell.set(checked: todo.isComplete)

            complete(true)
            print("complete")
        }
        
        return UISwipeActionsConfiguration( actions: [action])
    }
    
func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) ->
    UITableViewCell.EditingStyle {
        return .delete
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
        
        cell.delegate = self
        let todo = todos[indexPath.row]
        
       
        cell.set(title: todo.title, checked: todo.isComplete)
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            todos.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .automatic)
        }
    }
    
//    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath:
//    
//                   IndexPath, to destiationIndexPath: IndexPath) {
//        let todo = todos.remove
//    }
}

extension ViewController: CheckTableViewCellDelegate {
    func checkTableViewCell(_ cell: CheckTableViewCell, didChangeCheckedState checked: Bool) {
        
        guard let indexPath = tableView.indexPath(for: cell)
        else {
            return
        }
        
        let todo = todos[indexPath.row]
        let newTodo = Todo(title: todo.title, isComplete: checked)
        
        todos[indexPath.row] = newTodo
    }
}
