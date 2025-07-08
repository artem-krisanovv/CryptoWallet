import UIKit

final class Router {
    static let shared = Router()
    
    private init() {}
    
    func navigate<T: UIViewController>(to viewController: T.Type) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: String(describing: viewController)) as! T
    }
}
