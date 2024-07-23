//
//  BreathRegognizer.swift
//  Chaeum
//
//  Created by 권민재 on 7/23/24.
//

import UIKit
import RxSwift
import AVFoundation


class BreathRecognizer: NSObject, AVAudioRecorderDelegate {
    var audioRecorder: AVAudioRecorder?
    var targetViews: [UIView] = []
    var screenWidth: CGFloat = 0

    init(screenWidth: CGFloat) {
        self.screenWidth = screenWidth
    }

    func setupAudioRecorder() {
        let audioSession = AVAudioSession.sharedInstance()
        
        do {
            try audioSession.setCategory(.playAndRecord, mode: .default, options: .defaultToSpeaker)
            try audioSession.setActive(true)
            
            let settings = [
                AVFormatIDKey: Int(kAudioFormatAppleLossless),
                AVSampleRateKey: 44100.0,
                AVNumberOfChannelsKey: 1,
                AVEncoderAudioQualityKey: AVAudioQuality.high.rawValue
            ] as [String : Any]
            
            audioRecorder = try AVAudioRecorder(url: getFileURL(), settings: settings)
            audioRecorder?.delegate = self
            audioRecorder?.isMeteringEnabled = true
            audioRecorder?.prepareToRecord()
        } catch {
            print("Failed to set up audio session: \(error)")
        }
    }
    
    func getFileURL() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let documentDirectory = paths[0]
        return documentDirectory.appendingPathComponent("breath.caf")
    }
    
    func addTargetView(_ view: UIView) {
        targetViews.append(view)
    }
    
    func startMonitoring() {
        audioRecorder?.record()
        Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(checkAudioLevel), userInfo: nil, repeats: true)
    }
    
    @objc func checkAudioLevel() {
        audioRecorder?.updateMeters()
        
        if let averagePower = audioRecorder?.averagePower(forChannel: 0) {
            print("Average power: \(averagePower)")
            
            // 바람의 세기에 따라 모든 뷰를 날아가게 합니다.
            let movementFactor: CGFloat = 5.0 // 뷰가 날아가는 정도를 조절합니다.
            let windStrength = CGFloat(-averagePower) * movementFactor
            
            for view in targetViews {
                UIView.animate(withDuration: 0.5) {
                    // 바람의 세기에 따라 각 뷰를 날아가게 합니다.
                    self.moveView(view, by: windStrength)
                }
            }
        }
    }
    
    
    func moveView(_ view: UIView, by distance: CGFloat) {
        // 현재 뷰의 위치를 가져옵니다.
        var newPosition = CGPoint(x: view.center.x + distance, y: view.center.y)
        
        // 새로운 위치가 화면을 벗어나지 않도록 제한합니다.
        let viewWidth = view.frame.width
        newPosition.x = min(max(newPosition.x, viewWidth / 2), screenWidth - viewWidth / 2)
        // 뷰의 위치를 업데이트합니다.
        view.center = newPosition
    }
    
    func stopMonitoring() {
        audioRecorder?.stop()
    }
}
