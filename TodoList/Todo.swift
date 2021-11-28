//
//  Todo.swift
//  TodoList
//
//  Created by Aishwarya Shrestha on 27/11/2021.
//

import Foundation

struct Todo {
    let title: String
    let isComplete: Bool
    let hasDueDate:Bool
    //let dueDate: Date
    let notes: String
    
    init(title: String, isComplete: Bool = false, hasDueDate:Bool = false, notes:String="") {
        self.title = title
        self.isComplete = isComplete
        self.hasDueDate=hasDueDate
        // self.dueDate = dueDate
        self.notes=notes
    }
    
    // handle swipe right
    func completeToggled() -> Todo {
        return Todo(title: title, isComplete: !isComplete)
    }
}
