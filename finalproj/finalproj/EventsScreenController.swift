import UIKit

class EventsScreenController: UIViewController {
    var filteredEvents: [String] = []
    //just like templates
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
    private let eventTitles: [String] = [
    "Chess Workshop", "Study Session", "Party at San Pablo","Swimming Session", "Golf Tournament!", "Music: Beatles", "Painting class", "Web Development"
    ]
    private let eventDescriptions: [String] = [
    "Come to our Chess Workshop this weekend!\n We will teach people about different tactics\n and techniques! You might learn playing like Magnus Carlsen!\nLocation: LSA 191",
    "Come to Wexler Hall 123A to study with us for FINALS!\n The school is going to end very\n soon so don't miss this chance!",
    "Who doesn't love parties?\n This Sunday in San-Pablo we are hosting\n our biggest party ever!\n Celebrate end of the school year with us!\nLocation: San-Pablo",
    "Do you want to learn how to swim?\n This session is for you\n. It will teach the most fundamental\n skills used in swimming. Location:\nPool next Tooker",
    "We have collaborated with other club\n to host golf competition! The prizes\n are different, come and try!\n We will have free food and items. \nCome to SDFC field",
    "Do you love Beatles? Come \nthis Monday and discuss with us their band\n development!They had profound impact\n on today's music! Come to Gammage 212",
    "Painting might be difficult sometimes\n, but we make it easy! Make \nsure to hop in and draw something beautiful\n for your family. Come to WXLR 103",
    "Do you want to be good at HTML,\n CSS, or JS? Then this quick workshop\n is for you."
    
    ]
    private let eventDates: [Date] = {
        let calendar = Calendar.current
        let timeZone = TimeZone.current  // Adjust the time zone if necessary
        
        // Helper function to create dates
        func createDate(year: Int, month: Int, day: Int, hour: Int, minute: Int) -> Date? {
            var dateComponents = DateComponents()
            dateComponents.year = year
            dateComponents.month = month
            dateComponents.day = day
            dateComponents.hour = hour
            dateComponents.minute = minute
            dateComponents.timeZone = timeZone
            
            return calendar.date(from: dateComponents)
        }
        
        return [
            createDate(year: 2024, month: 4, day: 30, hour: 03, minute: 45),
            createDate(year: 2024, month: 4, day: 30, hour: 03, minute: 32),
            createDate(year: 2024, month: 4, day: 30, hour: 03, minute: 55),
            createDate(year: 2024, month: 4, day: 30, hour: 03, minute: 45),
            createDate(year: 2024, month: 4, day: 30, hour: 03, minute: 46),
            createDate(year: 2024, month: 4, day: 30, hour: 03, minute: 34),
            createDate(year: 2024, month: 4, day: 30, hour: 02, minute: 42),
            createDate(year: 2024, month: 4, day: 30, hour: 03, minute: 22),
        ].compactMap { $0 }  // This ensures only non-nil dates are included
    }()
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
        filteredEvents = eventTitles // initially all events included
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
        func updateSearchResults(for searchController: UISearchController) {
            guard let searchText = searchController.searchBar.text, !searchText.isEmpty else {
                filteredEvents = eventTitles // Reset to full list when search text is empty
                tableView.reloadData()
                return
            }
            
            // if search is not empty, .filter method iterates over eventTitles and includes only those titles that contain the search text
            // hence, we are filling array with filtered titles
            filteredEvents = eventTitles.filter { eventTitle in
                eventTitle.lowercased().contains(searchText.lowercased())
            }
            //swift recognizes connection between object(eventTitles) calling filter and parameter(eventTitle) which is iterable
            
            
            //reflects real-time changes
            tableView.reloadData()
        }
    }


//our view controller will handle both the interaction logic and the data management for the table.
//that's why we need to conform to protocols
//the delegate and dataSource of our table depend on this extension's methods
extension EventsScreenController: UITableViewDelegate, UITableViewDataSource {
    
    //telling table how many rows we want
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        //we need same number of rows as same number of images in the array
        return filteredEvents.count
    }
    
    //pass row index to obtain a cell. Then, configure the cell and use it
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: customCell.identifier, for: indexPath) as? customCell else {
            fatalError("The TableView could not dequeue a customCell")
        }
        
        
        //we are trying to find index in event titles of same event that is already in filtered ones; then when index found, we know it is the same element and use it to display other data
        let eventIndex = eventTitles.firstIndex(of: filteredEvents[indexPath.row]) ?? indexPath.row
        
        //internally, tableview uses some kind of loop to iterate through all indexes in indexPath

        let image = eventImages[eventIndex]
         let description = eventDescriptions[eventIndex]
         let date = eventDates[eventIndex]
        
        //we configure with filteredEvents array to present only results that fit search results. if search bar is empty, filtered Events = all of events
        cell.configure(with: image, and: filteredEvents[indexPath.row], also: description, and_also: date)
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 400  
    }
    
    //expanded view of an event
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detailVC = EventDetailScreenController()
        detailVC.eventImage = eventImages[indexPath.row]
        detailVC.eventTitle = eventTitles[indexPath.row]
        detailVC.eventDescription = eventDescriptions[indexPath.row]
        detailVC.eventDate = eventDates[indexPath.row]
        
        navigationController?.pushViewController(detailVC, animated: true)
    }


    
    
    
}
