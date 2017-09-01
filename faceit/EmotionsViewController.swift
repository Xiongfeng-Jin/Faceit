//
//  EmotionsViewController.swift
//  faceit
//
//  Created by Jin on 2/20/17.
//  Copyright © 2017 Jin. All rights reserved.
//

import UIKit

class EmotionsViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }


    private let emotionFaces = [
        "angry":FacialExpression(eyes:.Closed,eyeBrows:.Furrowed,mouth:.Frown),
        "happy":FacialExpression(eyes:.Open,eyeBrows:.Normal,mouth:.Smile),
        "worried":FacialExpression(eyes:.Open,eyeBrows:.Relaxed,mouth:.Smirk),
        "mischievious":FacialExpression(eyes:.Open,eyeBrows:.Furrowed,mouth:.Grin)
    ]
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        var destinationvc = segue.destination
        if let navcon = destinationvc as? UINavigationController{
            destinationvc = navcon.visibleViewController ?? destinationvc
        }
        if let facevc = destinationvc as? FaceViewController {
            if let identifier = segue.identifier{
                if let expression = emotionFaces[identifier] {
                    facevc.expression = expression
                    if let buttom = sender as? UIButton{
                        facevc.navigationItem.title = buttom.currentTitle
                    }
                }
            }
        }
    }

}
