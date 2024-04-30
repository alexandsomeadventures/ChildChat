import UIKit

class LaunchScreenController: UIViewController {
    
    let parentButton = UIButton()
    let studentButton = UIButton()
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Welcome!"
        let backItem = UIBarButtonItem()
        backItem.title = "Back"
        navigationItem.backBarButtonItem = backItem
        
        setup()
        setupBackground()
        animateUIElements()
        navigationController?.navigationBar.prefersLargeTitles = true
    }

    func setupBackground() {
        let backgroundImageView = UIImageView(frame: view.bounds)
        backgroundImageView.image = UIImage(named: "Welcome")
        backgroundImageView.contentMode = .scaleAspectFill // ensures that background covers whole screen
        backgroundImageView.clipsToBounds = true
        backgroundImageView.alpha = 0  // Start with an invisible image

        view.addSubview(backgroundImageView)
        view.sendSubviewToBack(backgroundImageView) // sends to back of the view

        backgroundImageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            backgroundImageView.topAnchor.constraint(equalTo: view.topAnchor),
            backgroundImageView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            backgroundImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            backgroundImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])

        // Animate the background image to fade in
        UIView.animate(withDuration: 1.5, animations: {
            backgroundImageView.alpha = 1
        })
    }
    
    func animateUIElements() {
        parentButton.alpha = 0
        studentButton.alpha = 0

        // First, fade in the parent button
        UIView.animate(withDuration: 1.0, delay: 1.5, options: [], animations: {
            self.parentButton.alpha = 1
        }, completion: nil)

        // Then, fade in the student button slightly after the parent button
        UIView.animate(withDuration: 1.0, delay: 2.0, options: [], animations: {
            self.studentButton.alpha = 1
        }, completion: nil)
        //options parameter takes certain conditions from its built-in enumeration values such as .repeat(meaning animation repeats) or .autoreverse(animation in reverse order). This changes how animation is presented
    }

    
    func setup() {
        view.addSubview(parentButton)
        view.addSubview(studentButton)
        parentButton.configuration = .filled()
        studentButton.configuration = .filled()
        parentButton.configuration?.baseBackgroundColor = .systemPink
        studentButton.configuration?.baseBackgroundColor = .systemPink
        parentButton.configuration?.title = "Parent"
        studentButton.configuration?.title = "Student"
        
        parentButton.translatesAutoresizingMaskIntoConstraints = false
        // set false for every UI element. Otherwise, it won't line up properly.
        studentButton.translatesAutoresizingMaskIntoConstraints = false
        
        parentButton.addTarget(self, action: #selector(ParentLoginScreenDidAppear) , for: .touchUpInside)
        
        studentButton.addTarget(self, action: #selector(StudentLoginScreenDidAppear), for: .touchUpInside)
        
        NSLayoutConstraint.activate([
            parentButton.leftAnchor.constraint(equalTo:view.safeAreaLayoutGuide.leftAnchor, constant: 8),
            
            parentButton.bottomAnchor.constraint(equalTo:view.safeAreaLayoutGuide.bottomAnchor, constant: -8),
            
            studentButton.rightAnchor.constraint(equalTo:view.safeAreaLayoutGuide.rightAnchor, constant: -8),
            
            studentButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -8)])
        // setting up constraint. make sure it is active by putting in nsl list; otherwise constraint won't be activated.
        
    }
    
    @objc func ParentLoginScreenDidAppear(){
        let ParentLoginScreen = ParentLoginScreenController()
        navigationController?.pushViewController(ParentLoginScreen, animated: true)
        //pushes another view controller on top of UI stack
    }
    @objc func StudentLoginScreenDidAppear(){
        let StudentLoginScreen = StudentLoginScreenController(title: "Sign In", subtitle: "Sign in to your account")
        navigationController?.pushViewController(StudentLoginScreen, animated: true)
    }
    


}

