//
//  Hub Controller.swift
//  PushMyButton
//
//  Created by Miguel Angel Sicart on 07/05/2020.
//  Copyright © 2020 playable_systems. All rights reserved.
//

import UIKit

class Hub_Controller: UIViewController
{
    
    //MARK: Array of IDs
    var storyboardIDs: [String] = []
    
    override func viewDidAppear(_ animated: Bool)
    {
//        let vc = UIViewController()
//        vc.modalPresentationStyle = .fullScreen //or .overFullScreen for transparency
//        self.present(vc, animated: true, completion: nil)
        
        //***//
        storyboardIDs = ["Timer_Scene", "Switch_Scene", "Button_Scene", "Terraces_Scene"]
        let randomChoice = Int(arc4random_uniform(UInt32(storyboardIDs.count)))
        //print(storyboardIDs[randomChoice])
        moveOn(choice: storyboardIDs[randomChoice])
    }

    override func viewDidLoad()
    {
        super.viewDidLoad()
//        storyboardIDs = ["Timer_Scene", "Switch_Scene", "Button_Scene"]
//        let randomChoice = Int(arc4random_uniform(UInt32(storyboardIDs.count)))
//        //print(storyboardIDs[randomChoice])
//        moveOn(choice: storyboardIDs[randomChoice])
    }
    

    func moveOn(choice: String)
   {
    print(choice)
    
    let secondView = (self.storyboard?.instantiateViewController(withIdentifier: choice))!
    secondView.modalPresentationStyle = .fullScreen
    present(secondView, animated: true, completion: nil)
    
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
