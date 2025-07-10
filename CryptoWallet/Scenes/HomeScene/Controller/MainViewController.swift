import UIKit
import SnapKit

class HomeViewController: UIViewController {
    
    var viewModel: HomeViewModel!
    var isExpanded = false
    var isAnimatingScroll = false
    
    // MARK: - UI Elements
    
    let homeLabel: UILabel = {
        let label = UILabel()
        label.text = "Home"
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
    
    let affiliateLabel: UILabel = {
        let label = UILabel()
        label.text = "Affiliate program"
        label.font = UIFont(name: "Poppins-SemiBold", size: 20)
        label.textColor = .white
        return label
    }()
    
    let learnMoreButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Learn more", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = UIFont(name: "Poppins-SemiBold", size: 14)
        button.backgroundColor = .white
        button.layer.cornerRadius = 17
        return button
    }()
    
    let illustrationImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "objectImage")
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    let shadowImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "shadowForMainScene")
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    let trendingLabel: UILabel = {
        let label = UILabel()
        label.text = "Trending"
        label.font = UIFont(name: "Poppins-SemiBold", size: 18)
        label.textColor = .black
        return label
    }()
    
    let sortButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "sortIcon"), for: .normal)
        return button
    }()
    
    let trendingTableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.backgroundColor = .background
        tableView.separatorStyle = .none
        tableView.showsVerticalScrollIndicator = false
        tableView.layer.cornerRadius = 20
        tableView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        return tableView
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
        
        let image = UIImage(named: "rocketIcon")
        button.setImage(image, for: .normal)

        button.setTitle("Обновить", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = UIFont(name: "Poppins-Light", size: 18)
        
        button.tintColor = .black
        button.imageView?.contentMode = .scaleAspectFit
        
        return button
    }()

    
    let logoutButton: UIButton = {
        let button = UIButton(type: .system)
        
        let image = UIImage(named: "trashIcon")
        button.setImage(image, for: .normal)

        button.setTitle("Выйти", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = UIFont(name: "Poppins-Light", size: 18)
        
        button.tintColor = .black
        button.imageView?.contentMode = .scaleAspectFit

        
        return button
    }()

    
    
    
    
    
    
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = HomeViewModel()
        setupUI()
        setupActions()
    }
}

// MARK: - Setup TableView
extension HomeViewController: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.cryptoList.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CryptoItemCell", for: indexPath) as! CryptoItemCell
        let crypto = viewModel.cryptoList[indexPath.row]
        cell.configure(with: crypto)
        cell.selectionStyle = .none
        return cell
    }


    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
    
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
        headerView.backgroundColor = .background
        
        
        let label = UILabel()
        label.text = "Tranding"
        label.backgroundColor = .background
        label.font = UIFont(name: "Poppins-SemiBold", size: 20)
        headerView.addSubview(label)
        
        let button = UIButton()
        button.setImage(UIImage(named: "sortIcon"), for: .normal)
        headerView.addSubview(button)
        
        label.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(25)
            make.top.equalToSuperview().offset(24)
            make.height.equalTo(30)
        }
        
        button.snp.makeConstraints { make in
            make.trailing.equalToSuperview().offset(-25)
            make.top.equalToSuperview().offset(30)
            make.height.equalTo(24)
            make.width.equalTo(24)
        }
        
        return headerView
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 70
    }


    
   

}

// MARK: - Setup UI

extension HomeViewController {
    func setupUI() {
        view.backgroundColor = .secondBackground
        
        [shadowImageView, illustrationImageView, homeLabel, moreButton, affiliateLabel, learnMoreButton, trendingTableView,
         popupMenuView].forEach {
            view.addSubview($0)
        }
        
        [updateButton, logoutButton].forEach {
            popupMenuView.addSubview($0)
        }
        
        setupUITableView()
        setupConstraints()
    }
    
    func setupActions() {
        moreButton.addTarget(self, action: #selector(togglePopup), for: .touchUpInside)
    }
    
    @objc func togglePopup() {
        popupMenuView.isHidden.toggle()
    }
    
    func setupUITableView() {
        trendingTableView.delegate = self
        trendingTableView.dataSource = self
        trendingTableView.register(CryptoItemCell.self, forCellReuseIdentifier: "CryptoItemCell")
        if #available(iOS 15.0, *) {
            trendingTableView.sectionHeaderTopPadding = 0
        }
    }
    

    
    func setupConstraints() {
        
        homeLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(32)
            make.leading.equalToSuperview().inset(25)
            make.height.equalTo(48)
        }
        
        moreButton.snp.makeConstraints { make in
            make.top.equalTo(homeLabel.snp.top)
            make.trailing.equalToSuperview().inset(25)
            make.height.equalTo(48)
            make.width.equalTo(48)
        }
        
        affiliateLabel.snp.makeConstraints { make in
            make.top.equalTo(homeLabel.snp.bottom).offset(46)
            make.leading.equalTo(homeLabel.snp.leading)
            make.height.equalTo(30)
        }
        
        learnMoreButton.snp.makeConstraints { make in
            make.top.equalTo(affiliateLabel.snp.bottom).offset(12)
            make.leading.equalTo(homeLabel.snp.leading)
            make.height.equalTo(35)
            make.width.equalTo(127)
        }
        
        illustrationImageView.snp.makeConstraints { make in
            make.top.equalTo(moreButton.snp.bottom).offset(21)
            make.leading.equalTo(learnMoreButton.snp.trailing).offset(37)
            make.height.equalTo(242)
            make.width.equalTo(242)
        }
        
        shadowImageView.snp.makeConstraints { make in
            make.top.equalTo(illustrationImageView.snp.top).offset(47)
            make.leading.equalTo(illustrationImageView.snp.leading).offset(-20)
            make.height.equalTo(185)
            make.width.equalTo(185)
        }
        
        shadowImageView.snp.makeConstraints { make in
            make.top.equalTo(illustrationImageView.snp.top).offset(47)
            make.leading.equalTo(illustrationImageView.snp.leading).offset(-20)
            make.height.equalTo(185)
            make.width.equalTo(185)
        }
        
        trendingTableView.snp.makeConstraints { make in
            make.top.equalTo(learnMoreButton.snp.bottom).offset(55)
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            make.bottom.equalToSuperview()
        }
        
        popupMenuView.snp.makeConstraints { make in
            make.top.equalTo(moreButton.snp.bottom).offset(8)
            make.trailing.equalToSuperview().inset(29)
            make.width.equalTo(157)
        }

        updateButton.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(16)
            make.leading.equalToSuperview().inset(-60)
            make.height.equalTo(27)
        }

        logoutButton.snp.makeConstraints { make in
            make.top.equalTo(updateButton.snp.bottom).offset(16)
            make.leading.equalTo(updateButton.snp.leading)
            make.bottom.equalToSuperview().inset(16)
            make.height.equalTo(27)
        }
        
        
        
        
        
        
        
        
        
    }
}

#Preview {
    HomeViewController()
    
}
