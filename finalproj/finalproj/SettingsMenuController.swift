import UIKit
import UserNotifications
class SettingsMenuController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    let bookmarkCellIdentifier = "BookmarkCell"
    var tableView: UITableView!
    let options = ["Edit Profile", "Saved", "Notifications", "Close Friends", "Blocked", "Parent Control", "Membership"," Payment", "Terms of Services", "About", "Log Out","RSVP"]
    
    private let settingImages: [UIImage] = [
    UIImage(systemName: "pencil")!,
    UIImage(systemName: "bookmark.fill")!,
    UIImage(systemName: "bell.fill")!,
    UIImage(systemName: "star.fill")!,
    UIImage(systemName: "exclamationmark.octagon.fill")!,
    UIImage(systemName: "figure.2.and.child.holdinghands")!,
    UIImage(systemName: "person.text.rectangle.fill")!,
    UIImage(systemName: "creditcard.fill")!,
    UIImage(systemName: "person.and.background.dotted")!,
    UIImage(systemName: "info.bubble.fill")!,
    UIImage(systemName: "arrow.backward.circle.fill")!,
    UIImage(systemName: "line.3.horizontal.decrease")!

    ]
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
    }

    private func setupTableView() {
        tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "OptionCell")
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: bookmarkCellIdentifier)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(tableView)
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leftAnchor.constraint(equalTo: view.leftAnchor),
            tableView.rightAnchor.constraint(equalTo: view.rightAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
        ])
    }

    // MARK: - Table view data source

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return options.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // if specifically view controller for saved events is pressed, we check with index in array for saved events controller and present history data
    
        let cell = tableView.dequeueReusableCell(withIdentifier: "OptionCell", for: indexPath)
        let image = self.settingImages[indexPath.row]
        cell.imageView?.image = image
        cell.textLabel?.text = options[indexPath.row]
        cell.layoutIfNeeded()
        return cell
        
    }

    // MARK: - Table view delegate


    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)

        switch indexPath.row {
        case 0:
            showEditProfile()
        case 1:
            showSaved()
        case 2:
            showNotifications()
        case 3:
            showCloseFriends()
        case 4:
            showBlocked()
        case 5:
            showParentControl()
        case 6:
            showMembership()
        case 7:
            showPayment()
        case 8:
            showTOS()
        case 9:
            showAbout()
        case 10:
            showLogOut()
        case 11:
            showRSVP()
            

        default:
            fatalError("Wrong Option. Try Again.")
        }
    }
    private func showEditProfile(){
        
    }
    private func showSaved(){
      let vc = SavedEventsScreenController()
      navigationController?.pushViewController(vc, animated: true)
    }
    private func showNotifications(){
        let vc = NotificationsScreenController()
        vc.modalTransitionStyle = .coverVertical
        present(vc, animated: true)
    }
    private func showCloseFriends(){
        
    }
    private func showBlocked(){
        
    }
    private func showParentControl(){
        
    }
    private func showMembership(){
        
    }
    private func showPayment(){
        
    }
    private func showTOS(){
        
    }
    private func showAbout(){
        
    }
    
    //completely resetting navigation stack and going back to root view controller
    // closure syntax:
    //{ [capture list] (param1, param2) -> Return Type in
    
    //}
    //since class instance holds for itself here, we have to let it go completely to get back to root view controller. We make class instance weak temporarily
    @objc func showLogOut() {
        let alertController = UIAlertController(title: "Log Out", message: "Are you sure you want to log out?", preferredStyle: .alert)
        let confirmAction = UIAlertAction(title: "Confirm", style: .default) { [weak self] _ in
            guard let self = self else { return }
            
            //starting point of a new navigation stack
            let signInController = StudentLoginScreenController(title: "Sign In", subtitle: "Sign in to your account")
            
            //this creates new navigation controller which is not connected yet
            let navigationController = UINavigationController(rootViewController: signInController)
            
            //the window is like canvas for main app content
            if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
               let sceneDelegate = windowScene.delegate as? SceneDelegate,
               let window = sceneDelegate.window {
                window.rootViewController = navigationController
                UIView.transition(with: window, duration: 0.5, options: .transitionCrossDissolve, animations: nil, completion: nil)
            }
            //we are resetting whole nav stack. Since there is nothing left, and when we assign new nav view to the stack of window, Swift sees there is now only view on stack which can be currently displayed - signInController
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alertController.addAction(confirmAction)
        alertController.addAction(cancelAction)
        present(alertController, animated: true, completion: nil)
    }
    private func showRSVP(){
        let vc = RSVPEventsScreenController()
        navigationController?.pushViewController(vc, animated: true)
      }

}
