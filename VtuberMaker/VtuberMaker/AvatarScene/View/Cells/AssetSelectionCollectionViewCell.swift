//
//  AssetSelectionCollectionViewCell.swift
//  VtuberMaker
//
//  Created by Adriel Freire on 13/10/22.
//

import UIKit

class AssetSelectionCollectionViewCell: UICollectionViewCell {
    @IBOutlet private weak var thumbnailImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func configure(_ thumbnailTitle: String) {
        let thumbnailImage = UIImage(named: thumbnailTitle)
        thumbnailImageView.image = thumbnailImage
    }

}
