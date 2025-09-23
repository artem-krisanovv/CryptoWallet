import UIKit

// MARK: - Array extension

extension Array where Element: UIView {
    func addToSuperview(_ superview: UIView) {
        forEach { superview.addSubview($0) }
    }
}
