import Foundation
//import foundation because otherwise date is not recognized
class RSVPManager {
    static let shared = RSVPManager()
    private init() {}

    // Example using tuples to store event data
    var RSVPEvents: [(name: String, date: Date)] = []

    func addEvent(name: String, date: Date) {
        RSVPEvents.append((name, date))
    }

    func removeEvent(name: String) {
        RSVPEvents = RSVPEvents.filter { $0.name != name }
    }

    func isEventRSVPED(name: String) -> Bool {
        return RSVPEvents.contains { $0.name == name }
    }
    
}
