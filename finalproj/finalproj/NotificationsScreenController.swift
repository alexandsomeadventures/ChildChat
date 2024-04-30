import UIKit
import UserNotifications

class NotificationsScreenController: UIViewController {
    
    private var notificationSwitch: UISwitch!
    private var notificationLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        setupNotificationSwitch()
        checkForPermission()
    }
    
    private func setupNotificationSwitch() {
        notificationSwitch = UISwitch()
        notificationSwitch.isOn = false
        notificationLabel = UILabel()
        notificationLabel.text = "Notifications are off"
        
        notificationSwitch.addTarget(self, action: #selector(checkForPermission), for: .valueChanged)
        
        notificationSwitch.translatesAutoresizingMaskIntoConstraints = false
        notificationLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(notificationSwitch)
        view.addSubview(notificationLabel)
        
        NSLayoutConstraint.activate([
            notificationSwitch.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 100),
            notificationSwitch.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            notificationLabel.topAnchor.constraint(equalTo: notificationSwitch.bottomAnchor, constant: 20),
            notificationLabel.centerXAnchor.constraint(equalTo: self.view.centerXAnchor)
        ])
    }
    
    @objc private func checkForPermission() {
        let notificationCenter = UNUserNotificationCenter.current()
        notificationCenter.getNotificationSettings { settings in
            DispatchQueue.main.async {
                switch settings.authorizationStatus {
                case .notDetermined:
                    self.notificationSwitch.isOn = false
                    self.notificationLabel.text = "Notifications are off"
                    // Don't call checkForPermission() recursively here, it can create a loop
                case .authorized:
                    self.dispatchNotifications()
                case .denied:
                    self.notificationSwitch.isOn = false
                    self.notificationLabel.text = "Notifications are off"
                default:
                    break
                }
            }
        }
    }

    func findSoonestEvent() -> (name: String, date: Date)? {
        guard let firstEvent = RSVPManager.shared.RSVPEvents.first else {
              return nil
          }
        let calendar = Calendar.current
        var soonestEvent = firstEvent
        var soonestDate = soonestEvent.date
        var month = calendar.component(.month, from: soonestDate)
        var day = calendar.component(.day, from: soonestDate)
        var hour = calendar.component(.hour, from: soonestDate)
        var minute = calendar.component(.minute, from: soonestDate)
        for (name, date) in RSVPManager.shared.RSVPEvents {  // Ensure to use parentheses around the tuple
            let month2 = calendar.component(.month, from: date)
            let day2 = calendar.component(.day, from: date)
            let hour2 = calendar.component(.hour, from: date)
            let minute2 = calendar.component(.minute, from: date)
            if minute2 < minute && hour2 < hour && day2 < day && month2<month{
                // update soonestEvent if this event is sooner than the current soonestEvent
                soonestEvent = (name, date)
                month = month2
                day = day2
                hour = hour2
                minute = minute2
            }
        }
        return soonestEvent
    }
    // the run loop of core foundaiton must run on main thread. if not, then when it is running on background thread, this function might not work since dates won't be effective at triggering notifications at necessary times
    private func dispatchNotifications(){
        if  let soonestEvent = findSoonestEvent(){
            let calendar = Calendar.current
            let identifier = "eventNotification"
            let title = "Upcoming Event: \(soonestEvent.name)"
            let body = "Your next event starts at \(soonestEvent.date.formatted())!"
            
            //however this still doesn't work; it might be apple's bug itself
            let hour = calendar.component(.hour, from: soonestEvent.date)
            let minute = calendar.component(.minute, from: soonestEvent.date)
            
            let notificationCenter = UNUserNotificationCenter.current()
            
            
            let content = UNMutableNotificationContent()
            content.title = title
            content.body = body
            content.sound = .default
            
            var dateComponents = DateComponents(calendar : calendar, timeZone:  TimeZone.current)
            dateComponents.hour = hour
            dateComponents.minute = minute
            
            let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: false)
            let request = UNNotificationRequest(identifier: identifier, content: content, trigger: trigger)
            notificationCenter.removePendingNotificationRequests(withIdentifiers: [identifier])
            notificationCenter.add(request)
        }
    }
    @objc private func notificationSwitchChanged(_ sender: UISwitch) {
        if sender.isOn {
            checkForPermission()
        } else {
        
            notificationLabel.text = "Notifications are off"

        }
    }



}
