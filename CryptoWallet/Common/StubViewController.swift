import UIKit
import SnapKit

final class StubViewController: UIViewController {
    
    // MARK: - Title Element
    
    private let titleText: String
    
    // MARK: - Init
    
    init(title: String) {
        self.titleText = title
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - UI Elements
    
    private let navBar: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        return view
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
        label.textColor = .black
        return label
    }()
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.systemGroupedBackground
        setupNavBar()
    }
}

// MARK: - Setup UI

extension StubViewController {
    
    private func setupNavBar() {
        view.addSubview(navBar)
        navBar.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(44)
        }
        
        navBar.addSubview(titleLabel)
        titleLabel.text = titleText
        titleLabel.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
    }
}
