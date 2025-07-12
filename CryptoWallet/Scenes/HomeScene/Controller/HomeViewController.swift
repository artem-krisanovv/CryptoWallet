import UIKit
import SnapKit

class HomeViewController: UIViewController {
    
    var viewModel = HomeViewModel()
    var isExpanded = false
    var isAnimatingScroll = false
    
    // MARK: - UI Elements
    
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

    
    
    
   
    
    
    
    
    
    
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        
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
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detailsVC = CryptoDetailViewController()
        //detailsVC.configure(with: viewModel.cryptoList[indexPath.row])
        navigationController?.pushViewController(detailsVC, animated: true)
    }


    
   

}

// MARK: - Setup UI

extension HomeViewController {
    func setupUI() {
        view.backgroundColor = .secondBackground
        navigationController?.setNavigationBarHidden(true, animated: false)
        
        [shadowImageView, illustrationImageView, affiliateLabel, learnMoreButton, trendingTableView].forEach {
            view.addSubview($0)
        }
        
        addCustomNavigationBar(title: "Home", showsRightButton: true) {
            print("More button tapped")
        }
        setupUITableView()
        setupConstraints()
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
        
        affiliateLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(126)
            make.leading.equalToSuperview().offset(25)
            make.height.equalTo(30)
        }
        
        learnMoreButton.snp.makeConstraints { make in
            make.top.equalTo(affiliateLabel.snp.bottom).offset(12)
            make.leading.equalTo(affiliateLabel.snp.leading)
            make.height.equalTo(35)
            make.width.equalTo(127)
        }
        
        illustrationImageView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(101)
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
    }
}

//MARK: Refresh Method

extension HomeViewController {
    
}


#Preview {
    HomeViewController()
    
}
