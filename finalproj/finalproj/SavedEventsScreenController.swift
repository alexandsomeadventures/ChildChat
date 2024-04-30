import UIKit
class SavedEventsScreenController: UIViewController, UITableViewDataSource {
    var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
    }

    private func setupTableView() {
        tableView = UITableView(frame: view.bounds, style: .plain)  
        tableView.autoresizingMask = [.flexibleWidth, .flexibleHeight]  // For automatic sizing
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "EventCell")
        view.addSubview(tableView)
    }


    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return BookmarkManager.shared.bookmarkedEvents.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "EventCell", for: indexPath)
        cell.textLabel?.text = BookmarkManager.shared.bookmarkedEvents[indexPath.row]
        return cell
    }
    
    //to keep up with real-time changes, reload the table
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }

}
