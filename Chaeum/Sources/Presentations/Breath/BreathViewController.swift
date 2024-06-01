//
//  BreathViewController.swift
//  Chaeum
//
//  Created by 권민재 on 6/1/24.
//
import UIKit
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

class BreathViewController: UIViewController {
    var breathRecognizer: BreathRecognizer?
    var targetViews: [UIView] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        // 화면의 너비를 가져옵니다.
        let screenWidth = UIScreen.main.bounds.width
        
        // 바람 인식기 초기화 및 시작
        breathRecognizer = BreathRecognizer(screenWidth: screenWidth)
        breathRecognizer?.setupAudioRecorder()
        breathRecognizer?.startMonitoring()
        
        // 타겟 뷰 설정
        for _ in 0..<5 {
            let targetView = UIView(frame: CGRect(x: 100, y: 100, width: 100, height: 100))
            targetView.backgroundColor = .blue
            view.addSubview(targetView)
            targetViews.append(targetView)
            breathRecognizer?.addTargetView(targetView)
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        breathRecognizer?.stopMonitoring()
    }
}
