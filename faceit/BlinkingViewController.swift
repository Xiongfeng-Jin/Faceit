//
//  BlinkingViewController.swift
//  faceit
//
//  Created by Jin on 2/26/17.
//  Copyright © 2017 Jin. All rights reserved.
//

import UIKit

class BlinkingViewController: FaceViewController {
    var blinking:Bool = false{
        didSet{
            startBlink()
        }
    }
    
    private struct BlinkRate{
        static let ClosedDuration = 0.4
        static let OpenDuration = 0.1
    }
    
    private func startBlink(){
        if blinking {
            faceView.eyesOpen = false
            Timer.scheduledTimer(withTimeInterval: BlinkRate.ClosedDuration, repeats: false){_ in self.endBlink() }
        }
    }
    
    private func endBlink(){
        faceView.eyesOpen = true
        Timer.scheduledTimer(withTimeInterval: BlinkRate.OpenDuration, repeats: false){_ in self.startBlink()}
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        blinking = true
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        blinking = false
    }
}
