import UIKit
import SnapKit

class AuthViewController: UIViewController {
    
    // MARK: - Properties
    
    var viewModel: AuthViewModel = AuthViewModel()
    
    // MARK: - Private Properties
    
    private var loginButtonBottomConstraint: Constraint?
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    // MARK: - UI Elements
    
    lazy var usernameTextField = makeTextFields(
        placeholder: "Username",
        icon: .userIcon,
        isSecureTextEntry: false
    )
    
    lazy var passwordTextField = makeTextFields(
        placeholder: "Password",
        icon: .passwordIcon,
        isSecureTextEntry: true
    )
    
    private let loginButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Login", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font =  UIFont(name: "Poppins-SemiBold", size: 15)
        button.backgroundColor = UIColor(named: "authButtonColor")
        button.layer.cornerRadius = 28
        return button
    }()
    
    private let robotImageView: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "robotImage")
        image.contentMode = .scaleAspectFit
        return image
    }()
    
    private let mainBackgroundImageView: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "mainBackgroundImage")
        image.contentMode = .scaleAspectFill
        return image
    }()
    
    private let lightBackgroundImageView: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "lightBackgroundImage")
        image.contentMode = .scaleAspectFit
        return image
    }()
    
    private let shadowImageView: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "shadowForAuthScene")
        image.contentMode = .scaleAspectFit
        return image
    }()
    
    // MARK: - Deinitialization
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
}

// MARK: - Setup UI

extension AuthViewController {
    private func setupUI() {
        view.backgroundColor = .background
        [
            usernameTextField,
            passwordTextField,
            loginButton,
            lightBackgroundImageView,
            mainBackgroundImageView,
            shadowImageView,
            robotImageView
        ].forEach { view.addSubview($0) }
        
        setupConstraints()
        addTargetToLoginButton()
        setupHideKeyboardOnTap()
        setupKeyboardObservers()
    }
    
    private func setupConstraints() {
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
            self.loginButtonBottomConstraint = make.bottom.equalTo(view.safeAreaLayoutGuide).offset(-40).constraint
        }
    }
}

//MARK: Make TextField Method

extension AuthViewController {
    private func makeTextFields(placeholder: String, icon: UIImage, isSecureTextEntry: Bool) -> UITextField {
        let textField = UITextField()
        textField.font = UIFont(name: "Poppins-Regular", size: 15)
        textField.textColor = .black
        textField.tintColor = .gray
        textField.backgroundColor = .white
        textField.layer.cornerRadius = 25
        textField.isSecureTextEntry = isSecureTextEntry
        textField.attributedPlaceholder = NSAttributedString(
            string: placeholder,
            attributes: [
                .foregroundColor: UIColor.gray,
                .font: UIFont(name: "Poppins-Regular", size: 15) ?? UIFont.systemFont(ofSize: 15)
            ]
        )
        
        let iconContainer = UIView()
        let iconImageView = UIImageView()
        
        iconImageView.image = icon
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
    }
}

//MARK: Authorization Button Method

extension AuthViewController {
    private func addTargetToLoginButton() {
        loginButton.addTarget(self, action: #selector(loginTapped), for: .touchUpInside)
    }
    
    private func showLoginErrorAlert() {
        let alert = UIAlertController(
            title: "Ошибка",
            message: "Введены неправильный логин или пароль",
            preferredStyle: .alert
        )
        
        let retryAction = UIAlertAction(
            title: "Повторить",
            style: .default,
            handler: nil
        )
        
        let cancelAction = UIAlertAction(title: "Отменить", style: .destructive) { [weak self] _ in
            self?.usernameTextField.text = ""
            self?.passwordTextField.text = ""
        }
        
        alert.addAction(retryAction)
        alert.addAction(cancelAction)
        present(alert, animated: true, completion: nil)
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
        } else {
            showLoginErrorAlert()
        }
    }
}

//MARK: Keyboard Hide Method

extension AuthViewController {
    private func setupHideKeyboardOnTap() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
        tapGesture.cancelsTouchesInView = false
        view.addGestureRecognizer(tapGesture)
    }

    @objc private func hideKeyboard() {
        view.endEditing(true)
    }
}

//MARK: Keyboard Will Show Method


extension AuthViewController {
    private func setupKeyboardObservers() {
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(keyboardWillShow(_:)),
            name: UIResponder.keyboardWillShowNotification,
            object: nil
        )
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(keyboardWillHide(_:)),
            name: UIResponder.keyboardWillHideNotification,
            object: nil
        )
    }

    @objc private func keyboardWillShow(_ notification: Notification) {
        guard let userInfo = notification.userInfo,
              let keyboardFrame = userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect,
              let duration = userInfo[UIResponder.keyboardAnimationDurationUserInfoKey] as? Double else { return }

        loginButtonBottomConstraint?.update(offset: -keyboardFrame.height - 20)

        UIView.animate(withDuration: duration) {
            self.view.layoutIfNeeded()
        }
    }

    @objc private func keyboardWillHide(_ notification: Notification) {
        guard let userInfo = notification.userInfo,
              let duration = userInfo[UIResponder.keyboardAnimationDurationUserInfoKey] as? Double else { return }

        loginButtonBottomConstraint?.update(offset: -40)

        UIView.animate(withDuration: duration) {
            self.view.layoutIfNeeded()
        }
    }
}

