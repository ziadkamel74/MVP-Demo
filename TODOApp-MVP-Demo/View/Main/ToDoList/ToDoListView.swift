//
//  ToDoListView.swift
//  TODOApp-MVP-Demo
//
//  Created by Ziad on 11/24/20.
//  Copyright © 2020 IDEAEG. All rights reserved.
//

import UIKit

class ToDoListView: UIView {
    
    // MARK:- Outlets
    @IBOutlet weak var tableView: UITableView!
    
    func setup() {
        tableView.separatorStyle = .none
        tableView.register(UINib(nibName: Cells.toDoCell, bundle: nil), forCellReuseIdentifier: Cells.toDoCell)
    }
}
