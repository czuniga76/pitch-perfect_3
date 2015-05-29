//
//  PlaySoundsViewController.swift
//  Pitch Perfect
//
//  Created by Christian D. Zuniga on 5/12/15.
//  Copyright (c) 2015 ZTechnology.com. All rights reserved.
//

import UIKit
import AVFoundation





class PlaySoundsViewController: UIViewController {

    var player:AVAudioPlayer!
    var receivedAudio:RecordedAudio!
    var audioEngine:AVAudioEngine!
    var audioFile:AVAudioFile!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        // Setup player and audioEngine for playback of recorded sound
        
        player = AVAudioPlayer(contentsOfURL: receivedAudio.filePathUrl, error: nil)
        player.enableRate = true
        
        player.prepareToPlay()
        audioEngine = AVAudioEngine()
        
        audioFile = AVAudioFile(forReading: receivedAudio.filePathUrl, error: nil)
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    @IBAction func stopPlaying(sender: UIButton) {
        stopAllAudio()
    }
    
    @IBAction func playFast(sender: UIButton) {
        stopAllAudio()
        playAudioWithVariableRate(2.0)
    }
    
    @IBAction func playSlowly(sender: UIButton) {
        stopAllAudio()
        playAudioWithVariableRate(0.5)
    }
    
    func stopAllAudio() {
        player.stop()
        audioEngine.stop()
        audioEngine.reset()

    }
    
    func playAudioWithVariableRate(rate: Float) {
        
       
        player.rate = rate
        player.currentTime = 0.0
        player.play()
        
    }
    
    @IBAction func playChipMunkAudio(sender: UIButton) {
        stopAllAudio()
        playAudioWithVariablePitch(1000)
        
    }
    
    func playAudioWithVariablePitch(pitch: Float) {
        
        
        
        var audioPlayerNode = AVAudioPlayerNode()
        audioEngine.attachNode(audioPlayerNode)
        
        var changePitchEffect = AVAudioUnitTimePitch()
        changePitchEffect.pitch = pitch
        audioEngine.attachNode(changePitchEffect)
        
        audioEngine.connect(audioPlayerNode, to: changePitchEffect, format: nil)
        audioEngine.connect(changePitchEffect, to: audioEngine.outputNode, format: nil)
        
        audioPlayerNode.scheduleFile(audioFile, atTime: nil, completionHandler: nil)
        audioEngine.startAndReturnError(nil)
        audioPlayerNode.play()
        
        
    }
    
    @IBAction func playDarthVaderAudio(sender: UIButton) {
         stopAllAudio()
         playAudioWithVariablePitch(-1000)
    }
}
