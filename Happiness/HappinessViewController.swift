//
//  HappinessViewController.swift
//  Happiness
//
//  Created by Ingenieria y Software on 20/10/15.
//  Copyright © 2015 Ingenieria y Software. All rights reserved.
//

import UIKit

class HappinessViewController: UIViewController, FaceViewDataSource {
    
    @IBOutlet weak var faceView: FaceView!
        {
        didSet{
            faceView.dataSource = self
            faceView.addGestureRecognizer(UIPinchGestureRecognizer(target:faceView, action: "scale:"))
            faceView.addGestureRecognizer(UIPanGestureRecognizer(target:self, action: "changeHapiness:"))
        }
    }
    
    var happiness: Int = 100{
        didSet{
            happiness = min(max(happiness, 0), 100)
            print("Happiness = \(happiness)")
            updateUI()
        }
    }
    private struct Constants
    {
        static let HapinessGestureScale: CGFloat = 4.0
    }
    func changeHapiness(sender: UIPanGestureRecognizer){
        switch sender.state{
        case .Ended:
            fallthrough
        case .Changed:
            let translation = sender.translationInView(faceView)
            let happinessChange = -Int(translation.y/Constants.HapinessGestureScale)
            if happinessChange != 0{
                happiness += happinessChange
                sender.setTranslation(CGPointZero, inView: faceView)
            }
        default: break
        }
    }
    func updateUI()
    {
        faceView?.setNeedsDisplay()
        title = "\(happiness)"
    }
    func smilinessForFaceView(sender: FaceView) -> Double? {
        return Double((happiness-50))/50.0
    }
}
