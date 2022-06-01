//
//  MyGroupTableViewCell.swift
//  Sveta's task by Ivan
//
//  Created by mac on 13.05.2022.
//

import UIKit

class MyGroupTableViewCell: UITableViewCell {
    
        //MARK: - Static
    static let identifier = String(describing: MyGroupTableViewCell.self)
    static func nib() -> UINib {
        return UINib(nibName: String(describing: MyGroupTableViewCell.self), bundle: nil)
    }

        //MARK: -  @IBOu
    @IBOutlet weak var groupNameLabel: UILabel!
    @IBOutlet weak var groupImageView: UIImageView!
    
    
    func configure(with model: SimpleGroup) {
        groupImageView.image = UIImage(named: model.thumbnailPhoto.name)
        groupNameLabel.text = model.name
    }
    
    
    
}
