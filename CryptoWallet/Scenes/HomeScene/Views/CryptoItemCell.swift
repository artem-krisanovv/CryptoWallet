import UIKit
import SnapKit

class CryptoItemCell: UITableViewCell {
   
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
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func configure(with model: CryptoModel) {
        contentView.backgroundColor = .background
        iconImageView.image = UIImage(named: model.iconName)
        nameLabel.text = "\(model.name)"
        priceLabel.text = "$\(model.price)"
        percentLabel.text = "\(model.priceChange)%"
        symbolLabel.text = "\(model.symbol)"
        changeLabel.image = model.priceChange >= 0 ? UIImage(named: "arrowUp") : UIImage(named: "arrowDown")
        
    }

    private func setupUI() {
        [iconImageView, nameLabel, priceLabel, changeLabel, percentLabel, symbolLabel].forEach {
            contentView.addSubview($0)
        }
        
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
            make.trailing.equalTo(percentLabel.snp.trailing).offset(-45)
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

#Preview {
    HomeViewController()
}
