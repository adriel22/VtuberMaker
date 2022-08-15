//
//  UITableView+Cells.swift
//  VtuberMaker
//
//  Created by Adriel Freire on 09/08/22.
//

import UIKit
extension UITableView {
    func registerCell(type: UITableViewCell.Type, identifier: String? = nil) {
        let cellId = String(describing: type)
        register(UINib(nibName: cellId, bundle: nil), forCellReuseIdentifier: identifier ?? cellId)
    }
    func registerReusableHeaderFooter(type: UITableViewHeaderFooterView.Type, identifier: String? = nil) {
        let headerId = String(describing: type)
        register(UINib(nibName: headerId, bundle: nil),
                 forHeaderFooterViewReuseIdentifier: identifier ?? headerId)
    }
    
    func dequeue<T: UITableViewCell>(withType type: T.Type,
                                     for indexPath: IndexPath,
                                     configure: @escaping ((T)->Void)) -> UITableViewCell {
        let cell = dequeueReusableCell(withIdentifier: type.identifier, for: indexPath)
        guard let cell = cell as? T else {
            fatalError("Unexpected cell type")
        }
        configure(cell)
        return cell
    }
    func dequeueReusableHeaderFooter<T: UITableViewHeaderFooterView>
    (withType type: T.Type,
     configure: @escaping((T)->Void)) -> UITableViewHeaderFooterView {
        let header = dequeueReusableHeaderFooterView(withIdentifier: type.identifier)
        guard let header = header as? T else {
            fatalError("Unexpected reusable header footer view")
        }
        configure(header)
        return header
    }
}

extension UITableViewCell {
    static var identifier: String {
        return String(describing: self)
    }
}

extension UITableViewHeaderFooterView {
    static var identifier: String {
        return String(describing: self)
    }
}
