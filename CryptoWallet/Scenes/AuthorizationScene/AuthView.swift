import UIKit
import SnapKit

class AuthViewController: UIViewController {

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Авторизация"
        label.textAlignment = .center
        label.font = UIFont.boldSystemFont(ofSize: 24)
        return label
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white

        view.addSubview(titleLabel)

        titleLabel.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
    }
}
