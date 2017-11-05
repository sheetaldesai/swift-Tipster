//
//  ViewController.swift
//  TipCalculator
//
//  Created by Sheetal Desai on 11/1/17.
//  Copyright © 2017 Sheetal Desai. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var lblTotalAmt: UILabel!
    
    @IBOutlet var lblPercColl: [UILabel]!
    
    
    @IBOutlet var lblTotAmtColl: [UILabel]!
    
    @IBOutlet var lblinAmtColl: [UILabel]!
    
    @IBOutlet weak var sliderTip: UISlider!
    @IBOutlet weak var sliderGroup: UISlider!
    
    var total:Float = Float()
    var dotPressed = false
    var numDigitsAfterDecimal = 0
    var dotButton:UIButton = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setDefaults()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func numPressed(_ sender: UIButton) {
        
        if lblTotalAmt.text == "0" {
            lblTotalAmt.text = ""
        }
        
        var str = ""
        if sender.tag == 11 {
            if lblTotalAmt.text != "" {
                str = "."
            }
            dotPressed = true
            dotButton = sender
            dotButton.isEnabled = false
        }
        else if sender.tag == 10 {
            lblTotalAmt.text = ""
            dotPressed = false
            dotButton.isEnabled = true
            numDigitsAfterDecimal = 0
        }
        else {
            str = String(sender.tag)
            if (dotPressed) {
                if numDigitsAfterDecimal == 2 {
                    return
                }
                else {
                    numDigitsAfterDecimal += 1
                }
            }
        }
        
        if var amt = lblTotalAmt.text {
            print("amt \(amt)")
            print("str \(str)")
            amt += str
            lblTotalAmt.text = amt
        }
        
        
        if let amtTxt = lblTotalAmt.text, let amt = Float(amtTxt) {
            print(type(of: amt))
//            setPercentile(tip: 2.0, amt: 3.0, grp: 2)
            setPercentile(tip:Float(sliderTip.value), amt:amt, grp:Int(sliderGroup.value))
        }
        
        
        
    }
    
    func setPercentile(tip:Float, amt:Float, grp:Int) {
        print("setPercentile tip=\(tip) amt=\(amt) grp=\(grp)")
        lblPercColl[0].text = String(tip*100) + "%"
        lblPercColl[1].text = String((tip+0.05)*100) + "%"
        lblPercColl[2].text = String((tip+0.1)*100) + "%"
        
        if (amt > 0) {
            var tip1 = amt * tip
            var tip2 = amt * (tip + 0.05)
            var tip3 = amt * (tip + 0.1)
            lblinAmtColl[0].text = String(tip1/Float(grp))
            lblinAmtColl[1].text = String(tip2/Float(grp))
            lblinAmtColl[2].text = String(tip3/Float(grp))
            
            lblTotAmtColl[0].text = String(amt + tip1)
            lblTotAmtColl[1].text = String(amt + tip2)
            lblTotAmtColl[2].text = String(amt + tip3)
            
        }
    }
    
    func setDefaults() {
        lblTotalAmt.text = "0"
        sliderTip.minimumValue = 0.01
        sliderTip.maximumValue = 0.4
        sliderTip.value = 0.05
        sliderGroup.minimumValue = 1
        sliderGroup.value = 2
        sliderGroup.maximumValue = 1000
        setPercentile(tip: sliderTip.value, amt:0, grp:Int(sliderGroup.value))
        
        for lbl in lblinAmtColl {
            lbl.text = ""
        }
        
        for lbl in lblTotAmtColl {
            lbl.text = ""
        }
    }
    
    
    
    @IBAction func sliderTipChanged(_ sender: UISlider) {
        var totalAmt:Float = 0
        if let amt = lblTotalAmt.text {
            totalAmt = Float(amt)!
        }
        setPercentile(tip: Float(sliderTip.value), amt: totalAmt, grp: Int(sliderGroup.value))
    }
    
    
}

