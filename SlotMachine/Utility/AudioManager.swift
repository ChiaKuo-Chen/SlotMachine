//
//  PlaySound.swift
//  SlotMachine
//
//  Created by 陳嘉國
//

import SwiftUI
import AVFoundation

class AudioManager: ObservableObject {
    
    var audioPlayer: AVAudioPlayer?
    var audioPlayer2: AVAudioPlayer?
    
    @Published var isMuted: Bool = false {
        didSet {
            audioPlayer?.volume = isMuted ? 0 : 1
            audioPlayer2?.volume = isMuted ? 0 : 1
        }
    }
    
    func toggleMute() {
        isMuted.toggle()
    }
    
    func playSound(sound: String, type: String) {
        if let url = Bundle.main.url(forResource: sound, withExtension: type) {
            do {
                audioPlayer = try AVAudioPlayer(contentsOf: url)
                audioPlayer?.volume = isMuted ? 0 : 1
                audioPlayer?.play()
            } catch {
                print("ERROR: Could not find and play the sound file!")
            }
        }
    }
    
    func playSound(sound: String, type: String, duration: Double) {
        if let url = Bundle.main.url(forResource: sound, withExtension: type) {
            do {
                audioPlayer = try AVAudioPlayer(contentsOf: url)
                audioPlayer?.numberOfLoops = -1
                audioPlayer?.volume = isMuted ? 0 : 1
                audioPlayer?.play()
                
                DispatchQueue.main.asyncAfter(deadline: .now() + duration){
                    self.audioPlayer?.stop()
                }
                
            } catch {
                print("ERROR: Could not find and stop the sound file!")
            }
        }
    }
    
    func playSound2(sound: String, type: String) {
        if let url = Bundle.main.url(forResource: sound, withExtension: type) {
            do {
                audioPlayer2 = try AVAudioPlayer(contentsOf: url)
                audioPlayer2?.volume = isMuted ? 0 : 1
                audioPlayer2?.play()
            } catch {
                print("ERROR: Could not find and play the sound file!")
            }
        }
    }
    
    func playSound2(sound: String, type: String, duration: Double) {
        if let url = Bundle.main.url(forResource: sound, withExtension: type) {
            do {
                audioPlayer2 = try AVAudioPlayer(contentsOf: url)
                audioPlayer2?.numberOfLoops = -1
                audioPlayer2?.volume = isMuted ? 0 : 1
                audioPlayer2?.play()
                
                DispatchQueue.main.asyncAfter(deadline: .now() + duration){
                    self.audioPlayer2?.stop()
                }
                
            } catch {
                print("ERROR: Could not find and stop the sound file!")
            }
        }
    }
    
    
    
}



