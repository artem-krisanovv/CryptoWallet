import UIKit
import SnapKit

class AuthViewController: UIViewController {
    
    var viewModel: AuthViewModel = AuthViewModel()
    
    // MARK: - UI Elements
    
    let usernameTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Username"
        textField.font = UIFont(name: "Poppins-Regular", size: 15)
        textField.backgroundColor = .white
        textField.layer.cornerRadius = 25
        
        let iconContainer = UIView()
        let iconImageView = UIImageView()
        
        iconImageView.image = UIImage(named: "userIcon")
        iconImageView.contentMode = .scaleAspectFit
        iconContainer.addSubview(iconImageView)
        textField.leftView = iconContainer
        textField.leftViewMode = .always
        
        iconImageView.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(10)
            make.center.equalToSuperview()
            make.width.height.equalTo(32)
        }
        
        return textField
    }()
    
    let passwordTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Password"
        textField.font = UIFont(name: "Poppins-Regular", size: 15)
        textField.backgroundColor = .white
        textField.layer.cornerRadius = 25
        textField.isSecureTextEntry = true
        
        let iconContainer = UIView()
        let iconImageView = UIImageView()
        
        iconImageView.image = UIImage(named: "passwordIcon")
        iconImageView.contentMode = .scaleAspectFit
        iconContainer.addSubview(iconImageView)
        textField.leftView = iconContainer
        textField.leftViewMode = .always
        
        iconImageView.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(10)
            make.center.equalToSuperview()
            make.width.height.equalTo(32)
        }
        
        return textField
    }()
    
    let loginButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Login", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font =  UIFont(name: "Poppins-SemiBold", size: 15)
        button.backgroundColor = UIColor(named: "authButtonColor")
        button.layer.cornerRadius = 28
        return button
    }()
    
    let robotImageView: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "robotImage")
        image.contentMode = .scaleAspectFit
        return image
    }()
    
    let mainBackgroundImageView: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "mainBackgroundImage")
        image.contentMode = .scaleAspectFill
        return image
    }()
    
    let lightBackgroundImageView: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "lightBackgroundImage")
        image.contentMode = .scaleAspectFit
        return image
    }()
    
    let shadowImageView: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "shadowForAuthScene")
        image.contentMode = .scaleAspectFit
        return image
    }()
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
}

// MARK: - Setup UI

extension AuthViewController {
    
    func setupUI() {
        view.backgroundColor = .background
        
        [usernameTextField, passwordTextField, loginButton, lightBackgroundImageView, mainBackgroundImageView, shadowImageView, robotImageView].forEach {
            view.addSubview($0)
        }
        
        setupConstraints()
        addTargetToLoginButton()
    }
    
    func setupConstraints() {
        
        robotImageView.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(63)
            make.leading.equalToSuperview().inset(64)
            make.trailing.equalToSuperview().inset(76)
            make.height.equalTo(235)
        }
        
        mainBackgroundImageView.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(105)
            make.leading.equalToSuperview().inset(71)
            make.trailing.equalToSuperview().inset(71)
            make.height.equalTo(243)
        }
        
        lightBackgroundImageView.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(60)
            make.leading.equalToSuperview().inset(44)
            make.trailing.equalToSuperview().inset(44)
            make.height.equalTo(287)
        }
        
        shadowImageView.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(234)
            make.leading.equalToSuperview().inset(127)
            make.trailing.equalToSuperview().inset(104)
            make.height.equalTo(84)
        }
        
        usernameTextField.snp.makeConstraints { make in
            make.top.equalTo(lightBackgroundImageView.snp.bottom).offset(174)
            make.leading.trailing.equalToSuperview().inset(25)
            make.height.equalTo(55)
        }
        
        passwordTextField.snp.makeConstraints { make in
            make.top.equalTo(usernameTextField.snp.bottom).offset(15)
            make.leading.trailing.equalToSuperview().inset(25)
            make.height.equalTo(55)
            
        }
        
        loginButton.snp.makeConstraints { make in
            make.top.equalTo(passwordTextField.snp.bottom).offset(25)
            make.leading.trailing.equalToSuperview().inset(25)
            make.height.equalTo(55)
            
        }
    }
}

//MARK: Authorization Button Method

extension AuthViewController {
    
    func addTargetToLoginButton() {
        loginButton.addTarget(self, action: #selector(loginTapped), for: .touchUpInside)
    }
    
    @objc private func loginTapped() {
        let username = usernameTextField.text ?? ""
        let password = passwordTextField.text ?? ""
        if viewModel.login(username: username, password: password) {
            if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
               let window = windowScene.windows.first {
                window.rootViewController = TabBarController()
                window.makeKeyAndVisible()
            }
        }
    }
}


#Preview {
    AuthViewController()
}


