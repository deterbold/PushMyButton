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
    //Note: this is how this project works: there's a list of different storyboards
    //each is a button type
    //they are all stored in this array
    //and this entry storyboard is the one that triggers them
    var storyboardIDs: [String] = []
    
    override func viewDidAppear(_ animated: Bool)
    {
//        let vc = UIViewController()
//        vc.modalPresentationStyle = .fullScreen //or .overFullScreen for transparency
//        self.present(vc, animated: true, completion: nil)
        
        //***//
        //I populate the storyboards
        //these are named in the Storyboard ID in the main.storyboard
        storyboardIDs = ["Timer_Scene", "Switch_Scene", "Button_Scene", "Stepper_Scene", "Terraces_Scene", "Slider_Scene", "Stacking_Scene", "Slingback_Scene", "Waiting_Scene"]
        //I choose one at random
        let randomChoice = Int(arc4random_uniform(UInt32(storyboardIDs.count)))
        print(storyboardIDs[randomChoice])
        //I move to it
        //notice the debug
        //moveOn(choice: storyboardIDs[randomChoice])
        moveOn(choice: "Terraces_Scene"   )
    }

    override func viewDidLoad()
    {
        super.viewDidLoad()

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
