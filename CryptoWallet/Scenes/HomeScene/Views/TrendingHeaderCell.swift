import UIKit

class TrendingHeaderCell: UITableViewCell {
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Trending"
        label.font = UIFont(name: "Poppins-SemiBold", size: 18)
        return label
    }()
    
    let sortButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "sortIcon"), for: .normal)
        return button
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.addSubview(titleLabel)
        contentView.addSubview(sortButton)
        
        // Настрой констрейнты сам
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
