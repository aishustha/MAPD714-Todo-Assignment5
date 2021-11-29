/**
  * CheckTableViewCell.swift
  * Subcalass of UITableViewCell - supports interaction with UITableView Item
  * Students                 : Keshav Dulal (301209947), Aishwarya Shrestha (301138662)
  * Course                   : MAPD iOS App Development
  * Submission Date   : 11/28/2021
  * Exercise Number   : A5 - Todo App - Part 2 - Logic for Data Persistence
  * Github Repo          : https://github.com/aishustha/MAPD714-Todo-Assignment5
  */


import UIKit
 
protocol CheckTableViewCellDelegate: AnyObject {
    // called via delegate object
    // whenever checkbox changes state
  func checkTableViewCell(_ cell: CheckTableViewCell, didChagneCheckedState checked: Bool)
}

class CheckTableViewCell: UITableViewCell {

    // Todo item's label and status(checkbox)
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var checkswitch: UISwitch!
    
    // self-delegate 
    weak var delegate: CheckTableViewCellDelegate?
    
    // checkbox action handler
    @IBAction func checked(_ sender: UISwitch) {
        updateChecked()
        
        // delegate is being called from here
        delegate?.checkTableViewCell(self, didChagneCheckedState: checkswitch.isOn)
      }
    
    
   
       
    // function to be used by ViewController when it's using the cell
    func set(title: String, checked: Bool) {
      label.text = title
      set(checked: checked)
    }
    
    func set(checked: Bool) {
      checkswitch.isOn = checked
      updateChecked()
    }
    
    // cross a todo once checked & vice-versa
    private func updateChecked() {
      let attributedString = NSMutableAttributedString(string: label.text!)
      
      if checkswitch.isOn {
        attributedString.addAttribute(.strikethroughStyle, value: 2, range: NSMakeRange(0, attributedString.length-1))
      } else {
        attributedString.removeAttribute(.strikethroughStyle, range: NSMakeRange(0, attributedString.length-1))
      }
      
      label.attributedText = attributedString
    }
    

  }
