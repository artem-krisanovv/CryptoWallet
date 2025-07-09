import UIKit
import SnapKit

class CryptoItemCell: UITableViewCell {
    private let iconImageView = UIImageView()
    private let nameLabel = UILabel()
    private let priceLabel = UILabel()
    private let changeLabel = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func configure(with model: CryptoModel) {
        iconImageView.image = UIImage(named: model.iconName)
        nameLabel.text = "\(model.name) (\(model.symbol))"
        priceLabel.text = "$\(model.price)"
        changeLabel.text = "\(model.priceChange)%"
        changeLabel.textColor = model.priceChange >= 0 ? .systemGreen : .systemRed
    }

    private func setupUI() {
        [iconImageView, nameLabel, priceLabel, changeLabel].forEach { contentView.addSubview($0) }
        
        iconImageView.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(16)
            $0.centerY.equalToSuperview()
            $0.size.equalTo(40)
        }
        nameLabel.snp.makeConstraints {
            $0.leading.equalTo(iconImageView.snp.trailing).offset(12)
            $0.top.equalToSuperview().offset(12)
        }
        priceLabel.snp.makeConstraints {
            $0.leading.equalTo(nameLabel)
            $0.top.equalTo(nameLabel.snp.bottom).offset(4)
        }
        changeLabel.snp.makeConstraints {
            $0.trailing.equalToSuperview().inset(16)
            $0.centerY.equalToSuperview()
        }
    }
}
