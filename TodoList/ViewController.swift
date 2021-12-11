/**
 * ViewController.swift
  * Students                 : Keshav Dulal (301209947), Aishwarya Shrestha (301138662)
  * Course                   : MAPD iOS App Development
  * Submission Date   : 11/28/2021
  * Exercise Number   : A5 - Todo App - Part 2 - Logic for Data Persistence
  * Github Repo          : https://github.com/aishustha/MAPD714-Todo-Assignment5
  */


import UIKit 
import Firebase

class ViewController: UIViewController {
    
    // Array of prefilled todos
    var todos = [
        Todo(title: "Shop groceries"),
        Todo(title: "Put old stuffs on sale"),
        Todo(title: "Text Aishwarya"),
    ]
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    
    
//    @IBAction func checkChanged(_ sender: Checkbox) {
//        print("Checkbox \(sender.checked ? "Checked" : "Unchecked")")
//    }
//    
    // Enable Multi-Delete behavior in table view
    @IBAction func startEditing(_ sender: Any) {
        tableView.isEditing = !tableView.isEditing
    }
    
    // launch Edit-todo UI for selected row
    @IBSegueAction func todoViewController(_ coder: NSCoder) -> TodoViewController? {
        let vc =  TodoViewController(coder: coder)
        
        if let indexpath = tableView.indexPathForSelectedRow {
            let todo = todos[indexpath.row]
            vc?.todo = todo
        }
        
        vc?.delegate = self
        vc?.presentationController?.delegate = self
        return vc
    }
    
    
    // launch Add-Todo UI (just like above)
    // todo: make it work with single IBSegueAction
    @IBSegueAction func addTodoVC(_ coder: NSCoder) -> TodoViewController? {
//        return <#TodoViewController(coder: coder)#>
        
        let vc =  TodoViewController(coder: coder)
        
        if let indexpath = tableView.indexPathForSelectedRow {
            let todo = todos[indexpath.row]
            vc?.todo = todo
        }
        
        vc?.delegate = self
        
        // detach previously clicked todo item
        vc?.presentationController?.delegate = self
        return vc
    }
}

extension ViewController: UITableViewDelegate {
    
    // handle swipe right action
    // i.e. Mark todo as complete
    func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        // closure
        let action = UIContextualAction(style: .normal, title: "Complete") { action, view, complete in
            
            // completion logic
            let todo = self.todos[indexPath.row].completeToggled()
            self.todos[indexPath.row] = todo
            
            let cell = tableView.cellForRow(at: indexPath) as! CheckTableViewCell
            cell.set(checked: todo.isComplete)
            
            complete(true)
            
            //  print("complete")
        }
        
        return UISwipeActionsConfiguration(actions: [action])
    }
    
    // handle swipe left
    // i.e. delete todo
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .delete
    }
    
}

// feed data to UITableView via ViewController
// similar to using a delegate
extension ViewController: UITableViewDataSource {
    // section -> rows -> content
    
    //    func numberOfSections(in tableView: UITableView) -> Int {
    //        return 1
    //    }
    
    // return number of items to be shown in the UITableView
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return todos.count
    }
    
    // return a UIView inside each UITableView to be rendered
    // internal component of a todo-item.
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // ask UITable view to create cell using this method
        // & cast to custom type
        let cell = tableView.dequeueReusableCell(withIdentifier: "checked cell", for: indexPath) as! CheckTableViewCell
        
        // linking to the delegate created in CheckTableViewCell
        // for passing data from todo to VC
        cell.delegate = self
        
        // current item (todo)
        let todo = todos[indexPath.row]
        
        // calling the method on CheckTableViewCell
        cell.set(title: todo.title, checked: todo.isComplete)
        
        
       
       
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            todos.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .automatic)
        }
    }
    
    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        let todo = todos.remove(at: sourceIndexPath.row)
        todos.insert(todo, at: destinationIndexPath.row)
    }
    
}


// conform to the Protocol &
// implement the method
extension ViewController: CheckTableViewCellDelegate {
    
    // figure out the todo associated with the cell
    // and adjust its state
    func checkTableViewCell(_ cell: CheckTableViewCell, didChagneCheckedState checked: Bool) {
        guard let indexPath = tableView.indexPath(for: cell) else {
            return
        }
        
        let todo = todos[indexPath.row]
        
        // creating newTodo item to replace current todo item as it isn't directly editable
        let newTodo = Todo(title: todo.title, isComplete: checked)
        
        todos[indexPath.row] = newTodo
    }
    
}


extension ViewController: TodoViewControllerDelegate {
    
    // called whenever you edit a todo or add a new one
    func todoViewController(_ vc: TodoViewController, didSaveTodo todo: Todo) {
        
        // dissmiss VC
        // and once dismissed add/or edit todos on view w/Animation
        dismiss(animated: true) {
            // look for selected cell to determine mode(edit / add new) with indexPath
            if let indexPath = self.tableView.indexPathForSelectedRow {
                // update selected todo
                self.todos[indexPath.row] = todo
                self.tableView.reloadRows(at: [indexPath], with: .none)
            } else {
                // create new todo
                self.todos.append(todo)
                self.tableView.insertRows(at: [IndexPath(row: self.todos.count-1, section: 0)], with: .automatic)
            }
        }
        
    }
    
}


extension ViewController: UIAdaptivePresentationControllerDelegate {
    
    func presentationControllerDidDismiss(_ presentationController: UIPresentationController) {
        if let indexPath = tableView.indexPathForSelectedRow {
            tableView.deselectRow(at: indexPath, animated: true)
        }
    }
    
}

