//
//  Switch Controller.swift
//  PushMyButton
//
//  Created by Miguel Angel Sicart on 07/05/2020.
//  Copyright © 2020 playable_systems. All rights reserved.
//

import UIKit

class Switch_Controller: UIViewController
{
//
    
//
//    override func viewDidLoad()
//    {
//        super.viewDidLoad()
//
//        //MARK: Switch
//        basicSwitch = UISwitch(frame: CGRect(x: self.view.frame.midX - 25, y: 100, width: 50, height: 50))
//        basicSwitch.addTarget(self, action: #selector(moveOn), for: .valueChanged)
//        basicSwitch.setOn(false, animated: true)
//        self.view.addSubview(basicSwitch)
//        self.basicSwitch.isHidden = false
//    }
//
//    @objc func moveOn()
//    {
//        basicSwitch.setOn(false, animated: true)
//        for v in view.subviews{
//                   v.removeFromSuperview()
//               }
//        let secondView = self.storyboard?.instantiateViewController(withIdentifier: "Main_Controller")
//        self.present(secondView!, animated: true, completion: nil)
//    }
    //MARK: BASIC SWITCH
    var basicSwitch: UISwitch!
    
    
    //MARK: Debug Variables
    var debug:Bool = false
    var debugLabel: UILabel!
    var secondButton: UIButton!


    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        //MARK: Switch
        basicSwitch = UISwitch(frame: CGRect(x: self.view.frame.midX - 25, y: view.frame.midY - 25, width: 50, height: 50))
        basicSwitch.addTarget(self, action: #selector(moveOn), for: .valueChanged)
        basicSwitch.setOn(false, animated: true)
        self.view.addSubview(basicSwitch)
        self.basicSwitch.isHidden = false
        
        //MARK: - DEBUG UI
        if debug
        {
            debugLabel = UILabel(frame: CGRect(x: view.frame.midX - 50, y: view.frame.midY-300, width: 100, height: 50))
          debugLabel.backgroundColor = .black
          debugLabel.textColor = .white
          debugLabel.adjustsFontSizeToFitWidth = true
          debugLabel.text = "Switch Controller"
          view.addSubview(debugLabel)
                       
           secondButton = UIButton(frame: CGRect(x: view.frame.midX - 50, y: view.frame.midY - 250, width: 100, height: 50))
           secondButton.backgroundColor = .black
           secondButton.titleLabel?.textColor = .red
           secondButton.setTitle("BACK", for: .normal)
           secondButton.addTarget(self, action: #selector(wehavetogoback), for: .touchUpInside)
           view.addSubview(secondButton)
        }
    }
    
    @objc func moveOn(_ sender: UISwitch)
    {
        basicSwitch.setOn(true, animated: true)
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

    @objc func wehavetogoback(sender: UIButton)
       {
           print("Pressed")
           let firstView = self.storyboard?.instantiateViewController(withIdentifier: "Hub_Scene")
           self.present(firstView!, animated: true, completion: nil)
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
