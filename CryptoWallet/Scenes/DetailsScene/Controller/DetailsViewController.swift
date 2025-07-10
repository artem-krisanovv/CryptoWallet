import UIKit
import SnapKit

class CryptoDetailViewController: UIViewController {
    // MARK: - UI Elements
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Ethereum (ETH)"
        label.font = UIFont(name: "Poppins-Regular", size: 14)
        label.textColor = .black
        label.textAlignment = .center
        return label
    }()
    
    private let priceLabel: UILabel = {
        let label = UILabel()
        label.text = "$32,128.80"
        label.font = UIFont(name: "Poppins-Regular", size: 28)
        label.textColor = .black
        return label
    }()
    
    private let percentLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Poppins-Regular", size: 14)
        label.textColor = .lightGray
        label.text = "2.5%"
        return label
    }()
    
    private let changeLabel: UIImageView = {
        let label = UIImageView()
        label.contentMode = .scaleAspectFit
        label.image = UIImage(named: "arrowUp")
        return label
    }()
    
    let illustrationBackgroundView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .backgroundColorForDetailScreen
        imageView.layer.cornerRadius = 40
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private let marketStatsTitle: UILabel = {
        let label = UILabel()
        label.text = "Market Statistic"
        label.font = UIFont(name: "Poppins-SemiBold", size: 20)
        label.textColor = .black
        return label
    }()
    
    private let marketCapLabel: UILabel = {
        let label = UILabel()
        label.text = "Market capitalization"
        label.font = UIFont(name: "Poppins-Regular", size: 14)
        label.textColor = .darkGray
        return label
    }()
    
    private let marketCapValueLabel: UILabel = {
        let label = UILabel()
        label.text = "$231,323"
        label.font = UIFont(name: "Poppins-SemiBold", size: 14)
        label.textColor = .black
        return label
    }()
    
    private let supplyLabel: UILabel = {
        let label = UILabel()
        label.text = "Circulating Supply"
        label.font = UIFont(name: "Poppins-Regular", size: 14)
        label.textColor = .darkGray
        return label
    }()
    
    private let supplyValueLabel: UILabel = {
        let label = UILabel()
        label.text = "114.211 ETH"
        label.font = UIFont(name: "Poppins-SemiBold", size: 14)
        label.textColor = .black
        return label
    }()
    
    private let segmentBackgroundView: UIView = {
        let view = UIView()
        view.backgroundColor = .backgroundColorForSegmenter
        view.layer.cornerRadius = 27
        return view
    }()
    
    
    private var selectedFilter: TimeFilter = .h24 {
        didSet {
            updateSegmentButtons()
        }
    }
    
    private lazy var segmentButtons: [UIButton] = []
    private let segmentStack = UIStackView()
    
    private let backButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(systemName: "arrow.left"), for: .normal)
        button.tintColor = .black
        button.backgroundColor = .white
        button.layer.cornerRadius = 24
        return button
    }()
    
    private let customNavBar = UIView()
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.setNavigationBarHidden(true, animated: false)
        setupUI()
        setupConstraints()
    }
}

// MARK: - Setup UI

extension CryptoDetailViewController {
    private func setupUI() {
        view.backgroundColor = .background
        navigationController?.setNavigationBarHidden(true, animated: false)
        backButton.addTarget(self, action: #selector(backTapped), for: .touchUpInside)
        
        customNavBar.backgroundColor = .clear
        
        customNavBar.addSubview(backButton)
        
        [customNavBar, illustrationBackgroundView, titleLabel, priceLabel, percentLabel, changeLabel,
         marketStatsTitle, marketCapLabel, marketCapValueLabel,
         supplyLabel, supplyValueLabel, segmentBackgroundView, segmentStack].forEach {
            view.addSubview($0)
        }
        
        setupSegmentControl()
    }
    
    private func setupConstraints() {
        
        titleLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(74)
            make.height.equalTo(21)
        }
        
        priceLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(titleLabel.snp.bottom).offset(20)
            make.height.equalTo(21)
        }
        
        percentLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview().offset(15)
            make.height.equalTo(21)
            make.top.equalTo(priceLabel.snp.bottom).offset(10)
        }
        
        changeLabel.snp.makeConstraints { make in
            make.trailing.equalTo(percentLabel.snp.leading).offset(-5)
            make.height.width.equalTo(12)
            make.top.equalTo(priceLabel.snp.bottom).offset(13)
        }
        
        segmentBackgroundView.snp.makeConstraints { make in
            make.top.equalTo(percentLabel.snp.bottom).offset(20)
            make.leading.trailing.equalToSuperview().inset(25)
            make.height.equalTo(56)
        }
        
        segmentStack.snp.makeConstraints { make in
            make.top.equalTo(percentLabel.snp.bottom).offset(24)
            make.leading.trailing.equalToSuperview().inset(29)
            make.height.equalTo(48)
        }
        
        illustrationBackgroundView.snp.makeConstraints { make in
            make.leading.trailing.bottom.equalToSuperview()
            make.height.equalTo(242)
        }
        
        marketStatsTitle.snp.makeConstraints { make in
            make.top.equalTo(illustrationBackgroundView.snp.top).offset(25)
            make.leading.equalToSuperview().offset(25)
            make.height.equalTo(30)
        }
        
        marketCapLabel.snp.makeConstraints { make in
            make.top.equalTo(marketStatsTitle.snp.bottom).offset(15)
            make.leading.equalTo(marketStatsTitle.snp.leading)
            make.height.equalTo(30)
        }
        
        supplyLabel.snp.makeConstraints { make in
            make.top.equalTo(marketCapLabel.snp.bottom).offset(15)
            make.leading.equalTo(marketCapLabel.snp.leading)
            make.height.equalTo(21)
        }
        
        marketCapValueLabel.snp.makeConstraints { make in
            make.top.equalTo(marketCapLabel.snp.top)
            make.trailing.equalToSuperview().offset(-25)
            make.height.equalTo(21)
        }
        
        supplyValueLabel.snp.makeConstraints { make in
            make.top.equalTo(supplyLabel.snp.top)
            make.trailing.equalToSuperview().offset(-25)
            make.height.equalTo(21)
        }
        
        customNavBar.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(60)
        }
        
        backButton.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(16)
            make.centerY.equalToSuperview()
            make.width.height.equalTo(48)
        }
    }
}

// MARK: - Setup TimeSegment

extension CryptoDetailViewController {
    
    private func setupSegmentControl() {
        segmentStack.axis = .horizontal
        segmentStack.alignment = .fill
        segmentStack.distribution = .fillEqually
        segmentStack.spacing = 0
        
        for filter in TimeFilter.allCases {
            let button = UIButton(type: .system)
            button.setTitle(filter.rawValue, for: .normal)
            button.titleLabel?.font = UIFont(name: "Poppins-SemiBold", size: 14)
            button.layer.cornerRadius = 25
            button.clipsToBounds = true
            button.tag = segmentButtons.count
            button.addTarget(self, action: #selector(segmentTapped(_:)), for: .touchUpInside)
            segmentButtons.append(button)
            segmentStack.addArrangedSubview(button)
        }
        
        updateSegmentButtons()
    }
    
    @objc private func segmentTapped(_ sender: UIButton) {
        let selected = TimeFilter.allCases[sender.tag]
        selectedFilter = selected
    }
    
    private func updateSegmentButtons() {
        for (index, button) in segmentButtons.enumerated() {
            let filter = TimeFilter.allCases[index]
            let isSelected = (filter == selectedFilter)
            button.backgroundColor = isSelected ? .white : .backgroundColorForSegmenter
            button.setTitleColor(isSelected ? .black : UIColor.black.withAlphaComponent(0.4), for: .normal)
            button.layer.shadowColor = isSelected ? UIColor.black.cgColor : nil
            button.layer.shadowOpacity = isSelected ? 0.05 : 0
            button.layer.shadowRadius = isSelected ? 6 : 0
            button.layer.shadowOffset = .zero
        }
    }
}

//MARK: BackButton Method

extension CryptoDetailViewController {
    
    @objc private func backTapped() {
            navigationController?.popViewController(animated: true)
        }
    
    
}

#Preview {
    CryptoDetailViewController()
}

