
import Foundation
import UIKit
import UIKit

extension UIViewController {
    static func instantiateViewController<T: UIViewController>(fromStoryboardNamed storyboardName: String = "Main") -> T {
        let storyboard = UIStoryboard(name: storyboardName, bundle: nil)
        let vcIdentifier = String(describing: self)
        return storyboard.instantiateViewController(withIdentifier: vcIdentifier) as! T
    }
}

extension UITableView {
    func dequeueReusableCell<T: UITableViewCell>(ofType cellType: T.Type, for indexPath: IndexPath) -> T {
        guard let cell = self.dequeueReusableCell(withIdentifier: String(describing: cellType), for: indexPath) as? T else {
            fatalError("Failed to dequeue cell with identifier: \(String(describing: cellType))")
        }
        return cell
    }
}

extension UICollectionView {
    func dequeueReusableCell<T: UICollectionViewCell>(ofType cellType: T.Type, for indexPath: IndexPath) -> T {
        guard let cell = self.dequeueReusableCell(withReuseIdentifier: String(describing: cellType), for: indexPath) as? T else {
            fatalError("Failed to dequeue cell with identifier: \(String(describing: cellType))")
        }
        return cell
    }
}
