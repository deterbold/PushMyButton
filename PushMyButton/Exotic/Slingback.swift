//
//  Slingback.swift
//  PushMyButton
//
//  Created by Miguel Angel Sicart on 18/05/2020.
//  Copyright © 2020 playable_systems. All rights reserved.
//

import Foundation
import UIKit

class Slingback: Template_Controller
{
    //MARK: - Play Variables
    var patienceSteps:CGFloat = 0.0
    var count:CGFloat = 0
    
    //MARK: - Interactive Button Variables
    var interactiveButton: UIView!
    
    //MARK: - Jiggle animation
    //https://stackoverflow.com/questions/3703922/how-do-you-create-a-wiggle-animation-similar-to-iphone-deletion-animation/9753948
    let jiggleAnim = CAKeyframeAnimation(keyPath: "transform")
    
    
    //MARK: - Timer
    var timer: Timer!
    var isTimerRunning = false
    
    //MARK: - Label
    var informationLabel: UILabel!
    
    //MARK: - Animator Variables
    var animator: UIDynamicAnimator!
    var snapping: UISnapBehavior!
    
    
    //MARK: - Loading the View
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        //Things
        interactiveButton = UIView(frame: CGRect(x: view.center.x - 25, y: view.center.y - 25, width: 50, height: 50))
        interactiveButton.layer.cornerRadius = 0.5 * interactiveButton.bounds.size.width
        interactiveButton.clipsToBounds = true
        interactiveButton.backgroundColor = .red
        view.addSubview(interactiveButton)
        
        //Gesture recognizer
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(panEtCircus))
        interactiveButton.addGestureRecognizer(panGesture)
        interactiveButton.isUserInteractionEnabled = true
        
        //Animations
        animator = UIDynamicAnimator(referenceView: view)
        snapping = UISnapBehavior(item: interactiveButton, snapTo: view.center)

        //Label
        informationLabel = UILabel(frame: CGRect(x: 0, y: view.center.y - 300, width: view.frame.width, height: 50))
        informationLabel = UILabel(frame: CGRect(x: view.bounds.midX - (view.frame.width/2)/2, y: view.bounds.midY - 300, width: view.frame.width/2, height: 50))
        informationLabel.backgroundColor = .clear
        informationLabel.textAlignment = .center
        informationLabel.font = UIFont(name: "Avenir-BlackOblique", size: 30)
        informationLabel.adjustsFontSizeToFitWidth = true
        informationLabel.numberOfLines = 0
        informationLabel.textColor = .blue
        informationLabel.text = "drag down"
        view.addSubview(informationLabel)
        
        //initializing the jiggle animation
        jiggleAnim.values = [NSValue(caTransform3D: CATransform3DMakeRotation(0.04, 0.0, 0.0, 1.0)), NSValue(caTransform3D: CATransform3DMakeRotation(-0.4, 0.0, 0.0, 1.0))]
        jiggleAnim.autoreverses = true
        jiggleAnim.duration = 0.09
        jiggleAnim.repeatCount = Float.infinity
    }

    @objc func panEtCircus(recognizer: UIPanGestureRecognizer)
    {
        switch recognizer.state
        {
        case.began:
            animator.removeBehavior(snapping)
            count = 0
            timer = Timer(timeInterval: 1, target: self, selector: #selector(timerCalls), userInfo: nil, repeats: true)
            RunLoop.current.add(timer, forMode: .common)
            
        case .changed:
            let translation = recognizer.translation(in: view)
            interactiveButton.center = CGPoint(x: interactiveButton.center.x + translation.x, y: interactiveButton.center.y + translation.y)
            recognizer.setTranslation(.zero, in: view)
            let absDistanceY = abs(self.view.center.y - interactiveButton.center.y)
            
           if absDistanceY >= 200
            {
                count += absDistanceY/1000
                jiggleAnim.values = [NSValue(caTransform3D: CATransform3DMakeRotation(0.09 * (absDistanceY/100) * (count * 0.1), 0.0, 0.0, 1.0)), NSValue(caTransform3D: CATransform3DMakeRotation(-0.09  * (absDistanceY/100) * (count * 0.1), 0.0, 0.0, 1.0))]
                interactiveButton.layer.add(jiggleAnim, forKey: "transform")
                UIDevice.vibrate()
            }
            
        case .ended:
            informationLabel.text = "try again"
            timer?.invalidate()
            count = 0
            timer?.invalidate()
            animator.addBehavior(snapping)
            patienceSteps = 0
            interactiveButton.layer.removeAllAnimations()
            
        case .failed:
            animator.addBehavior(snapping)
        default:
            break
        }
    }
    
    @objc func timerCalls()
    {
        count += 2
        switch count
        {
        case 0..<10:
            informationLabel.text = "keep it there"
            print("waiting")
        case 10..<15:
            informationLabel.text = "it is working"
            print("getting better")
        case 15..<30:
            informationLabel.text = "faster if you move"
            print("it's nice that")
        case 30..<40:
            informationLabel.text = "almost"
            print("getting there")
        case 40..<50:
            informationLabel.text = "just a little longer"
            print("just a little longer")
        case 50..<155:
            removeEverything()
            print("did it!")
        default:
            print("emmmmm")
        }
        print("count: " ,  count)
    }
    
    func removeEverything()
    {
        informationLabel.text = "done"
        self.moveOn()
    }
}
