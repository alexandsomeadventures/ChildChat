import UIKit

class TabController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupTabs()
        
        self.tabBar.tintColor = .systemBlue
        self.tabBar.unselectedItemTintColor = .darkGray
        self.tabBar.backgroundColor = .white
        
    }
    private func setupTabs(){
        let events = self.createNav(with: "Events", and: UIImage(systemName: "bell"), vc: EventsScreenController())
        let friends = self.createNav(with: "Friends", and: UIImage(systemName: "person.3"), vc: FriendsScreenController())
        let ai = self.createNav(with: "AI", and: UIImage(systemName: "message"), vc: AiScreenController())
        let profile = self.createNav(with: "Me", and: UIImage(systemName: "person.crop.circle"), vc: ProfileScreenController())
        
        //the function below takes array of view controllers which are gonna be embedded as tab bar items
        self.setViewControllers([events,friends,ai,profile], animated: true)
        
        self.view.translatesAutoresizingMaskIntoConstraints = false


    }
    
    private func createNav(with title: String, and image: UIImage?, vc : UIViewController )
    -> UINavigationController
    {
        let nav  = UINavigationController(rootViewController: vc)
        nav.tabBarItem.title = title
        nav.tabBarItem.image = image
        nav.viewControllers.first?.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Help", style: .plain, target: nil, action: nil)
        return nav
    }

}
