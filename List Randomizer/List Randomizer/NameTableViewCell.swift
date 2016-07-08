//
//  NameTableViewCell.swift
//  List Randomizer
//
//  Created by Tyler on 7/8/16.
//  Copyright © 2016 Tyler. All rights reserved.
//

import UIKit

class NameTableViewCell: UITableViewCell {

    @IBOutlet weak var nameLabel: UILabel!
    
    var delegate: PersonTableViewCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func updateWithPerson(person: Person) {
        nameLabel.text = person.name
        delegate?.updateCellWithPerson(self)
    }

}

protocol PersonTableViewCellDelegate {
    func updateCellWithPerson(cell: NameTableViewCell)
}