import UIKit

class customCell: UITableViewCell {

    static let identifier = "customCell"
    var eventName: String?
    var rsvpName: String?
    var rsvpDate: Date!
    // this type of syntax "{}()" is lazy init.
    //usually object is constructed during declaration, but here swift waits until it is actually used for the first time
    private let eventImageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFit
        iv.image = UIImage(systemName: "questionmark")//if we fail, by default displays image with question
        
        iv.tintColor = .label
        return iv
        
    }()
    
    private let eventLabel: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 24, weight: .medium)
        label.text = "Error" //default label
        return label
        
    }()
    private let eventDescription: UILabel = {
        let label = UILabel()
        label.textColor = .secondaryLabel
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 24, weight: .regular)
        label.text = "Error"
        label.numberOfLines = 0
        return label
        
    }()
    private let eventDate: Date = {
        let date = Date()
        return date
        
    }()
    private let eventSaveButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "bookmark"), for: .normal)
        button.tintColor = .gray
        button.addTarget(self, action: #selector(bookmarkEvent), for: .touchUpInside)
        return button
    }()
    private let eventDiscussButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "ellipsis.message"), for: .normal)
        button.tintColor = .gray
        return button
    }()
    private let eventNotifyButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "bell"), for: .normal)
        button.tintColor = .gray
        return button
    }()
    
    private let eventRSVPButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "person.badge.plus"), for: .normal)
        button.tintColor = .gray
        button.addTarget(self, action: #selector(RSVPforEvent), for: .touchUpInside)
        return button
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    @objc func bookmarkEvent() {
        eventName = eventLabel.text
        guard let eventName = eventName else { return }
        if BookmarkManager.shared.isEventBookmarked(eventName) {
            BookmarkManager.shared.removeEvent(eventName)
            eventSaveButton.setImage(UIImage(systemName: "bookmark"), for: .normal) // Un-bookmarked state
        } else {
            BookmarkManager.shared.addEvent(eventName)
            eventSaveButton.setImage(UIImage(systemName: "bookmark.fill"), for: .normal) // Bookmarked state
        }
    }
    @objc func RSVPforEvent(){
        rsvpName = eventLabel.text
        rsvpDate = eventDate
        guard let rsvpName = rsvpName, let rsvpDate = rsvpDate else {return}
        if RSVPManager.shared.isEventRSVPED(name: rsvpName){
            RSVPManager.shared.removeEvent(name: rsvpName)
            eventRSVPButton.setImage(UIImage(systemName: "person.badge.plus"), for: .normal)
        }
        else{
            RSVPManager.shared.addEvent(name: rsvpName, date: rsvpDate)
            eventRSVPButton.setImage(UIImage(systemName: "person.badge.plus.fill"), for: .normal)
            
        }
        
    }
    
    //we make this method public to make it accessible from other classes
    
    public func configure(with image: UIImage, and label: String, also description: String, and_also date: Date ){
        self.eventImageView.image = image
        self.eventLabel.text = label
        self.eventDescription.text = description
        
    }
    
    private func setupUI() {
        contentView.addSubview(eventImageView)
        contentView.addSubview(eventLabel)
        contentView.addSubview(eventSaveButton)
        contentView.addSubview(eventDiscussButton)
        contentView.addSubview(eventNotifyButton)
        contentView.addSubview(eventRSVPButton)
        eventImageView.translatesAutoresizingMaskIntoConstraints = false
        eventLabel.translatesAutoresizingMaskIntoConstraints = false
        eventDiscussButton.translatesAutoresizingMaskIntoConstraints = false
        eventSaveButton.translatesAutoresizingMaskIntoConstraints = false
        eventNotifyButton.translatesAutoresizingMaskIntoConstraints = false
        eventRSVPButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            eventImageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            eventImageView.leadingAnchor.constraint(equalTo: contentView.layoutMarginsGuide.leadingAnchor),
            eventImageView.trailingAnchor.constraint(equalTo: contentView.layoutMarginsGuide.trailingAnchor),
            eventImageView.bottomAnchor.constraint(equalTo: eventLabel.topAnchor),
            
            eventLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            eventLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            eventLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8),
            eventLabel.heightAnchor.constraint(equalToConstant: 44), // Fixed height for label
            
            eventDiscussButton.trailingAnchor.constraint(equalTo: self.eventLabel.leadingAnchor,constant: 40),
            eventDiscussButton.topAnchor.constraint(equalTo: self.eventImageView.bottomAnchor,constant: 10),
            eventSaveButton.leadingAnchor.constraint(equalTo: self.eventDiscussButton.trailingAnchor, constant: 10),
            eventSaveButton.topAnchor.constraint(equalTo: self.eventImageView.bottomAnchor,constant: 10),
            eventNotifyButton.leadingAnchor.constraint(equalTo: self.eventRSVPButton.trailingAnchor, constant: -50),
            eventNotifyButton.topAnchor.constraint(equalTo: self.eventImageView.bottomAnchor,constant: 10),
            eventRSVPButton.leadingAnchor.constraint(equalTo: self.eventLabel.trailingAnchor, constant: -50),
            eventRSVPButton.topAnchor.constraint(equalTo: self.eventImageView.bottomAnchor,constant: 10)
            
            
        ])
        
        eventImageView.contentMode = .scaleAspectFill // Makes the image fill the available space and maintain aspect ratio
        eventImageView.clipsToBounds = true // Ensures the image does not spill outside its bounds
    }

    
}
