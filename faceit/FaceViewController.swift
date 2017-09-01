//
//  FaceViewController.swift
//  faceit
//
//  Created by Jin on 2/19/17.
//  Copyright © 2017 Jin. All rights reserved.
//

import UIKit

class FaceViewController: UIViewController {
    
    @IBOutlet weak var faceView: FaceView!{
        didSet{
            faceView.addGestureRecognizer(UIPinchGestureRecognizer(
                target: faceView, action: #selector(faceView.changeScale)
            ))
            let happySwipe = UISwipeGestureRecognizer(target: self, action: #selector(increaseHappiness))
            happySwipe.direction = .up
            faceView.addGestureRecognizer(happySwipe)
            let sadSwipe = UISwipeGestureRecognizer(target: self, action: #selector(decreaseHappiness))
            sadSwipe.direction = .down
            faceView.addGestureRecognizer(sadSwipe)
            updateUI()
        }
    }
    
    @IBAction func toggleEyes(_ sender: UITapGestureRecognizer) {
        if sender.state == .ended{
            switch expression.eyes {
            case .Open:
                expression.eyes = .Closed
            case .Closed:
                expression.eyes = .Open
            default:
                break
            }
        }
    }
    
    @IBAction func headRotate(_ sender: UITapGestureRecognizer) {
        UIView.animate(withDuration: 0.5, animations: {
            self.faceView.transform = self.faceView.transform.rotated(by: 3.14/6)
        }, completion: nil)
    }
    
    func increaseHappiness(){
        expression.mouth = expression.mouth.happierMouth()
    }
    
    func decreaseHappiness(){
        expression.mouth = expression.mouth.sadderMouth()
    }
    
    var expression: FacialExpression = FacialExpression(eyes:.Open, eyeBrows:.Normal,mouth:.Smile){
        didSet{
            updateUI()
        }
    }
    
    private let mouthCurvatures = [FacialExpression.Mouth.Frown:-1.0,.Grin:0.5 ,.Smile:1.0, .Smirk:-0.5,.Neutral:0.0]
    private let eyeBrowTilts = [FacialExpression.EyeBrows.Relaxed:0.5,.Furrowed:-0.5,.Normal:0.0]
    
    private func updateUI(){
        if faceView == nil {return}
        switch expression.eyes {
        case .Open:
            faceView.eyesOpen = true
        case .Closed:
            faceView.eyesOpen = false
        default:
            faceView.eyesOpen = false
        }
        faceView.mouthCurvature = mouthCurvatures[expression.mouth] ?? 0.0
        faceView.eyeBrowTilt = eyeBrowTilts[expression.eyeBrows] ?? 0.0
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }

}
