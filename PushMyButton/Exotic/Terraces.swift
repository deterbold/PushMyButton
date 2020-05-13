//
//  Terraces.swift
//  PushMyButton
//
//  Created by Miguel Angel Sicart on 12/05/2020.
//  Copyright © 2020 playable_systems. All rights reserved.
//

import Foundation
import UIKit

class Terraces: Template_Controller, UICollisionBehaviorDelegate
{
    //Label Array
   var terraceLabels = [UILabel]()
   
   //Labels
   var barrierLabel: UILabel!
   
   //Goal Line
   var goalLine: UIView!
   
   //Switch
   var finalSwitch: UISwitch!
   
   //Instructions Label
   var instructionsLabel: UILabel!
   
   //Animator
   var buttonGameAnimator: UIDynamicAnimator!
   
   //Physics
   var gravity: UIGravityBehavior!
   var dynamics: UIDynamicItemBehavior!
   var collider: UICollisionBehavior!
   var swing: UIAttachmentBehavior!
   var push: UIPushBehavior!
   var snap: UISnapBehavior!
   
   //Button
   var moveableButton: UIButton!
   
   //Cargo Label
   var cargo: UILabel!
   
   
   var firstContact = false
    
    override func viewDidLoad()
    {
        //Setup
        super.viewDidLoad()
        //debugging(levelName: "Terraces")
        
        //Animator
        buttonGameAnimator = UIDynamicAnimator(referenceView: view)
        
        //Goal Line
        goalLine = UIView(frame: CGRect(x: 0, y: self.view.frame.height - 60, width: self.view.frame.width, height: 5))
        goalLine.backgroundColor = .red
        view.addSubview(goalLine)
        
        //Switch
        finalSwitch = UISwitch(frame: CGRect(x: self.view.frame.midX - 25, y: self.view.frame.height - 50, width: 50, height: 50))
        self.view.addSubview(finalSwitch)
        
        //Instructions Label
        instructionsLabel = UILabel(frame: CGRect(x: 0, y: self.view.frame.minY + 50, width: self.view.frame.width, height: 40))
        instructionsLabel.backgroundColor = .black
        instructionsLabel.numberOfLines = 0
        instructionsLabel.textColor = .white
        instructionsLabel.textAlignment = .center
        instructionsLabel.adjustsFontSizeToFitWidth = true
        instructionsLabel.text = "Press the Button to reach the bottom of the screen."
        self.view.addSubview(instructionsLabel)
        
        //Instantiating the Labels
        for n in 0...2
        {
            switch n
            {
            case 0:
                print("case 0")
                let terraceLabel = UILabel(frame: CGRect(x: 0, y: self.goalLine.frame.minY - 100, width: self.view.frame.width/2, height: 20))
                terraceLabel.backgroundColor = .darkGray
                terraceLabel.textColor = .darkGray
                terraceLabel.textAlignment = .center
                terraceLabel.text = "Terrace nr. \(n)"
                terraceLabels.append(terraceLabel)
                self.view.addSubview(terraceLabel)
                
            case 1:
                let terraceLabel = UILabel(frame: CGRect(x: self.view.frame.width - self.view.frame.width/2, y: self.view.frame.midY + 25, width: self.view.frame.width/2, height: 20))
                terraceLabel.backgroundColor = .darkGray
                terraceLabel.textColor = .darkGray
                terraceLabel.textAlignment = .center
                terraceLabel.text = "Terrace nr. \(n)"
                terraceLabels.append(terraceLabel)
                self.view.addSubview(terraceLabel)
                
            case 2:
                let terraceLabel = UILabel(frame: CGRect(x: 0, y: self.view.frame.width/2 + 50
                    , width: UIScreen.main.bounds.width/2, height: 20))
                terraceLabel.backgroundColor = .darkGray
                terraceLabel.textColor = .darkGray
                terraceLabel.textAlignment = .center
                terraceLabel.text = "Terrace nr. \(n)"
                terraceLabels.append(terraceLabel)
                self.view.addSubview(terraceLabel)
            
            default:
                break
            }
        }
        

        //Button
        
        moveableButton = UIButton(frame: CGRect(x: self.view.frame.midX, y: 100, width: 50, height: 50))
        moveableButton.layer.cornerRadius = 0.5 * moveableButton.bounds.size.width
        moveableButton.clipsToBounds = true
        moveableButton.backgroundColor = .red
        //moveableButton.setTitle("Button", for: .normal)
        moveableButton.addTarget(self, action: #selector(buttonPressed), for: .touchUpInside)
        self.view.addSubview(moveableButton)
        
        //Cargo Label
        cargo = UILabel(frame: CGRect(x: self.view.frame.midX - 80, y: 0, width: 150, height: 50))
        cargo.backgroundColor = .orange
        cargo.textColor = .black
        cargo.textAlignment = .center
        cargo.text = "Cargo"
        self.view.addSubview(cargo)
        
        
        //MARK: - PHYSICS
        
        //gravity
        gravity = UIGravityBehavior(items: [moveableButton, cargo])
        gravity.magnitude = 0.2
        buttonGameAnimator.addBehavior(gravity)
        
        //elasticity
        dynamics = UIDynamicItemBehavior(items: [moveableButton])
        dynamics.density = 1
        dynamics.elasticity = 0.5
        buttonGameAnimator.addBehavior(dynamics)
        
        //collisions
        collider = UICollisionBehavior(items: [moveableButton,cargo])
        collider.collisionDelegate = self
        collider.translatesReferenceBoundsIntoBoundary = true
        collider.addBoundary(withIdentifier: "goalLine" as NSString, for: UIBezierPath(rect: goalLine.frame))
        
        for item in terraceLabels
        {
            collider.addBoundary(withIdentifier: item.text! as NSString, for: UIBezierPath(rect: item.frame))
        }
        
        buttonGameAnimator.addBehavior(collider)
        
        //swing
        swing = UIAttachmentBehavior(item: cargo, attachedTo: moveableButton)
        buttonGameAnimator.addBehavior(swing)
        
        //push
        push = UIPushBehavior(items: [cargo], mode: .instantaneous)
        push.magnitude = 0.3
//        push.pushDirection = CGVector(dx: 0.2, dy: -1)
        buttonGameAnimator.addBehavior(push)
        push.active = false
     
    }
        
    @objc func buttonPressed(sender: UIButton)
    {
        if cargo.frame.midX < self.view.frame.midX
        {
            push.pushDirection = CGVector(dx: 0.1, dy: -1)
        }
       else
       {
            push.pushDirection = CGVector(dx: -0.1, dy: -1)
       }
        push.active = true
    }
        
    //MARK: - Collision Delegation
    
    func collisionBehavior(_ behavior: UICollisionBehavior, beganContactFor item: UIDynamicItem, withBoundaryIdentifier identifier: NSCopying?, at p: CGPoint)
    {
        if identifier != nil
        {
            if identifier as! String == "goalLine"
            {
                finalSwitch.isOn = true
                moveOn()
            }
        }
    }
}
