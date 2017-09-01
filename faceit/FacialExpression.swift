//
//  FacialExpression.swift
//  faceit
//
//  Created by Jin on 2/20/17.
//  Copyright © 2017 Jin. All rights reserved.
//

import Foundation

struct FacialExpression {
    enum Eyes:Int {
        case Open
        case Closed
        case Squinting
    }
    
    enum EyeBrows:Int {
        case Relaxed
        case Normal
        case Furrowed
        
        func moreRelaxedbrow() -> EyeBrows {
            return EyeBrows(rawValue: rawValue - 1) ?? .Relaxed
        }
        func moreFurrowedBrow() -> EyeBrows {
            return EyeBrows(rawValue: rawValue + 1) ?? .Furrowed
        }
    }

    enum Mouth:Int {
        case Frown
        case Smirk
        case Neutral
        case Grin
        case Smile
        
        func sadderMouth() -> Mouth {
            return Mouth(rawValue: rawValue - 1) ?? .Frown
        }
        
        func happierMouth() -> Mouth {
            return Mouth(rawValue: rawValue + 1) ?? .Smile
        }
    }
    
    var eyes:Eyes
    var eyeBrows:EyeBrows
    var mouth:Mouth
}
