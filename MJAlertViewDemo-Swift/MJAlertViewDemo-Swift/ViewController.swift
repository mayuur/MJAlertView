//
//  ViewController.swift
//  MJAlertViewDemo-Swift
//
//  Created by Jason.Chengzi on 7/15/16.
//  Copyright © 2016 Jason. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func showSuccess(sender: AnyObject) {
        UIView.makeSuccessNotificationWithText("Success Color")
    }
    
    @IBAction func showError(sender: AnyObject) {
        UIView.makeErrorNotificationWithText("Error Color")
    }
    
    @IBAction func showWarn(sender: AnyObject) {
        UIView.makeWarnNotificationWithText("Warn Color")
    }
    
    @IBAction func showInfo(sender: AnyObject) {
        UIView.makeInfoNotificationWithText("Info Color")
    }
    
}

