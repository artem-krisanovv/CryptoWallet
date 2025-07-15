import UIKit

final class AppRouter {
    
    static let shared = AppRouter()
    private init() {}
    
    var window: UIWindow?
    
    func start(in window: UIWindow?) {
        self.window = window
        if AuthStorage.shared.isAuthorized {
            showCryptoList()
        } else {
            showAuth()
        }
    }
    
    func showAuth() {
        let authVC = AuthViewController()
        authVC.viewModel = AuthViewModel()
        setRootViewController(authVC)
    }
    
    func showCryptoList() {
        let tabBarController = TabBarController()
        setRootViewController(tabBarController)
    }
    
    func logout() {
        AuthStorage.shared.logout()
        showAuth()
    }
    
    private func setRootViewController(_ vc: UIViewController) {
        guard let window = self.window else { return }
        window.rootViewController = vc
        window.makeKeyAndVisible()
        
        UIView.transition(
            with: window,
            duration: 0.3,
            options: .transitionCrossDissolve,
            animations: nil,
            completion: nil
        )
    }
}
