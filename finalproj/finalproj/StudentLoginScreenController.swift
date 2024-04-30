import UIKit

class StudentLoginScreenController: UIViewController {

    //for logo
    private let logo: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFit
        iv.image = UIImage(named: "Logo" )
        return iv
    }()
    
    //for label under logo
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .label//contrast to system dark/light
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 26, weight: .bold)
        label.text = "Error"//default title if something went wrong
        return label
        
    }()
    
    //for label underneath both label and logo
    private let subtitleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .secondaryLabel
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 18, weight: .regular)
        label.text = "Error"
        return label
    }()
    
    private let usernameField = customTextField(fieldType: .username)
    private let passwordField = customTextField(fieldType: .password)
    private let SignInButton = customButton(title: "Sign In", hasBackground: true, fontsize: .big)
    private let CreateAccountButton = customButton(title: "New User? Create Account.", hasBackground: false, fontsize: .med)
    private let ForgotPasswordButton = customButton(title: "Forgot Password?", hasBackground: false, fontsize: .small)
    init(title: String, subtitle: String){
        super.init(nibName: nil , bundle: nil)
        self.titleLabel.text = title
        self.subtitleLabel.text = subtitle
        view.backgroundColor = .systemBackground
        SignInButton.addTarget(self, action: #selector(handleSignIn), for: .touchUpInside)
        self.setupUI()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func handleSignIn() {
        //we trim.remove all the spaces from textfields and then check if those fields are empty - if yes, then alert is shown.
        if let usernameText = usernameField.text?.trimmingCharacters(in: .whitespacesAndNewlines),
           let passwordText = passwordField.text?.trimmingCharacters(in: .whitespacesAndNewlines),
           !usernameText.isEmpty,
           !passwordText.isEmpty {
            
            switchToMainInterface()
        } else {
            // Either field is empty or contains only whitespace
            let alert = UIAlertController(title: "Error", message: "Please enter both username and password", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Dismiss", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }

    }
    func switchToMainInterface() {
        let tabBarController = TabController()
        
        //retrieving current scene delegate to access window
        if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
           let sceneDelegate = windowScene.delegate as? SceneDelegate,
           let window = sceneDelegate.window {
            window.rootViewController = tabBarController
            UIView.transition(with: window, duration: 0.5, options: .transitionCrossDissolve, animations: nil, completion: nil)
        }
        //the scene can include various controllers; I am essentially changing the whole scene from one root to another root.
    }

    
    
    //fileprivate keyword restricts to whole file only; private restricts to first {} and extensions
    private func setupUI() {
        self.view.addSubview(logo)
        self.view.addSubview(titleLabel)
        self.view.addSubview(subtitleLabel)
        self.view.addSubview(usernameField)
        self.view.addSubview(passwordField)
        self.view.addSubview(SignInButton)
        self.view.addSubview(CreateAccountButton)
        self.view.addSubview(ForgotPasswordButton)
        logo.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        subtitleLabel.translatesAutoresizingMaskIntoConstraints = false
        usernameField.translatesAutoresizingMaskIntoConstraints = false
        passwordField.translatesAutoresizingMaskIntoConstraints = false
        SignInButton.translatesAutoresizingMaskIntoConstraints = false
        CreateAccountButton.translatesAutoresizingMaskIntoConstraints = false
        ForgotPasswordButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            
            //without constant, we specify relationship between which anchors we want to create distance with. Then we add constant to specify the distance between.
            self.logo.widthAnchor.constraint(equalToConstant: 70),
            
            self.logo.heightAnchor.constraint(equalToConstant: 70),
            
            //don't forget about default margin coming from layoutmarginsguide
            self.logo.topAnchor.constraint(equalTo: self.view.layoutMarginsGuide.topAnchor, constant: 16),
            self.logo.centerXAnchor.constraint(equalTo: self.view.layoutMarginsGuide.centerXAnchor),
 
            //putting title label below logo
            titleLabel.topAnchor.constraint(equalTo: logo.bottomAnchor, constant: 20),
            titleLabel.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
   
            
            subtitleLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 10),
            subtitleLabel.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            subtitleLabel.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            
            usernameField.topAnchor.constraint(equalTo: subtitleLabel.bottomAnchor,constant: 20),
            usernameField.leadingAnchor.constraint(equalTo: self.view.leadingAnchor,constant: 16),
            usernameField.trailingAnchor.constraint(equalTo: self.view.trailingAnchor,constant: -16),
            usernameField.heightAnchor.constraint(equalToConstant: 50),
            
            passwordField.topAnchor.constraint(equalTo: usernameField.bottomAnchor,constant: 20),
            passwordField.leadingAnchor.constraint(equalTo: self.view.leadingAnchor,constant: 16),
            passwordField.trailingAnchor.constraint(equalTo: self.view.trailingAnchor,constant: -16),
            passwordField.heightAnchor.constraint(equalToConstant: 50),
            
            SignInButton.topAnchor.constraint(equalTo: passwordField.bottomAnchor, constant: 20),
            SignInButton.leadingAnchor.constraint(equalTo: self.view.leadingAnchor,constant: 16),
            SignInButton.trailingAnchor.constraint(equalTo: self.view.trailingAnchor,constant: -16),
            SignInButton.heightAnchor.constraint(equalToConstant: 50),
            
            CreateAccountButton.topAnchor.constraint(equalTo: SignInButton.bottomAnchor, constant: 20),
            CreateAccountButton.leadingAnchor.constraint(equalTo: self.view.leadingAnchor,constant: 16),
            CreateAccountButton.trailingAnchor.constraint(equalTo: self.view.trailingAnchor,constant: -16),
            CreateAccountButton.heightAnchor.constraint(equalToConstant: 50),
            
            ForgotPasswordButton.topAnchor.constraint(equalTo: CreateAccountButton.bottomAnchor, constant: 20),
            ForgotPasswordButton.leadingAnchor.constraint(equalTo: self.view.leadingAnchor,constant: 16),
            ForgotPasswordButton.trailingAnchor.constraint(equalTo: self.view.trailingAnchor,constant: -16),
            ForgotPasswordButton.heightAnchor.constraint(equalToConstant: 50)
            
        ])
    }
    



}
