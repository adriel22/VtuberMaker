//
//  AvatarTableViewCell.swift
//  VtuberMaker
//
//  Created by Adriel Freire on 09/08/22.
//

import UIKit

class AvatarTableViewCell: UITableViewCell {

    @IBOutlet weak var containerView: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
        setupInitialConfiguration()
    }

    private func setupInitialConfiguration() {
        containerView.layer.cornerRadius = Constants.containerCornerRadius
    }
}

fileprivate struct Constants {
    static let containerCornerRadius: CGFloat = 14
}
