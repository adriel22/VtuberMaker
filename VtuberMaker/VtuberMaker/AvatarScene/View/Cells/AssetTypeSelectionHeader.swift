//
//  AssetTypeSelectionHeader.swift
//  VtuberMaker
//
//  Created by Adriel Freire on 13/10/22.
//

import UIKit

class AssetTypeSelectionHeader: UICollectionReusableView {
    @IBOutlet private weak var typeButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func configure(withType type: String) {
        typeButton.setTitle(type, for: .normal)
    }
}
