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
        view.backgroundColor = .systemBackground
        setup()
        navigationController?.navigationBar.prefersLargeTitles = true
        
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

