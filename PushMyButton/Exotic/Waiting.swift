//
//  Waiting.swift
//  PushMyButton
//
//  Created by Miguel Angel Sicart on 18/05/2020.
//  Copyright © 2020 playable_systems. All rights reserved.
//

import Foundation
import UIKit

class Waiting: Template_Controller
{
    var pulsingButton: UIButton!
       //Instructions Label
       var instructionsLabel: UILabel!
       
       
       //timer
       var timer = Timer()
       var dimmer = Timer()
       var seconds = 600
       var dim:CGFloat = 0

       override func viewDidLoad()
       {
           super.viewDidLoad()
           self.view.backgroundColor = .black
           
           self.pulsingButton = UIButton(frame: CGRect(x: self.view.frame.midX - 50, y: self.view.frame.midY - 50, width: 100, height: 100))
           self.pulsingButton?.backgroundColor = .red
           self.pulsingButton.isUserInteractionEnabled = true
           self.pulsingButton.clipsToBounds = true
           self.pulsingButton?.layer.cornerRadius = 0.5 * pulsingButton.bounds.size.width
           self.pulsingButton.addTarget(self, action: #selector(brightenUp), for: .touchUpInside)
           self.view.addSubview(pulsingButton)

    
            dimmer = Timer.scheduledTimer(timeInterval: 0.3, target: self, selector: #selector(dimming), userInfo: nil, repeats: true)
           
           //Instructions Label
           instructionsLabel = UILabel(frame: CGRect(x: self.view.frame.midX - 75, y: self.view.frame.minY + 200, width: 150, height: 40))
           instructionsLabel.backgroundColor = .clear
           instructionsLabel.numberOfLines = 0
           instructionsLabel.font = UIFont(name: "Avenir-BlackOblique", size: 30)
           instructionsLabel.adjustsFontSizeToFitWidth = true
           instructionsLabel.textColor = .white
           instructionsLabel.textAlignment = .center
           instructionsLabel.adjustsFontSizeToFitWidth = true
           instructionsLabel.text = "Observe"
           self.view.addSubview(instructionsLabel)

       }
       
       @objc func dimming()
       {
           self.pulsingButton.pulsate()
           //self.pulsingButton.flash()
           self.pulsingButton.alpha -= 0.025
           print(self.pulsingButton.alpha)
           if(self.pulsingButton.alpha <= 0.0)
           {
               self.moveOn()
           }
//        self.moveOn()
           
       }
       
       @objc func brightenUp(sender: UIButton)
       {
           print("touched")
           self.pulsingButton.alpha = 1
       }
}
