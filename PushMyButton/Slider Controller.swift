//
//  Slider Controller.swift
//  PushMyButton
//
//  Created by Miguel Angel Sicart on 13/05/2020.
//  Copyright © 2020 playable_systems. All rights reserved.
//

import Foundation
import UIKit

class Slider_Controller: Template_Controller
{
    //MARK: - Slider Properties
    var satisfactionSlider: UISlider!
    
    //MARK: - Frame & Label
    var positionFrame: CGRect!
    var sliderLabel: UILabel!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        positionFrame = CGRect(x: view.center.x - 100, y: view.center.y, width: 200, height: 50)
        
        satisfactionSlider = UISlider(frame: positionFrame)
        satisfactionSlider.minimumValue = 0
        satisfactionSlider.maximumValue = 100
        satisfactionSlider.isContinuous = true
        satisfactionSlider.tintColor = .red
        satisfactionSlider.addTarget(self, action: #selector(sliderValueChange), for: .valueChanged)
        
        sliderLabel = UILabel(frame: positionFrame)
        sliderLabel.font = UIFont(name: "Avenir-BlackOblique", size: 30)
        sliderLabel.adjustsFontSizeToFitWidth = true
        sliderLabel.textColor = .blue
        sliderLabel.center = CGPoint(x: self.view.frame.midX, y: self.view.frame.midY - 100)
        sliderLabel.numberOfLines = 0
        sliderLabel.textAlignment = .center
        sliderLabel.text = ""
        sliderLabel.isHidden = false
        
        view.addSubview(satisfactionSlider)
        view.addSubview(sliderLabel)
    }
    
    @objc func sliderValueChange(_ sender: UISlider)
       {
           print(satisfactionSlider.value)
           if satisfactionSlider.value >= 0 && satisfactionSlider.value <= 30
           {
               sliderLabel.text = "Not Yet"
           }
           else if satisfactionSlider.value >= 30 && satisfactionSlider.value <= 50
           {
               sliderLabel.text = "A Bit More"
           }
           else if satisfactionSlider.value >= 50 && satisfactionSlider.value <= 80
           {
               sliderLabel.text = "Getting There"
           }
           else if satisfactionSlider.value >= 80 && satisfactionSlider.value <= 99
           {
               sliderLabel.text = "Almost"
           }
           else if satisfactionSlider.value == 100
           {
               sliderLabel.text = "Done"
            self.moveOn()
           }
       }
}
