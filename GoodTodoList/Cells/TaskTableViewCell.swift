//
//  TaskTableViewCell.swift
//  GoodTodoList
//
//  Created by Mehmet Can Şimşek on 8.12.2022.
//

import UIKit

class TaskTableViewCell: UITableViewCell {
    @IBOutlet weak var cellView: UIView!
    @IBOutlet weak var titleLbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.cellView.layer.shadowRadius = 8
        self.cellView.backgroundColor = .cyan
        self.cellView.layer.shadowColor = UIColor.systemBlue.cgColor
        self.cellView.layer.shadowOpacity = 1
        self.cellView.layer.shadowOffset = .zero
        self.cellView.layer.shadowRadius = 10
        self.clipsToBounds = true
    }
    
}
