//
//  CheckTableViewCell.swift
//  TodoList
//
//  Created by Aishwarya Shrestha on 27/11/2021.
//

import UIKit

protocol CheckTableViewCellDelegate: AnyObject {
    func checkTableViewCell(_ cell: CheckTableViewCell,
                            didChangeCheckedState checked: Bool)
}

class CheckTableViewCell: UITableViewCell {

    @IBOutlet weak var label: UILabel!
    
    @IBOutlet weak var checkbox: Checkbox!
    
    @IBAction func checked(_ sender: Checkbox) {
        updateChecked()
    }
    
    func set(title: String, checked: Bool) {
        label.text = title
        checkbox.checked = checked
        updateChecked()
    }
    
    private func updateChecked() {
        let attributedString = NSMutableAttributedString(string: label.text!)
        
        if checkbox.checked {
            attributedString.addAttribute(.strikethroughStyle, value: 2, range: NSMakeRange(0, attributedString.length-1))
        }
        
        else{
            attributedString.removeAttribute(.strikethroughStyle, range: NSMakeRange(0, attributedString.length-1))
        }
        
        label.attributedText = attributedString
    }
}
