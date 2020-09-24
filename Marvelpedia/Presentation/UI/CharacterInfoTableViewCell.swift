//
//  CharacterInfoTableViewCell.swift
//  Marvelpedia
//
//  Created by Aitor on 22/09/2020.
//  Copyright © 2020 Aitor. All rights reserved.
//

import UIKit

class CharacterInfoTableViewCell: UITableViewCell {

    @IBOutlet weak var characterImageView: UIImageView!
    @IBOutlet weak var characterNameLabel: UILabel!
    @IBOutlet weak var characterDescriptionLabel: UILabel!
    
    // MARK: - Private constants
    
    private let placeholderImage = "character_placeholder.png"
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        selectionStyle = .none
    }
    
    // MARK: - Public functions
    
    func drawData(character: Character) {
        if let thumbnail = character.thumbnail {
            characterImageView.af.setImage(withURL: URL(string: thumbnail)!, placeholderImage: UIImage(named: placeholderImage))
            characterImageView.layer.cornerRadius = 100
        }
        characterNameLabel.text = character.name ?? ""
        characterDescriptionLabel.text = character.description ?? ""
    }
}
