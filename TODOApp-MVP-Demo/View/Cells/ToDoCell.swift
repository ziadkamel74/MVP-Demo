//
//  TodoCell.swift
//  TODOApp-MVC-Demo
//
//  Created by Ziad on 11/4/20.
//  Copyright © 2020 IDEAEG. All rights reserved.
//

import UIKit

protocol DeleteTask: ToDoListVC {
    func deleteTapped(sender: UIButton)
}

class ToDoCell: UITableViewCell {
    
    // MARK:- Outlets
    @IBOutlet weak var descriptionLabel: UILabel!
    
    // MARK:- Properties
    weak var deletion: DeleteTask?
    
    // MARK:- Public Methods
    func configure(description: String) {
        descriptionLabel.text = description
    }
    
    // MARK:- IBAction Methods
    @IBAction func deleteBtnPressed(_ sender: UIButton) {
        deletion?.deleteTapped(sender: sender)
    }
    
}
