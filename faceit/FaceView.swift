//
//  FaceView.swift
//  faceit
//
//  Created by Jin on 2/19/17.
//  Copyright © 2017 Jin. All rights reserved.
//

import UIKit

@IBDesignable
class FaceView: UIView {
    @IBInspectable
    var mouthCurvature:Double = 1.0{didSet{setNeedsDisplay()}}
    @IBInspectable
    var eyesOpen:Bool = true{didSet{setNeedsDisplay()}}
    @IBInspectable
    var eyeBrowTilt:Double = -0.5{didSet{setNeedsDisplay()}}
    @IBInspectable
    var color:UIColor = UIColor.blue{didSet{setNeedsDisplay()}}
    @IBInspectable
    var lineWidth :CGFloat = 5.0{didSet{setNeedsDisplay()}}
    @IBInspectable
    var scale : CGFloat = 0.90{didSet{setNeedsDisplay()}}
    
    private var skullRadius:CGFloat{
        return min(bounds.size.width, bounds.size.height) / 2 * scale
    }
    private var skullCenter:CGPoint{
        return convert(center, from: superview)
    }
    
    func changeScale(gesture:UIPinchGestureRecognizer){
        switch gesture.state {
        case .changed,.ended:
            scale *= gesture.scale
            gesture.scale = 1.0
        default:
            break
        }
    }

    override func draw(_ rect: CGRect) {
        color.set()
        pathForCircleCenteredAtPoint(midPoint: skullCenter, withRadius: skullRadius).stroke()
        pathForEye(eye: .Left).stroke()
        pathForEye(eye: .Right).stroke()
        pathForMouth().stroke()
        pathForBrow(.Left).stroke()
        pathForBrow(.Right).stroke()
    }
    
    private struct Ratios{
        static let SkullRadiusToEyeOffset:CGFloat = 3
        static let SkullRadiusToEyeRadius:CGFloat = 10
        static let SkullRadiusToMouthWidth:CGFloat = 1
        static let SkullRadiusToMouthheight:CGFloat = 3
        static let SkullRadiusToMouthOffset:CGFloat = 3
        static let SkullRadiusToBrowOffset:CGFloat = 5
    }
    
    enum Eye {
        case Left
        case Right
    }
    
    private func pathForEye(eye: Eye) -> UIBezierPath{
        let eyeRadius = skullRadius / Ratios.SkullRadiusToEyeRadius
        let eyeCenter = getEyeCenter(eye)
        
        if eyesOpen {
            return pathForCircleCenteredAtPoint(midPoint: eyeCenter, withRadius: eyeRadius)
        }
        else{
            let path = UIBezierPath()
            path.move(to: CGPoint(x: eyeCenter.x - eyeRadius, y: eyeCenter.y))
            path.addLine(to: CGPoint(x: eyeCenter.x + eyeRadius, y: eyeCenter.y))
            path.lineWidth = lineWidth
            return path
        }
    }
    
    private func pathForBrow(_ eye:Eye) ->UIBezierPath{
        var tile = eyeBrowTilt
        switch eye {
        case .Left:
            tile *= -1.0
        case .Right:
            break
        }
        var browCenter = getEyeCenter(eye)
        browCenter.y -= skullRadius / Ratios.SkullRadiusToBrowOffset
        let eyeRadius = skullRadius / Ratios.SkullRadiusToEyeRadius
        let tiltOffset = CGFloat(max(-1, min(tile, 1))) * eyeRadius / 2
        let browStart = CGPoint(x: browCenter.x - eyeRadius, y: browCenter.y - tiltOffset)
        let browEnd = CGPoint(x: browCenter.x + eyeRadius, y: browCenter.y + tiltOffset)
        let path = UIBezierPath()
        path.move(to: browStart)
        path.addLine(to: browEnd)
        path.lineWidth = lineWidth
        return path
    }
    
    private func pathForMouth() ->UIBezierPath{
        let mouthWidth = skullRadius / Ratios.SkullRadiusToMouthWidth
        let mouthHeight = skullRadius / Ratios.SkullRadiusToMouthheight
        let mouthOffset = skullRadius / Ratios.SkullRadiusToMouthOffset
        let mouthRect = CGRect(x: skullCenter.x - mouthWidth/2, y: skullCenter.y + mouthOffset, width: mouthWidth, height: mouthHeight)
        
        
        let smileOffset = CGFloat(max(-1, min(mouthCurvature, 1))) * mouthRect.height
        let start = CGPoint(x: mouthRect.minX, y: mouthRect.minY)
        let end = CGPoint(x: mouthRect.maxX, y: mouthRect.minY)
        let cp1 = CGPoint(x: mouthRect.minX + mouthRect.width / 3, y: mouthRect.minY + smileOffset)
        let cp2 = CGPoint(x: mouthRect.maxX - mouthRect.width / 3, y: mouthRect.minY + smileOffset)
        
        let path = UIBezierPath()
        path.move(to: start)
        path.addCurve(to: end, controlPoint1: cp1, controlPoint2: cp2)
        path.lineWidth = lineWidth
        return path
    }
    
    private func getEyeCenter(_ eye:Eye) ->CGPoint{
        let eyeOffset = skullRadius / Ratios.SkullRadiusToEyeOffset
        var eyeCenter = skullCenter
        eyeCenter.y -= eyeOffset
        switch eye {
        case .Left:
            eyeCenter.x -= eyeOffset
        case .Right:
            eyeCenter.x += eyeOffset
        }
        return eyeCenter
    }
    
    private func pathForCircleCenteredAtPoint(midPoint:CGPoint, withRadius radius:CGFloat) -> UIBezierPath {
        let path = UIBezierPath(arcCenter: midPoint, radius: radius, startAngle: 0.0, endAngle: CGFloat(2*Double.pi), clockwise: true)
        path.lineWidth = lineWidth
        return path
    }
}
