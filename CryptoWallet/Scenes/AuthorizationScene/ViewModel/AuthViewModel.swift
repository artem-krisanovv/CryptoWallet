import Foundation

class AuthViewModel {
    func login(username: String, password: String) -> Bool {
        if username == "1234" && password == "1234" {
            AuthStorage.shared.isAuthorized = true
            return true
        }
        return false
    }
}
