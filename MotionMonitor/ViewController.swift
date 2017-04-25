//
//  ViewController.swift
//  MotionMonitor
//
//  Created by 黄启明 on 2017/4/25.
//  Copyright © 2017年 黄启明. All rights reserved.
//

import UIKit
import CoreMotion

class ViewController: UIViewController {
    
    @IBOutlet weak var gyroscopleLabel: UILabel!//陀螺仪
    @IBOutlet weak var accelerometerLabel: UILabel!//加速计
    @IBOutlet weak var attitudeLabel: UILabel!//方位
    
    private let motionManager = CMMotionManager()
    private let queue = OperationQueue()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        gyroscopleLabel.numberOfLines = 0
        gyroscopleLabel.sizeToFit()
        accelerometerLabel.numberOfLines = 0
        accelerometerLabel.sizeToFit()
        attitudeLabel.numberOfLines = 0
        attitudeLabel.sizeToFit()

        if motionManager.isDeviceMotionAvailable {
            motionManager.deviceMotionUpdateInterval = 0.1
            motionManager.startDeviceMotionUpdates(to: queue, withHandler: { (motion, error) in
                
                let rotationRate = motion?.rotationRate
                let gravity = motion?.gravity
                let userAcc = motion?.userAcceleration
                let attitude = motion?.attitude
                
                let rotationRateX =  NSString(format: "x: %.2f\n", rotationRate?.x ?? 0) as String
                let rotationRateY =  NSString(format: "y: %.2f\n", rotationRate?.y ?? 0) as String
                let rotationRateZ =  NSString(format: "z: %.2f\n", rotationRate?.z ?? 0) as String
                let gyroscopleText = "Rotation Rate: \n..........\n" + rotationRateX + rotationRateY + rotationRateZ
                
                let gravityX =  NSString(format: "Gravity x: %.2f\n", gravity?.x ?? 0) as String
                let userX =  NSString(format: "User x: %.2f\n", userAcc?.x ?? 0) as String
                let gravityY =  NSString(format: "Gravity y: %.2f\n", gravity?.y ?? 0) as String
                let userY =  NSString(format: "User y: %.2f\n", userAcc?.x ?? 0) as String
                let gravityZ =  NSString(format: "Gravity z: %.2f\n", gravity?.z ?? 0) as String
                let userZ =  NSString(format: "User z: %.2f\n", userAcc?.x ?? 0) as String
                let accelerometerText = "Acceleration: \n..........\n" + gravityX +  userX + gravityY +  userY + gravityZ +  userZ
                
                let roll =  NSString(format: "Roll z: %.2f\n", attitude?.roll ?? 0) as String
                let pitch =  NSString(format: "Pitch z: %.2f\n", attitude?.pitch ?? 0) as String
                let yaw =  NSString(format: "Yaw z: %.2f\n", attitude?.yaw ?? 0) as String
                let attitudeText = "Attitude: \n..........\n" + roll + pitch + yaw
                
                DispatchQueue.main.async {
                    self.gyroscopleLabel.text = gyroscopleText
                    self.accelerometerLabel.text = accelerometerText
                    self.attitudeLabel.text = attitudeText
                }
            })
        }
    
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func motionBegan(_ motion: UIEventSubtype, with event: UIEvent?) {
        print("motion...")
    }
}

