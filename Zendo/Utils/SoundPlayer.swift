import AVFoundation

class SoundPlayer {
    private static var player: AVAudioPlayer?

    static func playCustomSound(name: String, ext: String) {
        guard let url = Bundle.main.url(forResource: name, withExtension: ext) else {
            return
        }

        do {
            try AVAudioSession.sharedInstance().setCategory(.playback, mode: .default)
            try AVAudioSession.sharedInstance().setActive(true)

            let newPlayer = try AVAudioPlayer(contentsOf: url)
            player = newPlayer
            newPlayer.play()
        } catch {
            print("SoundPlayer error: \(error)")
        }
    }
}
