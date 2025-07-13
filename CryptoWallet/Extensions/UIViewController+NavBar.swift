import UIKit
import SnapKit

// MARK: - NavigationBar extension

extension UIViewController {
    func addCustomNavigationBar(title: String, showsRightButton: Bool = true, onRightButtonTap: (() -> Void)? = nil) -> CustomNavigationBar {
        let navBar = CustomNavigationBar(title: title, showsRightButton: showsRightButton)
        view.addSubview(navBar)
        
        navBar.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(50)
            make.leading.trailing.equalToSuperview()
        }
        
        if showsRightButton {
            navBar.addTargetToMoreButton()
            navBar.moreButton.addAction(UIAction { _ in
                onRightButtonTap?()
            }, for: .touchUpInside)
        }
        return navBar
    }
}
