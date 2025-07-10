import UIKit

final class TabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setupTabs()
        tabBar.tintColor = .black
        tabBar.backgroundColor = .white
        tabBar.layer.cornerRadius = 24
        tabBar.layer.masksToBounds = true
    }

    private func setupTabs() {
        let homeVC = HomeViewController()
        let marketVC = StubViewController(title: "Market")
        let tradeVC = StubViewController(title: "Trade")
        let statsVC = StubViewController(title: "Stats")
        let profileVC = StubViewController(title: "Profile")

        homeVC.tabBarItem = UITabBarItem(title: nil, image: UIImage(systemName: "house"), tag: 0)
        marketVC.tabBarItem = UITabBarItem(title: nil, image: UIImage(systemName: "chart.line.uptrend.xyaxis"), tag: 1)
        tradeVC.tabBarItem = UITabBarItem(title: nil, image: UIImage(systemName: "creditcard"), tag: 2)
        statsVC.tabBarItem = UITabBarItem(title: nil, image: UIImage(systemName: "doc.text"), tag: 3)
        profileVC.tabBarItem = UITabBarItem(title: nil, image: UIImage(systemName: "person.circle"), tag: 4)

        viewControllers = [
            UINavigationController(rootViewController: homeVC),
            UINavigationController(rootViewController: marketVC),
            UINavigationController(rootViewController: tradeVC),
            UINavigationController(rootViewController: statsVC),
            UINavigationController(rootViewController: profileVC)
        ]
    }
}
