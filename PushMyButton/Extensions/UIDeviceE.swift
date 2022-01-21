//
//  UIDeviceE.swift
//  PushMyButton
//
//  Created by Miguel Angel Sicart on 18/05/2020.
//  Copyright © 2020 playable_systems. All rights reserved.
//

import Foundation
import UIKit
import AVFoundation
import AudioToolbox

extension UIDevice {
    static func vibrate() {
        AudioServicesPlaySystemSound(kSystemSoundID_Vibrate)
        AudioServicesPlaySystemSound(1109) //kSystemSoundID_Vibrate
    }
}
