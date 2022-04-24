//
//  File.swift
//  GOSProject
//
//  Created by daniel stefanus christiawan on 23/04/22.
//

import Foundation
import AVFoundation

var soundBG: AVAudioPlayer?
var soundEff: AVAudioPlayer?
var soundWin: AVAudioPlayer?
var soundLose: AVAudioPlayer?
var soundDraw: AVAudioPlayer?

func playBGM() {
    let url = Bundle.main.url(forResource: "retrorace", withExtension: "mp3")
    
    guard url != nil else {
        print("not found")
        return
    }
    
    do {
        soundBG = try AVAudioPlayer(contentsOf: url!)
        soundBG?.numberOfLoops = -1
        soundBG?.play()
    } catch {
        print("Somethin wrong")
    }
}

func playSfx(key: String) {
    let url = Bundle.main.url(forResource: key, withExtension: "mp3")
    
    guard url != nil else {
        print("not found")
        return
    }
    do {
        soundEff = try AVAudioPlayer(contentsOf: url!)
        soundEff?.play()
    } catch {
        print("Somethin wrong")
    }
}

//func playSoundWin(key: String) {
//    let url = Bundle.main.url(forResource: key, withExtension: "mp3")
//
//    guard url != nil else {
//        print("not found")
//        return
//    }
//
//    do {
//        soundWin = try AVAudioPlayer(contentsOf: url!)
//        soundWin?.play()
//    } catch {
//        print("error")
//    }
//}
