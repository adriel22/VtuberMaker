//
//  UICollectionView+Cells.swift
//  VtuberMaker
//
//  Created by Adriel Freire on 13/10/22.
//

import UIKit
extension UICollectionView {
    func registerCell(type: UICollectionViewCell.Type, identifier: String? = nil) {
        let cellId = String(describing: type)
        register(UINib(nibName: cellId, bundle: nil), forCellWithReuseIdentifier: identifier ?? cellId)
    }
    
    func registerReusableHeaderFooter(type: UICollectionReusableView.Type, kind: String, identifier: String? = nil) {
        let headerId = String(describing: type)
        register(UINib(nibName: headerId, bundle: nil), forSupplementaryViewOfKind: kind, withReuseIdentifier: identifier ?? headerId)
    }
    
    func dequeue<T: UICollectionViewCell>(withType type: T.Type,
                                     for indexPath: IndexPath,
                                     configure: @escaping ((T)->Void)) -> UICollectionViewCell {
        let cell = dequeueReusableCell(withReuseIdentifier: type.identifier, for: indexPath)
        guard let cell = cell as? T else {
            fatalError("Unexpected cell type")
        }
        configure(cell)
        return cell
    }
    
    func dequeueReusableHeaderFooter<T: UICollectionReusableView>
    (withType type: T.Type,
     kind: String,
     indexPath: IndexPath,
     configure: @escaping((T)->Void)) -> UICollectionReusableView {
        let header = dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: type.reuseIdentifier, for: indexPath)
        
        guard let header = header as? T else {
            fatalError("Unexpected reusable header footer view")
        }
        configure(header)
        return header
    }
}

extension UICollectionViewCell {
    static var identifier: String {
        return String(describing: self)
    }
}

extension UICollectionReusableView {
    static var reuseIdentifier: String {
        return String(describing: self)
    }
}
