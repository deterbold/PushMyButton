//
//  Template Controller.swift
//  PushMyButton
//
//  Created by Miguel Angel Sicart on 12/05/2020.
//  Copyright © 2020 playable_systems. All rights reserved.
//

import UIKit

class Template_Controller: UIViewController
{
     //MARK: - Debug Variables
     var debug:Bool = true
    var debugLabel: UILabel!
    var secondButton: UIButton!


     override func viewDidLoad()
     {
         super.viewDidLoad()
         
     }
    
    func debugging(levelName:String)
    {
        debugLabel = UILabel(frame: CGRect(x: self.view.frame.midX - 50, y: view.frame.midY-300, width: 100, height: 50))
        debugLabel.backgroundColor = .black
        debugLabel.textColor = .white
        debugLabel.adjustsFontSizeToFitWidth = true
        debugLabel.text = levelName
        view.addSubview(debugLabel)
         
         secondButton = UIButton(frame: CGRect(x: view.frame.midX - 50, y: view.frame.midY - 250, width: 100, height: 50))
         secondButton.backgroundColor = .black
         secondButton.titleLabel?.textColor = .red
         secondButton.setTitle("BACK", for: .normal)
         secondButton.addTarget(self, action: #selector(wehavetogoback), for: .touchUpInside)
         view.addSubview(secondButton)
    }

     @objc func wehavetogoback(sender: UIButton)
     {
         print("Pressed")
         let firstView = self.storyboard?.instantiateViewController(withIdentifier: "Hub_Scene")
         firstView?.modalPresentationStyle = .fullScreen
         self.present(firstView!, animated: true, completion: nil)
     }
     
     @objc func moveOn()
     {
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) //https://www.hackingwithswift.com/articles/117/the-ultimate-guide-to-timer
        {
            for v in self.view.subviews
            {
                v.removeFromSuperview()
            }
            let secondView = self.storyboard?.instantiateViewController(withIdentifier: "Timer_Scene")
            secondView?.modalPresentationStyle = .fullScreen
            self.present(secondView!, animated: true, completion: nil)
        }
        
    }
     override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
         super.traitCollectionDidChange(previousTraitCollection)

         if #available(iOS 13.0, *) {
             if self.traitCollection.hasDifferentColorAppearance(comparedTo: previousTraitCollection) {
                 if traitCollection.userInterfaceStyle == .dark {
                     self.view.backgroundColor = .black
                 }
                 else {
                     self.view.backgroundColor = .white
                 }
             }
         } else {
             self.view.backgroundColor = .black
         }
     }
}
