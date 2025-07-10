import UIKit
import SnapKit

final class CustomNavigationBar: UIView {
    
    // MARK: - UI Elements
    
    let homeLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Poppins-Bold", size: 32)
        label.textColor = .white
        return label
    }()
    
    let moreButton: UIButton = {
        let button = UIButton(type: .system)
        let config = UIImage.SymbolConfiguration(pointSize: 16, weight: .medium)
        let image = UIImage(systemName: "ellipsis", withConfiguration: config)
        button.setImage(image, for: .normal)
        button.tintColor = .black
        button.backgroundColor = .background
        button.layer.cornerRadius = 24
        return button
    }()
    
    let popupMenuView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 16
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOpacity = 0.1
        view.layer.shadowRadius = 8
        view.isHidden = true
        return view
    }()
    
    let updateButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Обновить", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = UIFont(name: "Poppins-Light", size: 18)
        button.contentHorizontalAlignment = .leading
        return button
    }()
    
    
    let logoutButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Выйти", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = UIFont(name: "Poppins-Light", size: 18)
        button.contentHorizontalAlignment = .leading
        return button
    }()
    
    let rocketImageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "rocketIcon"))
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    let trashImageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "trashIcon"))
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    // MARK: - Init
    
    init(title: String, showsRightButton: Bool = true) {
        super.init(frame: .zero)
        homeLabel.text = title
        
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupActions() {
        moreButton.addTarget(self, action: #selector(togglePopup), for: .touchUpInside)
    }
    
    @objc func togglePopup() {
        if popupMenuView.isHidden {
            popupMenuView.alpha = 0
            popupMenuView.isHidden = false
            UIView.animate(withDuration: 0.2) {
                self.popupMenuView.alpha = 1
            }
        } else {
            UIView.animate(withDuration: 0.2, animations: {
                self.popupMenuView.alpha = 0
            }) { _ in
                self.popupMenuView.isHidden = true
            }
        }
    }
}

// MARK: - Setup UI

extension CustomNavigationBar {
    
    func setupUI() {
        backgroundColor = .clear
        
        [homeLabel, moreButton, popupMenuView].forEach { addSubview($0) }
        [updateButton, logoutButton, rocketImageView, trashImageView].forEach { popupMenuView.addSubview($0) }
        setupConstraints()
    }
    
    func setupConstraints() {
        
        homeLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().inset(20)
            make.centerY.equalToSuperview()
        }
        
        moreButton.snp.makeConstraints { make in
            make.trailing.equalToSuperview().inset(20)
            make.centerY.equalToSuperview()
            make.width.height.equalTo(48)
        }
        
        popupMenuView.snp.makeConstraints { make in
            make.top.equalTo(moreButton.snp.bottom).offset(8)
            make.trailing.equalToSuperview().inset(29)
            make.width.equalTo(157)
        }
        
        updateButton.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(16)
            make.leading.equalToSuperview().inset(50)
            make.height.equalTo(27)
        }
        
        logoutButton.snp.makeConstraints { make in
            make.top.equalTo(updateButton.snp.bottom).offset(16)
            make.leading.equalToSuperview().inset(50)
            make.bottom.equalToSuperview().inset(16)
            make.height.equalTo(27)
        }
        
        rocketImageView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(16)
            make.leading.equalToSuperview().inset(20)
            make.size.equalTo(27)
        }
        
        trashImageView.snp.makeConstraints { make in
            make.top.equalTo(rocketImageView.snp.bottom).offset(16)
            make.leading.equalToSuperview().inset(20)
            make.size.equalTo(27)
        }
        
        self.snp.makeConstraints { make in
            make.height.equalTo(60)
        }
    }
}
