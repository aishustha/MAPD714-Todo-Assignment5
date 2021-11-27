//
//  Todo.swift
//  TodoList
//
//  Created by Aishwarya Shrestha on 27/11/2021.
//

import Foundation

//store data about todo items
struct Todo {
    let title: String
    let isComplete: Bool
    
    init(title: String, isComplete: Bool = false) {
        self.title = title
        self.isComplete = isComplete
    }
    
    func completeToggled() -> Todo {
        return Todo(title: title, isComplete: !isComplete)
    }
}
