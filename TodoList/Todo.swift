/**
 * Todo.swift
  * Students                 : Keshav Dulal (301209947), Aishwarya Shrestha (301138662)
  * Course                   : MAPD iOS App Development
  * Submission Date   : 11/28/2021
  * Exercise Number   : A5 - Todo App - Part 2 - Logic for Data Persistence
  * Github Repo          : https://github.com/aishustha/MAPD714-Todo-Assignment5
  */

import Foundation

struct Todo {
    let title: String
    let isComplete: Bool
    let hasDueDateSwitch:Bool
    let notes: String
    
    init(title: String, isComplete: Bool = false, hasDueDateSwitch:Bool = false, notes:String="") {
        self.title = title
        self.isComplete = isComplete
        self.hasDueDateSwitch=hasDueDateSwitch
        self.notes=notes
    }
    
    // handle swipe right
    func completeToggled() -> Todo {
            return Todo(title: title, isComplete: !isComplete, hasDueDateSwitch: !hasDueDateSwitch)
        
    }
}
