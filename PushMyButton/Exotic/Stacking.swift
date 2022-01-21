//
//  Stacking.swift
//  PushMyButton
//
//  Created by Miguel Angel Sicart on 13/05/2020.
//  Copyright © 2020 playable_systems. All rights reserved.
//

import Foundation
import UIKit

class Stacking: Template_Controller, UICollisionBehaviorDelegate
{
    //Stacking Button
    var stackingButton: UIButton!
    
    //Stacking Button Play Variables
    var bottomLine: UIView!
    var goalLine: UIView!
    var leftLine: UIView!
    var rightLine: UIView!
    
    //Stacking Button stacking boxes
    var stackingBoxes: [UIView] = []
    var centerPoint:[CGPoint] = []
    var sizeOfSquare:CGSize = CGSize(width: 30, height: 30)
    
    //stacking Button animator
    var stackingButtonAnimator: UIDynamicAnimator!
    
    //stacking Button positions
    var leftPointX: CGFloat!
    var centerPointX: CGFloat!
    var rightPointX: CGFloat!
    var centerPointY: CGFloat!
    
    //instructions label
    var instructionsLabel: UILabel!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        view.backgroundColor = .black
        
        //Origin for the stacking boxes
        leftPointX = view.bounds.size.width/6
        centerPointX = view.bounds.size.width/2
        rightPointX = view.bounds.size.width * 0.84
        centerPointY = view.bounds.size.height - 400
        
        let leftCenterPoint = CGPoint(x: leftPointX, y: centerPointY)
        let middleCenterPoint = CGPoint(x: centerPointX, y: centerPointY)
        let rightCenterPoint = CGPoint(x:rightPointX, y: centerPointY)
        centerPoint = [leftCenterPoint,middleCenterPoint,rightCenterPoint]
        centerPoint = [leftCenterPoint, rightCenterPoint, middleCenterPoint]
        
        
        //STACKING BUTTON
        stackingButton = UIButton(frame: CGRect(x: self.view.frame.midX-100, y: self.view.frame.height - 75, width: 200, height: 50))
        stackingButton.backgroundColor = .blue
        stackingButton.setTitle("PRESS HERE", for: .normal)
        stackingButton.titleLabel?.font = UIFont(name: "Avenir-BlackOblique", size: 20)
        stackingButton.titleLabel?.textColor = .blue
        stackingButton.addTarget(self, action: #selector(stackingButtonPressed), for: .touchUpInside)
        view.addSubview(stackingButton)
        
        //BOTTOM VIEW
        bottomLine = UIView(frame: CGRect(x: 0, y: self.view.frame.height-100, width: self.view.frame.width, height: 10))
        bottomLine.backgroundColor = .blue
        view.addSubview(bottomLine)
        
        //GOAL LINE
        goalLine = UIView(frame: CGRect(x: 0, y: 120, width: self.view.frame.width, height: 10))
        goalLine.backgroundColor = .red
        view.addSubview(goalLine)
        
        //SIDE LINES
        leftLine = UIView(frame: CGRect(x: 0, y: 0, width: 1, height: self.view.frame.height))
        leftLine.backgroundColor = .lightGray
        view.addSubview(leftLine)
        rightLine = UIView(frame: CGRect(x: self.view.frame.width - 1, y: 0, width: 1, height: self.view.frame.height))
        rightLine.backgroundColor = .lightGray
        view.addSubview(rightLine)
        
        //INSTRUCTION LABEL
        instructionsLabel = UILabel(frame: CGRect(x: self.view.frame.midX - 150, y: 75, width: 300, height: 50))
        instructionsLabel.font = UIFont(name: "Avenir-BlackOblique", size: 30)
        instructionsLabel.adjustsFontSizeToFitWidth = true
        //instructionsLabel.backgroundColor = .clear
        instructionsLabel.textColor = .blue
        instructionsLabel.textAlignment = .center
        instructionsLabel.text = "Stack the boxes all the way to the top"
        view.addSubview(instructionsLabel)
        
    }

    @objc func stackingButtonPressed(sender: UIButton!)
    {
        
        //instantiate a new Box
        let newBox = UIView(frame: CGRect(x: 0, y: 0, width: sizeOfSquare.width, height: sizeOfSquare.height))
        newBox.backgroundColor = .red
        
        let randomCenterPoint = Int(arc4random()%3)
        newBox.center = centerPoint[randomCenterPoint]
        
        stackingBoxes.append(newBox)
        view.addSubview(newBox)
        
        //Animation
        stackingButtonAnimator = UIDynamicAnimator(referenceView: view)
    
        //gravity
        let gravity = UIGravityBehavior(items: stackingBoxes)
        stackingButtonAnimator.addBehavior(gravity)
        
        //collision detection
        let collision = UICollisionBehavior(items: stackingBoxes)
        collision.collisionDelegate = self
        stackingButtonAnimator.addBehavior(collision)
        
        
        //MARK: - HERE'S THE THING
        
        //density
        let boxBehavior = UIDynamicItemBehavior(items: stackingBoxes)
        boxBehavior.elasticity = 0.9
        stackingButtonAnimator.addBehavior(boxBehavior)
        
        
        //collision boundaries
        collision.addBoundary(withIdentifier: "bottomLine" as NSCopying, for: UIBezierPath(rect: bottomLine.frame))
        collision.addBoundary(withIdentifier: "goalLine" as NSCopying, for: UIBezierPath(rect: goalLine.frame))
        
        
        if stackingBoxes.count > 100
        {
            print("we have reached critical conditions")
            self.instructionsLabel.text = "Keeo going. It is possible. Don't give up"
            collision.addBoundary(withIdentifier: "leftLine" as NSCopying, for: UIBezierPath(rect: leftLine.frame))
            collision.addBoundary(withIdentifier: "rightLine" as NSCopying, for: UIBezierPath(rect: rightLine.frame))
        }
        
    }

    func collisionBehavior(_ behavior: UICollisionBehavior, beganContactFor item: UIDynamicItem, withBoundaryIdentifier identifier: NSCopying?, at p: CGPoint)
    {
        let target = identifier as! String
        
        if target == "goalLine"
        {
            self.moveOn()
        }
    }
}
