
import UIKit


class ProfileScreenController: UIViewController {
    
    private let AddEventButton = customButton(title: "Add Event", hasBackground: true, fontsize: .big)
    
    private let changeFiltersButton = customButton(title: "Change Filters", hasBackground: true, fontsize: .big)

    private let usernameLabel: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 20, weight: .bold)
        label.text = "James Hetfield"
        return label
        
    }()
    private let emailLabel: UILabel = {
        let label = UILabel()
        label.textColor = .secondaryLabel
        label.textAlignment = .left
        label.font = .systemFont(ofSize: 15, weight: .bold)
        label.text = "Email Address:\njameshetfield@asu.edu"
        label.numberOfLines = 0
        return label
        
    }()
    private let IDLabel: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.textAlignment = .left
        label.font = .systemFont(ofSize: 18, weight: .bold)
        label.text = "ID: 1129457334"
        return label
        
    }()
    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.textColor = .secondaryLabel
        label.textAlignment = .left
        label.font = .systemFont(ofSize: 16, weight: .bold)
        label.text = "Description: \n\nHello there! I am James Hetfield, founder of \nmetal rock group Metallica! I have always \nloved playing guitar and listening to heavy \nmetal. My dad taught me how to play guitar \nsince young age. I want to make friends here \nand attend some of the events. I heard \nthis app is pretty good! =) Nice to meet you!"
        label.numberOfLines = 0
        return label
        
    }()
    
    
    private let profileView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFit
        iv.image = UIImage(named: "Profile")
        iv.tintColor = .label
        iv.layer.cornerRadius = 25
        iv.clipsToBounds = true
        return iv
        
    }()
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .systemBackground
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "gearshape.fill"), style: .done, target: self, action: #selector(didTapSettingsButton))
        
        self.navigationItem.title = "Student"
        setupUI()

    }
    @objc func didTapSettingsButton(){
        let settingsMenuVC = SettingsMenuController()
        let navController = UINavigationController(rootViewController: settingsMenuVC)
        navController.modalTransitionStyle = .coverVertical
        present(navController, animated: true,completion: nil)
    }
    private func setupUI() {
        
        view.addSubview(profileView)
        view.addSubview(usernameLabel)
        view.addSubview(emailLabel)
        view.addSubview(IDLabel)
        view.addSubview(descriptionLabel)
        view.addSubview(AddEventButton)
        view.addSubview(changeFiltersButton)
        profileView.translatesAutoresizingMaskIntoConstraints = false
        usernameLabel.translatesAutoresizingMaskIntoConstraints = false
        emailLabel.translatesAutoresizingMaskIntoConstraints = false
        IDLabel.translatesAutoresizingMaskIntoConstraints = false
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        AddEventButton.translatesAutoresizingMaskIntoConstraints = false
        changeFiltersButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            profileView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 20),
            profileView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            profileView.widthAnchor.constraint(equalToConstant: 180),
            profileView.heightAnchor.constraint(equalToConstant: 180),
            
            usernameLabel.topAnchor.constraint(equalTo: self.profileView.topAnchor, constant: 20),
            usernameLabel.leadingAnchor.constraint(equalTo: self.profileView.trailingAnchor, constant: 20),
            
            emailLabel.topAnchor.constraint(equalTo: self.usernameLabel.bottomAnchor, constant: 20),
            emailLabel.leadingAnchor.constraint(equalTo: self.profileView.trailingAnchor, constant: 20),
            IDLabel.topAnchor.constraint(equalTo: self.emailLabel.bottomAnchor, constant: 20),
            IDLabel.leadingAnchor.constraint(equalTo: self.profileView.trailingAnchor, constant: 20),
            descriptionLabel.topAnchor.constraint(equalTo: self.profileView.bottomAnchor, constant: 20),
            descriptionLabel.leadingAnchor.constraint(equalTo: self.profileView.leadingAnchor, constant: 20),
            descriptionLabel.trailingAnchor.constraint(equalTo: self.IDLabel.trailingAnchor, constant: 20),
            AddEventButton.topAnchor.constraint(equalTo: self.descriptionLabel.bottomAnchor, constant: 20),
            AddEventButton.leadingAnchor.constraint(equalTo: self.view.leadingAnchor,constant: 16),
            AddEventButton.trailingAnchor.constraint(equalTo: self.view.trailingAnchor,constant: -16),
            AddEventButton.heightAnchor.constraint(equalToConstant: 50),
            changeFiltersButton.topAnchor.constraint(equalTo: self.AddEventButton.bottomAnchor, constant: 20),
            changeFiltersButton.leadingAnchor.constraint(equalTo: self.view.leadingAnchor,constant: 16),
            changeFiltersButton.trailingAnchor.constraint(equalTo: self.view.trailingAnchor,constant: -16),
            changeFiltersButton.heightAnchor.constraint(equalToConstant: 50)
            
        ])
        
    }


}

