import Foundation

class SessionStore: ObservableObject {
    @Published private(set) var sessions: [Session] = []

    private let storageKey = "sessions"
    static let maxSessions = 11

    init() {
        load()
    }

    func load() {
        let dict = UserDefaults.standard.dictionary(forKey: storageKey) ?? [:]
        sessions = dict.values.compactMap { value -> Session? in
            guard let entry = value as? [String: Any],
                  let duration = entry["duration"] as? Int,
                  let uuid = entry["UUID"] as? String else { return nil }
            return Session(durationInSeconds: duration, id: uuid)
        }.sorted()
    }

    func add(_ session: Session) {
        var dict = UserDefaults.standard.dictionary(forKey: storageKey) ?? [:]
        dict[session.id] = ["duration": session.durationInSeconds, "UUID": session.id]
        UserDefaults.standard.set(dict, forKey: storageKey)
        load()
    }

    func remove(_ session: Session) {
        var dict = UserDefaults.standard.dictionary(forKey: storageKey) ?? [:]
        dict.removeValue(forKey: session.id)
        UserDefaults.standard.set(dict, forKey: storageKey)
        load()
    }

    func hasDuplicate(duration: Int) -> Bool {
        sessions.contains { $0.durationInSeconds == duration }
    }

    var isFull: Bool {
        sessions.count >= SessionStore.maxSessions
    }
}
