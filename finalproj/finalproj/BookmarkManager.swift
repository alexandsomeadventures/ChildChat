class BookmarkManager
// we need this class as a shared service. We need to pass data between controllers to save events. That's why we can use this file as go-between
{
    static let shared = BookmarkManager()
    private init() {}

    var bookmarkedEvents: [String] = []

    func addEvent(_ event: String) {
        bookmarkedEvents.append(event)
    }

    func removeEvent(_ event: String) {
        bookmarkedEvents = bookmarkedEvents.filter { $0 != event }
    }

    func isEventBookmarked(_ event: String) -> Bool {
        return bookmarkedEvents.contains(event)
    }
}
