import UIKit

class customCell: UITableViewCell {

    static let identifier = "customCell"

    
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
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //we make this method public to make it accessible from other classes
    public func configure(with image: UIImage, and label: String){
        self.eventImageView.image = image
        self.eventLabel.text = label
    }
    
    private func setupUI(){
        //you can add directly through self.addSubview
        //but contentView is table cell feature. It basically allows to put views over cell
        self.contentView.addSubview(eventImageView)
        self.contentView.addSubview(eventLabel)
        
        eventImageView.translatesAutoresizingMaskIntoConstraints = false
        eventLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            //we want images to be a bit separate from each other by adding margins with .layoutMarginsGuide
            //with labels, we don't really need margins between them
            eventImageView.topAnchor.constraint(equalTo: self.contentView.topAnchor),
            eventImageView.bottomAnchor.constraint(equalTo: self.contentView.layoutMarginsGuide.bottomAnchor,constant: -20)   ,
            eventImageView.leadingAnchor.constraint(equalTo: self.contentView.layoutMarginsGuide.leadingAnchor),
            eventImageView.trailingAnchor.constraint(equalTo: self.contentView.layoutMarginsGuide.trailingAnchor),
            
            //constant adds padding
            eventLabel.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 16),
            eventLabel.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -12),
            eventLabel.topAnchor.constraint(equalTo: self.eventImageView.bottomAnchor),
            eventLabel.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor,constant: -5),
            
            
            //since different image sizes can be loaded, let's adjust them all to one equal size
            eventImageView.heightAnchor.constraint(equalToConstant: 150),
            eventImageView.widthAnchor.constraint(equalToConstant: 150)
            
        ])
        
    }
    
}
