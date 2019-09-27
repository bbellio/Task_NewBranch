//
//  ButtonTableViewCell.swift
//  Task
//
//  Created by Bethany Wride on 9/26/19.
//  Copyright © 2019 Bethany Wride. All rights reserved.
//

import UIKit

protocol ButtonTableViewCellDelegate {
    func buttonCellButtonTapped(_ sender: ButtonTableViewCell)
    
}

class ButtonTableViewCell: UITableViewCell {
    
    var delegate: ButtonTableViewCellDelegate?
    
    @IBOutlet weak var primaryLabel: UILabel!
    @IBOutlet weak var completeButton: UIButton!
    
    @IBAction func completeButtonTapped(_ sender: Any) {
        delegate?.buttonCellButtonTapped(self)
    }
    
    func updateButton(_ isComplete: Bool) {
        let imageName = isComplete ? "complete" : "incomplete"
        completeButton.setImage(UIImage(named: imageName), for: .normal)
    }
}

extension ButtonTableViewCell {
    func update(with task: Task) {
        updateButton(task.isComplete)
        primaryLabel.text = task.name
    }
}
