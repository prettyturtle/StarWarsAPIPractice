//
//  CharacterCollectionViewCell.swift
//  StarWarsCharacters
//
//  Created by yc on 2021/11/04.
//

import UIKit

class CharacterCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        self.contentView.layer.borderWidth = 1.0
        self.contentView.layer.borderColor = UIColor.lightGray.cgColor
        self.contentView.layer.cornerRadius = 3.0
    }
}
