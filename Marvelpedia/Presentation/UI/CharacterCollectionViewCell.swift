//
//  CharacterCollectionViewCell.swift
//  Marvelpedia
//
//  Created by Aitor on 19/09/2020.
//  Copyright © 2020 Aitor. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireImage

class CharacterCollectionViewCell: UICollectionViewCell {
    
    // MARK: - IBOutlets
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    // MARK: - Private constants
    
    private let placeholderImage = "character_placeholder.png"

    // MARK: - Public Functions
    
    func drawData(character: Character) {
        self.layer.cornerRadius = 10
        if let thumbnail = character.thumbnail, let url = URL(string: thumbnail) {
            imageView.af.setImage(withURL: url, placeholderImage: UIImage(named: placeholderImage))
        }
        if let name = character.name {
            nameLabel.text = name
        }
    }
}
