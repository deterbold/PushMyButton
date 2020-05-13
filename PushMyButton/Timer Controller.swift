//
//  ViewController.swift
//  PushMyButton
//
//  Created by Miguel Angel Sicart on 05/05/2020.
//  Copyright © 2020 playable_systems. All rights reserved.
//

import UIKit
import UserNotifications

class Timer_Controller: UIViewController, UNUserNotificationCenterDelegate
{
//    //MARK: INFORMATION LABEL
//    var informationLabel: UILabel!
//
//    override func viewDidLoad()
//    {
//        super.viewDidLoad()
//
//        //MARK: Information Label
//        informationLabel = UILabel(frame: CGRect(x: self.view.frame.midX - 100, y: self.view.frame.midY - 50, width: 200, height: 100))
//        informationLabel.adjustsFontSizeToFitWidth = true
//        informationLabel.backgroundColor = .clear
//        informationLabel.textColor = .black
//        informationLabel.text = ""
//        self.view.addSubview(informationLabel)
//
//        registerLocal()
//        scheduleLocal()
//
//    }
//
//    func registerLocal()
//    {
//        let center = UNUserNotificationCenter.current()
//        center.requestAuthorization(options: [.alert, .badge, .sound]) { (granted, error) in
//            if granted {
//                print("Yay!")
//            } else {
//                print("D'oh")
//            }
//        }
//    }
//
//    @objc func scheduleLocal()
//    {
//        registerCategories()
//
//        let center = UNUserNotificationCenter.current()
//        center.removeAllPendingNotificationRequests()
//
//
//        let content = UNMutableNotificationContent()
//        content.title = "Late wake up call"
//        content.body = "The early bird catches the worm, but the second mouse gets the cheese."
//        content.categoryIdentifier = "alarm"
//        content.userInfo = ["customData": "fizzbuzz"]
//        content.sound = UNNotificationSound.default
//
//        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 6, repeats: false)
//
//        let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
//        center.add(request)
//
//    }
//
//    func registerCategories() {
//        print("called")
//        let center = UNUserNotificationCenter.current()
//        center.delegate = self
//
//        let show = UNNotificationAction(identifier: "show", title: "Tell me more…", options: .foreground)
//        let category = UNNotificationCategory(identifier: "alarm", actions: [show], intentIdentifiers: [])
//
//        center.setNotificationCategories([category])
//    }
//
//
//   func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
//        // pull out the buried userInfo dictionary
//        let userInfo = response.notification.request.content.userInfo
//
//        if let customData = userInfo["customData"] as? String {
//            print("Custom data received: \(customData)")
//
//            switch response.actionIdentifier {
//            case UNNotificationDefaultActionIdentifier:
//                // the user swiped to unlock
//                print("Default identifier")
//
//            case "show":
//                // the user tapped our "show more info…" button
//                print("Show more information…")
//
//            default:
//                break
//            }
//        }
//
//        // you must call the completion handler when you're done
//        completionHandler()
//    }
//
//    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
//
//    }
    //MARK: DEBUG
    var debugLabel: UILabel!
    var secondButton: UIButton!

       override func viewDidLoad()
       {
           super.viewDidLoad()
        
            debugLabel = UILabel(frame: CGRect(x: view.frame.midX - 50, y: view.frame.midY-25, width: 100, height: 50))
           debugLabel.backgroundColor = .black
           debugLabel.textColor = .white
           debugLabel.adjustsFontSizeToFitWidth = true
           debugLabel.text = "Timer Controller"
           view.addSubview(debugLabel)
        
        secondButton = UIButton(frame: CGRect(x: view.frame.midX - 50, y: view.frame.midY - 100, width: 100, height: 50))
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


