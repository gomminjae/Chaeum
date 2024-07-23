//
//  BreathViewController.swift
//  Chaeum
//
//  Created by 권민재 on 6/1/24.
//
import UIKit
import AVFoundation

class BreathViewController: UIViewController {
    var breathRecognizer: BreathRecognizer?
    var targetViews: [UIView] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
      
        let screenWidth = UIScreen.main.bounds.width
        
    
        breathRecognizer = BreathRecognizer(screenWidth: screenWidth)
        breathRecognizer?.setupAudioRecorder()
        breathRecognizer?.startMonitoring()
        
        
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
