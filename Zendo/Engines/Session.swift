import Foundation

struct Session: Identifiable, Comparable {
    let id: String
    let durationInSeconds: Int

    var displayDuration: Int { durationInSeconds / 60 }

    var title: String {
        var hrText = "hour"
        var minText = "minutes"
        var totalText = ""

        let minutes = displayDuration
        let hours = minutes / 60
        let mins = minutes % 60

        if hours > 0 {
            hrText = hours > 1 ? "hours" : "hour"
            totalText = "\(hours) \(hrText), "
        }

        if minutes == 1 { minText = "minute" }

        totalText += "\(mins) \(minText)"
        return totalText
    }

    init(durationInSeconds: Int, id: String = UUID().uuidString) {
        self.durationInSeconds = durationInSeconds
        self.id = id
    }

    func randomQuote() -> String {
        guard !Constants.msgGeneric.isEmpty else { return "" }
        let index = Int.random(in: 0..<Constants.msgGeneric.count)
        let raw = Constants.msgGeneric[index]

        if let dashRange = raw.range(of: " - ", options: .backwards) {
            let text = String(raw[raw.startIndex..<dashRange.lowerBound])
            let author = String(raw[dashRange.upperBound...])
            return "\(text)\n– \(author)"
        }
        return raw
    }

    static func == (lhs: Session, rhs: Session) -> Bool {
        lhs.id == rhs.id
    }

    static func < (lhs: Session, rhs: Session) -> Bool {
        lhs.durationInSeconds < rhs.durationInSeconds
    }
}
