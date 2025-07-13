import UIKit
import SnapKit

class CryptoItemCell: UITableViewCell {
    
    // MARK: - Initialization
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - UI Elements
    
    private let iconImageView: UIImageView = {
        let imageView = UIImageView()
        return imageView
    }()
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Poppins-SemiBold", size: 18)
        return label
    }()
    
    private let symbolLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Poppins-SemiBold", size: 14)
        label.textColor = .lightGray
        return label
    }()
    
    private let priceLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Poppins-SemiBold", size: 18)
        return label
    }()
    
    private let percentLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Poppins-SemiBold", size: 14)
        label.textColor = .lightGray
        return label
    }()
    
    private let changeLabel: UIImageView = {
        let label = UIImageView()
        label.contentMode = .scaleAspectFit
        return label
    }()
}

// MARK: - Setup UI

extension CryptoItemCell {
    private func setupUI() {
        backgroundColor = .background
        [
            iconImageView,
            nameLabel,
            priceLabel,
            changeLabel,
            percentLabel,
            symbolLabel
        ].forEach { contentView.addSubview($0) }
        
        setupConstraints()
    }
    
    func setupConstraints() {
        iconImageView.snp.makeConstraints { make in
            make.leading.equalToSuperview().inset(25)
            make.top.equalToSuperview().inset(10)
            make.size.equalTo(40)
        }
        
        nameLabel.snp.makeConstraints { make in
            make.leading.equalTo(iconImageView.snp.trailing).offset(19)
            make.top.equalTo(iconImageView.snp.top)
            make.height.equalTo(27)
        }
        
        priceLabel.snp.makeConstraints { make in
            make.trailing.equalToSuperview().inset(25)
            make.top.equalTo(iconImageView.snp.top)
            make.height.equalTo(nameLabel.snp.height)
        }
        
        percentLabel.snp.makeConstraints { make in
            make.trailing.equalTo(priceLabel.snp.trailing)
            make.top.equalTo(priceLabel.snp.bottom).offset(3)
            make.height.equalTo(21)
        }
        
        changeLabel.snp.makeConstraints { make in
            make.trailing.equalTo(percentLabel.snp.leading).offset(-6)
            make.top.equalTo(priceLabel.snp.bottom).offset(7)
            make.size.equalTo(12)
        }
        
        symbolLabel.snp.makeConstraints { make in
            make.top.equalTo(nameLabel.snp.bottom).offset(3)
            make.leading.equalTo(nameLabel.snp.leading)
            make.height.equalTo(21)
        }
    }
}

// MARK: - Configure UI

extension CryptoItemCell {
    func configure(with crypto: Crypto) {
        nameLabel.text = crypto.name
        symbolLabel.text = crypto.symbol.uppercased()
        
        if let price = crypto.metrics?.marketData?.priceUsd {
            let formatter = NumberFormatter()
            formatter.numberStyle = .currency
            formatter.currencySymbol = "$"
            formatter.maximumFractionDigits = 2
            formatter.minimumFractionDigits = 2
            formatter.locale = Locale(identifier: "en_US")
            priceLabel.text = formatter.string(from: NSNumber(value: price))
        } else {
            priceLabel.text = "-"
        }
        
        if let change = crypto.metrics?.marketData?.percentChangeUsdLast24Hours {
            percentLabel.text = String(format: "%.2f%%", abs(change))
            changeLabel.image = change > 0 ? UIImage(named: "arrowUp") : UIImage(named: "arrowDown")
        }
        
        iconImageView.image = UIImage(named: crypto.symbol.lowercased())
    }
}
