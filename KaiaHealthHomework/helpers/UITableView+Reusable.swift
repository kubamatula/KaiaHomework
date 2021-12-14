//
//  UITableView+Reusable.swift
//  KaiaHealthHomework
//
//  Created by Jakub Matula on 12/12/2021.
//

import UIKit

protocol Reusable: AnyObject {
    static var reusableIdentifier: String { get }
}

extension Reusable {
    static var reusableIdentifier: String {
        String(describing: self)
    }
}

extension UITableView {
    func dequeueReusableCell<T: Reusable>(for indexPath: IndexPath) -> T where T: UITableViewCell {
        guard let cell = dequeueReusableCell(withIdentifier: T.reusableIdentifier, for: indexPath) as? T else {
            fatalError("Unknown class type for cell")
        }
        return cell
    }

    func registerReusableCell<T: Reusable>(_ cellType: T.Type) where T: UITableViewCell {
        register(cellType.self, forCellReuseIdentifier: cellType.reusableIdentifier)
    }
}
