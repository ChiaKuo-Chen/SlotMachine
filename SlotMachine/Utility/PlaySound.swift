//
//  PlaySound.swift
//  SlotMachine
//
//  Created by 陳嘉國
//

import AVFoundation

var audioPlayer: AVAudioPlayer?
var audioPlayer2: AVAudioPlayer?

func playSound(sound: String, type: String) {
    if let path = Bundle.main.path(forResource: sound, ofType: type) {
        do {
            audioPlayer = try AVAudioPlayer(contentsOf: URL(fileURLWithPath: path))
            audioPlayer?.play()
        } catch {
            print("ERROR: Could not find and play the sound file!")
        }
    }
}

func playSound2(sound: String, type: String) {
    if let path = Bundle.main.path(forResource: sound, ofType: type) {
        do {
            audioPlayer2 = try AVAudioPlayer(contentsOf: URL(fileURLWithPath: path))
            audioPlayer2?.play()
        } catch {
            print("ERROR: Could not find and play the sound file!")
        }
    }
}

func playSound(sound: String, type: String, duration: Double) {
    if let path = Bundle.main.path(forResource: sound, ofType: type) {
        do {
            audioPlayer = try AVAudioPlayer(contentsOf: URL(fileURLWithPath: path))
            audioPlayer?.numberOfLoops = -1
            audioPlayer?.play()

            DispatchQueue.main.asyncAfter(deadline: .now() + duration){
                audioPlayer?.stop()
            }

        } catch {
            print("ERROR: Could not find and stop the sound file!")
        }
    }
}

func playSound2(sound: String, type: String, duration: Double) {
    if let path = Bundle.main.path(forResource: sound, ofType: type) {
        do {
            audioPlayer2 = try AVAudioPlayer(contentsOf: URL(fileURLWithPath: path))
            audioPlayer2?.numberOfLoops = -1
            audioPlayer2?.play()

            DispatchQueue.main.asyncAfter(deadline: .now() + duration){
                audioPlayer2?.stop()
            }

        } catch {
            print("ERROR: Could not find and stop the sound file!")
        }
    }
}

