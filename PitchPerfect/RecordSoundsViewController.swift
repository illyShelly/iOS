//
//  RecordSoundsViewController.swift
//  PitchPerfect
//
//  Created by Illy Sell on 08/05/2020.
//  Copyright © 2020 Udacity. All rights reserved.
//

import UIKit
import AVFoundation

class RecordSoundsViewController: UIViewController, AVAudioRecorderDelegate {
    
    @IBOutlet weak var recordButton: UIButton!
    @IBOutlet weak var recordingLabel: UILabel!
    @IBOutlet weak var stopRecordingButton: UIButton!

    var audioRecorder: AVAudioRecorder!

    override func viewDidLoad() {
        super.viewDidLoad()
        stopRecordingButton.isEnabled = false
        // Do any additional setup after loading the view.
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print("view Will Appear called")
    }
    
    @IBAction func recordAudio(_ sender: Any) {
        recordingLabel.text = "Recording in Progress"
        stopRecordingButton.isEnabled = true
        recordButton.isEnabled = false

        let dirPath = NSSearchPathForDirectoriesInDomains(.documentDirectory,.userDomainMask, true)[0] as String
        let recordingName = "recordedVoice.wav"
        let pathArray = [dirPath, recordingName]
        let filePath = URL(string: pathArray.joined(separator: "/"))
        print(filePath as Any)
        
        let session = AVAudioSession.sharedInstance()
        try! session.setCategory(AVAudioSession.Category.playAndRecord, mode: AVAudioSession.Mode.default, options: AVAudioSession.CategoryOptions.defaultToSpeaker)
        
        try! audioRecorder = AVAudioRecorder(url: filePath!, settings: [:])
        audioRecorder.delegate = self
        audioRecorder.isMeteringEnabled = true
        audioRecorder.prepareToRecord()
        audioRecorder.record()
    }
    
    @IBAction func stopRecording(_ sender: Any) {
//    print("stop recording btn was pressed")
        stopRecordingButton.isEnabled = false
        recordButton.isEnabled = true
        recordingLabel.text = "Tap to Record"
        audioRecorder.stop()
        let audioSession = AVAudioSession.sharedInstance()
        try! audioSession.setActive(false)
    }
    func audioRecorderDidFinishRecording(_ recorder: AVAudioRecorder, successfully flag: Bool) {
        if flag {
            performSegue(withIdentifier: "stopRecording", sender: audioRecorder.url)
        } else {
            print("finished recording")
        }
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "stopRecording" {
            let playSoundsVC = segue.destination as! PlaySoundsViewController
            let recordedAudioURL = sender as! URL
            playSoundsVC.recordedAudioURL = recordedAudioURL
        }
    }
}
    
    
    
//import UIKit
//import AVFoundation
//class RecordSoundsViewController: UIViewController, AVAudioRecorderDelegate {
//
//    var audioRecorder: AVAudioRecorder!
//
//    @IBOutlet weak var recordButton: UIButton!
//    @IBOutlet weak var recordingLabel: UILabel!
//    @IBOutlet weak var stopRecordingButton: UIButton!
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        stopRecordingButton.isEnabled = false
//        // Do any additional setup after loading the view.
//    }
//    override func viewWillAppear(_ animated: Bool) {
//        super.viewWillAppear(animated)
//        print("view will appear")
//    }
    
//    @IBAction func recordAudio(_ sender: Any) {
//        recordingLabel.text = "Recording in progress"
//        stopRecordingButton.isEnabled = true
//        recordButton.isEnabled = false
//
//        let dirPath = NSSearchPathForDirectoriesInDomains(.documentDirectory,.userDomainMask, true)[0] as String
//        let recordingName = "recordedVoice.wav"
//        let pathArray = [dirPath, recordingName]
//        let filePath = URL(string: pathArray.joined(separator: "/"))
        
//        let session = AVAudioSession.sharedInstance()
//        try! session.setCategory(AVAudioSession.Category.playAndRecord, mode: AVAudioSession.Mode.default, options: AVAudioSession.CategoryOptions.defaultToSpeaker)
        
//        try! audioRecorder = AVAudioRecorder(url: filePath!, settings: [:])
//        audioRecorder.delegate = self
//        audioRecorder.isMeteringEnabled = true
//        audioRecorder.prepareToRecord()
//        audioRecorder.record()
//    }
    
//    @IBAction func stopRecording(_ sender: Any) {
//        stopRecordingButton.isEnabled = false
//        recordButton.isEnabled = true
//        recordingLabel.text = "Tap to Record"
//
//        audioRecorder.stop()
//        let audioSession = AVAudioSession.sharedInstance()
//        try! audioSession.setActive(false)
//    }
    


//    func audioRecorderDidFinishRecording(_ recorder: AVAudioRecorder, successfully flag: Bool) {
//        if flag{
//            performSegue(withIdentifier: "stopRecording", sender: audioRecorder.url)
//        } else{
//            print("Recording was not successful")
//        }
//    }
//
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        if segue.identifier == "stopRecording"{
//            let playSoundsVC = segue.destination as! PlaySoundsViewController
//            let recordedAudioURL = sender as! URL
//            playSoundsVC.recordedAudioURL = recordedAudioURL
//        }
//    }
//}
