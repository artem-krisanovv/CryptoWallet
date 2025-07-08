import Foundation

final class AuthStorage {

    static let shared = AuthStorage()
    private init() {}

    private let key = "isAuthorized"

    var isAuthorized: Bool {
        return UserDefaults.standard.bool(forKey: key)
    }

    func login() {
        UserDefaults.standard.set(true, forKey: key)
    }

    func logout() {
        UserDefaults.standard.set(false, forKey: key)
    }
}
