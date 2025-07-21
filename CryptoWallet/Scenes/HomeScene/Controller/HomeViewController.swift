import UIKit
import SnapKit

class HomeViewController: UIViewController {
    
    // MARK: - Private Properties
    
    private let viewModel = HomeViewModel()
    private var isExpanded = false
    private var isAnimatingScroll = false
    private var isSortAscending = true
    private weak var sortButton: UIButton?
    private var transparentView: UIView?
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bindViewModel()
        setupUI()
        viewModel.loadAssets()
        setupCustomNavBarCallbacks()
    }
    
    // MARK: - Private Method
    
    private func bindViewModel() {
        viewModel.onUpdate = { [weak self] in
            DispatchQueue.main.async {
                self?.trendingTableView.reloadData()
                if self?.viewModel.isLoading == true {
                    self?.spinner.startAnimating()
                    self?.showBlur()
                } else {
                    self?.spinner.stopAnimating()
                    self?.hideBlur()
                }
            }
        }
    }
    
    private func showBlur() {
        UIView.animate(withDuration: 0.2) {
            self.blurView.alpha = 1
        }
    }
    
    private func hideBlur() {
        UIView.animate(withDuration: 0.2) {
            self.blurView.alpha = 0
        }
    }
    
    // MARK: - UI Elements
    
    private var navBar: CustomNavigationBar?
    
    private let blurView: UIVisualEffectView = {
        let blurEffect = UIBlurEffect(style: .light)
        let view = UIVisualEffectView(effect: blurEffect)
        view.alpha = 0
        return view
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
    
    let trendingTableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.backgroundColor = .background
        tableView.separatorStyle = .none
        tableView.showsVerticalScrollIndicator = false
        tableView.layer.cornerRadius = 20
        tableView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        return tableView
    }()
    
    private let spinner: UIActivityIndicatorView = {
        let spinner = UIActivityIndicatorView(style: .large)
        spinner.hidesWhenStopped = true
        spinner.color = .gray
        return spinner
    }()
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
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
        headerView.backgroundColor = .background
        
        let button = UIButton()
        button.setImage(UIImage(named: "sortIcon"), for: .normal)
        button.addTarget(self, action: #selector(sortButtonTapped(_:)), for: .touchUpInside)
        self.sortButton = button
        button.transform = isSortAscending ? .identity : CGAffineTransform(rotationAngle: .pi)
        
        headerView.addSubview(button)
        headerView.addSubview(trendingLabel)
        
        trendingLabel.snp.makeConstraints { make in
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
        tableView.deselectRow(at: indexPath, animated: true)
        let crypto = viewModel.cryptoList[indexPath.row]
        let detailsVC = CryptoDetailViewController(crypto: crypto)
        navigationController?.pushViewController(detailsVC, animated: true)
    }
}

// MARK: - Setup UI

extension HomeViewController {
    func setupUI() {
        view.backgroundColor = .secondBackground
        navigationController?.setNavigationBarHidden(true, animated: false)
        [
            shadowImageView,
            illustrationImageView,
            affiliateLabel,
            learnMoreButton,
            trendingTableView,
            blurView,
            spinner
        ].forEach { view.addSubview($0) }
        
        navBar = addCustomNavigationBar(title: "Home", showsRightButton: true)
        navBar?.onUpdateTapped = { [weak self] in
            self?.viewModel.loadAssets()
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
        
        spinner.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
        
        blurView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}

//MARK: Coin Sort Method

extension HomeViewController {
    @objc private func sortButtonTapped(_ sender: UIButton) {
        isSortAscending.toggle()
        let order: HomeViewModel.SortOrder = isSortAscending ? .priceChangeAsc : .priceChangeDesc
        viewModel.sort(by: order)
        
        UIView.animate(withDuration: 0.2) {
            sender.transform = self.isSortAscending ? .identity : CGAffineTransform(rotationAngle: .pi)
        }
    }
}

//MARK: MoreButton Hide Methods

extension HomeViewController {
    private func setupCustomNavBarCallbacks() {
        navBar?.onMenuShown = { [weak self] in
            self?.showTransparentView()
        }
        navBar?.onMenuHidden = { [weak self] in
            self?.hideЕransparentView()
        }
    }
    
    private func showTransparentView() {
        guard transparentView == nil else { return }
        
        let transparentView = UIView()
        transparentView.backgroundColor = .clear
        transparentView.isUserInteractionEnabled = true
        view.addSubview(transparentView)
        transparentView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
       
        let tap = UITapGestureRecognizer(target: self, action: #selector(transparentViewTapped))
        transparentView.addGestureRecognizer(tap)
        self.transparentView = transparentView
        
        if let navBar {
            view.bringSubviewToFront(navBar)
        }
    }
    
    @objc private func transparentViewTapped() {
        navBar?.moreButtonIsHidden()
    }
    
    private func hideЕransparentView() {
        transparentView?.removeFromSuperview()
        transparentView = nil
    }
}
