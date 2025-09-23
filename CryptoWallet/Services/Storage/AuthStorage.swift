import Foundation

final class AuthStorage {
    private let isAuthorizedKey = "isAuthorized"
    static let shared = AuthStorage()
    
    private init() {}

    var isAuthorized: Bool {
        get { UserDefaults.standard.bool(forKey: isAuthorizedKey) }
        set { UserDefaults.standard.set(newValue, forKey: isAuthorizedKey) }
    }

    func logout() {
        isAuthorized = false
    }
}
