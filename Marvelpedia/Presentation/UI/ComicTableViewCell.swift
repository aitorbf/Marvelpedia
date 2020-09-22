//
//  ComicTableViewCell.swift
//  Marvelpedia
//
//  Created by Aitor on 21/09/2020.
//  Copyright © 2020 Aitor. All rights reserved.
//

import UIKit

class ComicTableViewCell: UITableViewCell {

    @IBOutlet weak var comicImageView: UIImageView!
    @IBOutlet weak var comicTitleLabel: UILabel!
    @IBOutlet weak var comicDescriptionLabel: UILabel!
    @IBOutlet weak var comicPagesLabel: UILabel!
    @IBOutlet weak var comicPrintPriceLabel: UILabel!
    @IBOutlet weak var comicDigitalPriceLabel: UILabel!
    @IBOutlet weak var comicDescriptionHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var printPriceBottomConstraint: NSLayoutConstraint!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        selectionStyle = .none
    }
    
    // MARK: - Public functions
    
    func drawData(comic: Comic) {
        if let thumbnail = comic.thumbnail {
            comicImageView.af.setImage(withURL: URL(string: thumbnail)!)
        }
        comicTitleLabel.text = comic.title
        if let description = comic.description, description != "" {
            comicDescriptionLabel.text = comic.description
            comicDescriptionLabel.isHidden = false
            comicDescriptionHeightConstraint.constant = 64
            printPriceBottomConstraint.constant = 0
        } else {
            comicDescriptionLabel.isHidden = false
            comicDescriptionHeightConstraint.constant = 0
            printPriceBottomConstraint.constant = 64
        }
        comicPagesLabel.text = comic.pages != nil ? String(comic.pages!) : "-"
        comicPrintPriceLabel.text = comic.printPrice != nil ? "$\(String(comic.printPrice!))" : "-"
        comicDigitalPriceLabel.text = comic.digitalPrice != nil ? "$\(String(comic.digitalPrice!))" : "-"
    }
    
}
