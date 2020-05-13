//
//  Stepper Controller.swift
//  PushMyButton
//
//  Created by Miguel Angel Sicart on 13/05/2020.
//  Copyright © 2020 playable_systems. All rights reserved.
//

import Foundation
import UIKit

class Stepper_Controller: Template_Controller
{
    //MARK: - Stepper Properties
    var satisfactionStepper: UIStepper!
    //MARK: - Stepper Label
    var stepperLabel: UILabel!
    
    //MARK: - Variables
    //FRAME
    var positionFrame: CGRect!
    //ANIMATOR
    var animator = UIViewPropertyAnimator()
    
    override func viewDidLoad()
    {
        
        super.viewDidLoad()
        
        positionFrame = CGRect(x: view.center.x - 100, y: view.center.y, width: 200, height: 50)
        
        satisfactionStepper = UIStepper(frame: CGRect(x: view.center.x - 50, y: view.center.y, width: 200, height: 50))
        satisfactionStepper.wraps = true
        satisfactionStepper.maximumValue = 10
        satisfactionStepper.minimumValue = 0
        satisfactionStepper.stepValue = 1
        satisfactionStepper.autorepeat = false
        satisfactionStepper.isContinuous = false
        satisfactionStepper.tintColor = .white
        satisfactionStepper.addTarget(self, action: #selector(stepperChange), for: .valueChanged)
        
        view.addSubview(satisfactionStepper)
        
        stepperLabel = UILabel(frame: positionFrame)
        stepperLabel.font = UIFont.preferredFont(forTextStyle: .body)
        stepperLabel.textColor = .blue
        stepperLabel.center = CGPoint(x: self.view.frame.midX, y: self.view.frame.midY - 100)
        stepperLabel.numberOfLines = 0
        stepperLabel.textAlignment = .center
        stepperLabel.text = ""
        stepperLabel.isHidden = false
        
        view.addSubview(stepperLabel)
    }
    
    //MARK: - Stepper Functions
    ////////////***********************STEPPER FUNCTIONS***********************////////////
    @objc func stepperChange(_ sender: UIStepper)
    {
        print(satisfactionStepper.value)
        switch satisfactionStepper.value
        {
        case 0:
            stepperLabel.text = "Once More"
        case 1:
            stepperLabel.text = "Just Tap"
        case 2:
            stepperLabel.text = "Warming Up"
        case 3:
            stepperLabel.text = "The Right Way"
        case 4:
            stepperLabel.text = "Halfway"
        case 5:
            stepperLabel.text = "Not Yet"
        case 6:
            stepperLabel.text = "A Bit More"
        case 7:
            stepperLabel.text = "That's More Like It"
        case 8:
            stepperLabel.text = "Getting There"
        case 9:
            stepperLabel.text = "Almost"
        case 10:
            stepperLabel.text = ""
            //HERE
            self.moveOn()
        default:
            break
        }
        if satisfactionStepper.value == 2
        {
            stepperAnimation()
        }
    }
    
    func stepperAnimation()
    {
        animator = UIViewPropertyAnimator(duration: 5, curve: .easeOut, animations: {
            self.satisfactionStepper.backgroundColor = UIColor.red
        })
        animator.startAnimation()
        animator.addCompletion { _ in
            //HERE
            self.moveOn()
        }
    }
}
