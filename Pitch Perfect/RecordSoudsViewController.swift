//
//  RecordSoundsViewController.swift
//  Pitch Perfect
//
//  Created by Christian D. Zuniga on 5/8/15.
//  Copyright (c) 2015 ZTechnology.com. All rights reserved.
//

import UIKit
import AVFoundation


class RecordSoundsViewController: UIViewController, AVAudioRecorderDelegate {

    @IBOutlet weak var recordingLabel: UILabel!
    @IBOutlet weak var recordButton: UIButton!
    @IBOutlet weak var stopBotton: UIButton!
    @IBOutlet weak var pauseButton: UIButton!

    var audioRecorder:AVAudioRecorder!
    var recordedAudio:RecordedAudio!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        // Setup audio session and AVAudioRecorder. Save recordings as wav files using current date and time
        
        let dirPath = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)[0] as String
        let currentDateTime = NSDate()
        let formatter = NSDateFormatter()
        formatter.dateFormat = "ddMMyyyy-HHmmss"
        let recordingName = formatter.stringFromDate(currentDateTime)+".wav"
        let pathArray = [dirPath, recordingName]
        let filePath = NSURL.fileURLWithPathComponents(pathArray)
        var session = AVAudioSession.sharedInstance()
        
        session.setCategory(AVAudioSessionCategoryPlayAndRecord, error:nil)
        
        audioRecorder = AVAudioRecorder(URL: filePath, settings:nil, error: nil)
        audioRecorder.meteringEnabled = true
        audioRecorder.delegate = self;
        audioRecorder.prepareToRecord()
        recordingLabel.text = "Tap to Record"
        

        
    }
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        stopBotton.hidden = true
        recordButton.enabled = true
        pauseButton.hidden = true
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    @IBAction func stopRecording(sender: UIButton) {
        recordingLabel.text = "Tap to Record"
        stopBotton.hidden = true
        audioRecorder.stop()
        var audioSession = AVAudioSession.sharedInstance()
        audioSession.setActive(false,error:nil)
        
    }
    
    @IBAction func recordAudio(sender: UIButton) {
        
        stopBotton.hidden = false
        recordButton.enabled = false
        recordingLabel.text = "Recording"
        pauseButton.hidden = false 
        pauseButton.enabled = true
        
        
        audioRecorder.record()
        
        
       
        
    }
    
    @IBAction func pauseAudio(sender: UIButton) {
        audioRecorder.pause()
        recordingLabel.text = "Paused, Tap to Resume"
        stopBotton.hidden = true
        recordButton.enabled = true
        
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if (segue.identifier == "stopRecording") {
            let playSoundsVC:PlaySoundsViewController = segue.destinationViewController as PlaySoundsViewController
            let data = sender as RecordedAudio
            // Pass data, recorded file and title, to PlaySoundsViewController
            playSoundsVC.receivedAudio = data
            
        }
    }
    
    func audioRecorderDidFinishRecording(recorder: AVAudioRecorder!, successfully flag: Bool) {
        // When recording stops, obtain information on file name and title, store it in recordedAudio and pass the information to the next controller using performSegueWithIdentifier
        
        if (flag) {
            recordedAudio = RecordedAudio(filePathUrl: recorder.url,title: recorder.url.lastPathComponent!)
            self.performSegueWithIdentifier("stopRecording", sender: recordedAudio)
            
        } else{
            println("Recording was not suffessful")
            recordButton.enabled = true
            stopBotton.hidden = true
        }
    }
    
    }

