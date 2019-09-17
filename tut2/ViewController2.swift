//
//  ViewController2.swift
//  tut2
//
//  Created by LEUNG Yuen Ming on 17/9/2019.
//  Copyright © 2019 KooKi. All rights reserved.
//

import UIKit

class ViewController2: UIViewController {
//
//    @IBOutlet weak var weight: UITextField!
//    @IBOutlet weak var height: UITextField!
//
//    @IBOutlet weak var resultLabel: UILabel!
    
    @IBOutlet weak var weight: UITextField!
    
    @IBOutlet weak var height: UITextField!
    
    @IBOutlet weak var ResultLable: UILabel!
    
    @IBAction func calBtn(_ sender: UIButton) {
        let weightVar = weight.text ?? "0"
        let weightVarInt = Double(weightVar) ?? 0
        print(weightVarInt)


        let heightVar = height.text ?? "0"
        let heightVarInt = Double(heightVar) ?? 0
        print(heightVarInt)

        let result = weightVarInt / (heightVarInt * heightVarInt)
        
        print(result)

        ResultLable.text = "Your BMI = " + String (format: "%.2f",result)
    }
    //
//    @IBAction func calBtn(_ sender: Any) {
//                let weightVar = weight.text ?? "0"
//                let weightVarInt = Int(weightVar) ?? 0
//
//
//                let heightVar = height.text ?? "0"
//                let heightVarInt = Int(heightVar) ?? 0
//
//                var result = weightVarInt + heightVarInt
//
//                resultLabel.text = String (result)
//    }
//
}
