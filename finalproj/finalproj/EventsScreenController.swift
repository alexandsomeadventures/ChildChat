import UIKit

class EventsScreenController: UIViewController {
    
    private let eventImages: [UIImage] = [
        UIImage(named: "Chess")!,
        UIImage(named: "Study")!,
        UIImage(named: "Party")!,
        UIImage(named: "Swimming")!,
        UIImage(named: "Golf")!,
        UIImage(named: "Music")!,
        UIImage(named: "Painting")!,
        UIImage(named: "Coding")!
    ]
    
    //defining table view cell for each event. scroll comes with table view
    private let tableView: UITableView = {
        let tableView = UITableView()
        
        //allows user to be able to press on table cells
        tableView.allowsSelection = true
        
        //same identifier can be used for multiple cells if their design/layout is same
        //when registering, you are informing table view about type of cell you want to create. that's why you have to pass class type with ".self"
        //registration of cell types is done once. Only passed cell types are used instead of all of them, which is efficient for memory
        tableView.register(customCell.self, forCellReuseIdentifier: customCell.identifier)

        return tableView
    }()
    
    
    //implementing search
    
    //overlays the search results controller over the current content
    //this only implies that when search results are shown to user, they are not shown in different view controller. searching and getting results is all done on this same view controller because we set "nil" parameter
    //there is no search result controller when nil. that's why by logic, it is just our own controller
    private let searchController = UISearchController(searchResultsController: nil)
    let segmentedControl = UISegmentedControl(items: ["All", "Recent", "Popular"])
    let toolbar = UIToolbar()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .systemBackground
        self.setupSearch()
        self.setupToolbar()
        self.setupUI()
        
        //handles action triggering when specific cell is selected
        //adjusts dynamic row height based on content
        //provides custom views for headers and footers of sections
        self.tableView.delegate = self
        
        //this tells how many rows are there to display proper amount of cells
        // it also displays returned cell with configured data for specific row
        self.tableView.dataSource = self

    }
    private func setupToolbar() {
        //making filter options
        segmentedControl.sizeToFit()
        let segmentBarItem = UIBarButtonItem(customView: segmentedControl)
        

        toolbar.setItems([segmentBarItem], animated: false)
        toolbar.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(toolbar)
        
        NSLayoutConstraint.activate([
            toolbar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            toolbar.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            toolbar.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
    private func setupSearch(){
        //this same view controller is responsible for updating search results since updater is assigned to "self"
        self.searchController.searchResultsUpdater = self
        
        //obscure background = true will dim background content. Search results then can be properly shown on screen without visual overlap with background interface.
        self.searchController.obscuresBackgroundDuringPresentation = false
        
        //navigation bar stays visible during search
        self.searchController.hidesNavigationBarDuringPresentation = false
        self.searchController.searchBar.placeholder = "Search Events"
        
        //now the search controller is put inside nav bar
        self.navigationItem.searchController = searchController
        
        // this controls when views(such as search results) are shown and when dismissed. if true, they are dismissed as soon as other controller is on screen. if false and user navigates to other view, they might still be on screen
        self.definesPresentationContext = false
        
        //when scrolling, search bar is not gone
        self.navigationItem.hidesSearchBarWhenScrolling = false
        
        
    }
    
    private func setupUI(){
        
        //rows and cells reside inside delegate and dataSource of table. we just have to implement methods for those protocols; then, those 2 are used automatically for display of table view when adding table in subview
        self.view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: self.toolbar.bottomAnchor),
            tableView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor)
        
        
        ])
        
        //there are multiple views; scrolling doesn't work because table view is not on top; other views obscure it; that's why we increase its z-index/bring it in front of other views so that we can scroll
        view.bringSubviewToFront(tableView)
        
    }
    

    
}
extension EventsScreenController: UISearchResultsUpdating {
        
        //this method is called whenever search bar text changes.
        //we conform to protocol since that protocol gives us method to filter unnecessary findings and show relevant information according to search bar input and update ui
        func updateSearchResults(for searchController: UISearchController){
            print("debug,")
        }
    }


//our view controller will handle both the interaction logic and the data management for the table.
//that's why we need to conform to protocols
//the delegate and dataSource of our table depend on this extension's methods
extension EventsScreenController: UITableViewDelegate, UITableViewDataSource {
    
    //telling table how many rows we want
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        //we need same number of rows as same number of images in the array
        return self.eventImages.count
    }
    
    //pass row index to obtain a cell. Then, configure the cell and use it
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: customCell.identifier, for: indexPath) as? customCell else {
            fatalError("The TableView could not dequeue a customCell")
        }
        
        //internally, tableview uses some kind of loop to iterate through all indexes in indexPath
        let image = self.eventImages[indexPath.row]
        cell.configure(with: image, and: "swimming session")
        
        return cell
    }

    
    
    
}
