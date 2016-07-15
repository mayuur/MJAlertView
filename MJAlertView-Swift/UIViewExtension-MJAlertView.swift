//
//  UIViewExtension-MJAlertView.swift
//  ChildrenGuardian
//
//  Created by Jason.Chengzi on 7/13/16.
//  Copyright © 2016 Hvit. All rights reserved.
//

import UIKit
import QuartzCore

private let MJAV_APPDELEGATE            = UIApplication.sharedApplication().delegate

private let MJAV_FONT_SIZE_LABEL        = 18.toCGFloat
private let MJAV_FONT_SIZE_CANCEL       = 13.toCGFloat

private let MJAV_NOTIFIER_LABEL_FONT    = UIFont(name: "HelveticaNeue-Light", size: MJAV_FONT_SIZE_LABEL)
private let MJAV_NOTIFIER_CANCEL_FONT   = UIFont(name: "HelveticaNeue", size: MJAV_FONT_SIZE_CANCEL)

private let MJAV_Tag                    = 181200
private let MJAV_xPadding               = 18.0.toCGFloat
private let MJAV_Height_Label           = 45.0.toCGFloat
private let MJAV_Height_Cancel_Button   = 30.0.toCGFloat
private let MJAV_Height_Separator       = 1.0.toCGFloat
private let MJAV_Height_FromBottom      = 70.0.toCGFloat
private let MJAV_Width_Max              = 290.0.toCGFloat

enum MJAlertViewStyle {
    case Success
    case Error
    case Warn
    case Info
    case SubjectTheme
    case Default
    
    var backgroundColor : UIColor {
        switch self {
        case .Success:
            return UIColor.colorWithHex(hex: 0x2ecc71)
        case .Error:
            return UIColor.colorWithHex(hex: 0xc0392b)
        case .Warn:
            return UIColor.colorWithHex(hex: 0xe67e22)
        case .Info:
            return UIColor.colorWithHex(hex: 0x2980b9)
        case .SubjectTheme:
            return AppearenceDefaults.COLOR_THEME
        case .Default:
            return UIColor.blackColor().colorWithAlphaComponent(0.8)
        }
    }
    
    var textColor : UIColor {
        switch self {
        case .Success:
            return UIColor.whiteColor()
        case .Error:
            return UIColor.whiteColor()
        case .Warn:
            return UIColor.whiteColor()
        case .Info:
            return UIColor.whiteColor()
        case .SubjectTheme:
//            return UIColor.whiteColor()
            if self.backgroundColor.isLight {
                return UIColor.blackColor()
            } else {
                return UIColor.whiteColor()
            }
        case .Default:
            return UIColor.whiteColor()
        }
    }
}

extension UIView {
    class func makeSuccessNotificationWithText(text : String) {
        UIView.makeAlertViewWithText(text, type: .Success)
    }
    class func makeWarnNotificationWithText(text : String) {
        UIView.makeAlertViewWithText(text, type: .Warn)
    }
    class func makeErrorNotificationWithText(text : String) {
        UIView.makeAlertViewWithText(text, type: .Error)
    }
    class func makeInfoNotificationWithText(text : String) {
        UIView.makeAlertViewWithText(text, type: .Info)
    }
    class func makeAlertViewWithText(text : String, type : MJAlertViewStyle = .Default) {
        
        let shouldDismiss = true
        
        if let screenBounds = MJAV_APPDELEGATE?.window!!.bounds {
            let attributes : [String : AnyObject] = [NSFontAttributeName : MJAV_NOTIFIER_LABEL_FONT ?? UIFont.systemFontOfSize(MJAV_FONT_SIZE_LABEL)]
            
            let height = MJAV_Height_Label
            let width = CGFloat.max
            let notifierRect = text.toNSString.boundingRectWithSize(
                                                    CGSize(
                                                        width: width,
                                                        height: height
                                                    ),
                                                    options: NSStringDrawingOptions.UsesLineFragmentOrigin,
                                                    attributes: attributes,
                                                    context: nil
                                                )
            let notifierWidth = CGFloat.MIN(lbs: CGRectGetWidth(notifierRect) + MJAV_xPadding.double, rbs: MJAV_Width_Max)
            let xOffset = (CGRectGetWidth(screenBounds) - notifierWidth).half
            
            let notifierHeight = MJAV_Height_Label
            
//            if !shouldDismiss {
//                notifierHeight += (MJAV_Height_Cancel_Button + MJAV_Height_Separator)
//            }
            
            let yOffset = CGRectGetHeight(screenBounds) - notifierHeight - MJAV_Height_FromBottom
            
            let finalFrame = CGRect(x: xOffset, y: yOffset, width: notifierWidth, height: notifierHeight)
            
            let notifierView = isNotifierExistedAlready()
            
            if let view = notifierView {
                updateNotifierWithAnimation(notifierView, andText: text, andCompletion: { (finished) in
                    var atLastFrame = finalFrame
                    atLastFrame.origin.y = finalFrame.origin.y + 8
                    view.frame = atLastFrame
                    
                    var textLabel : UILabel?
                    for subview in view.subviews {
                        if subview is UILabel {
                            textLabel = subview as? UILabel
                        }
                        
                        if subview is UIImageView || subview is UIButton {
                            subview.removeFromSuperview()
                        }
                    }
                    
                    textLabel?.text = text
                    textLabel?.frame = CGRect(x: MJAV_xPadding, y: 0, width: notifierWidth - MJAV_xPadding.double, height: MJAV_Height_Label)
                    
                    if !shouldDismiss {
                        let separatorImageView = UIImageView(frame: CGRect(x: 0, y: CGRectGetHeight(textLabel!.frame), width: CGRectGetWidth(view.frame), height: MJAV_Height_Separator))
                        separatorImageView.backgroundColor = UIColor.colorWithHex(hex: 0xF94137)
                        view.addSubview(separatorImageView)
                        
                        let cancelButton = UIButton(type: UIButtonType.Custom)
                        cancelButton.frame = CGRect(x: 0, y: CGRectGetMaxY(separatorImageView.frame), width: CGRectGetWidth(view.frame), height: MJAV_Height_Cancel_Button)
//                        cancelButton.setNormalTitleColor(UIColor.whiteColor())
                        cancelButton.backgroundColor = UIColor.colorWithHex(hex: 0x000000)
                        cancelButton.addTarget(self, action: #selector(UIView.buttonCancelClicked(_:)), forControlEvents: UIControlEvents.TouchUpInside)
                        cancelButton.titleLabel?.font = MJAV_NOTIFIER_CANCEL_FONT
                        view.addSubview(cancelButton)
                    }
                    
                    UIView.animateWithDuration(0.4, delay: 0, options: UIViewAnimationOptions.CurveEaseOut, animations: { 
                        view.alpha = 1
                        view.frame = finalFrame
                    }, completion: nil)
                })
                
                if shouldDismiss {
                    performSelector(#selector(UIView.dismissMJNotifier), withObject: nil, afterDelay: 2.0)
                }
            } else {
                let notifierView = UIView(frame: CGRect(x: xOffset, y: CGRectGetHeight(screenBounds), width: notifierWidth, height: notifierHeight))
//                notifierView.backgroundColor = UIColor.colorWithHex(hex: 0xF94137)
                notifierView.backgroundColor = type.backgroundColor
                notifierView.tag = MJAV_Tag
                notifierView.clipsToBounds = true
                notifierView.layer.cornerRadius = 5
                
                MJAV_APPDELEGATE?.window??.addSubview(notifierView)
                MJAV_APPDELEGATE?.window??.bringSubviewToFront(notifierView)
                
                let textLabel = UILabel(frame: CGRect(x: MJAV_xPadding, y: 0, width: notifierWidth - MJAV_xPadding.double, height: MJAV_Height_Label))
                textLabel.adjustsFontSizeToFitWidth = true
                textLabel.backgroundColor = UIColor.clearColor()
                textLabel.textAlignment = .Center
//                textLabel.textColor = UIColor.colorWithHex(hex: 0xFFFFFF)
                textLabel.textColor = type.textColor
                textLabel.font = MJAV_NOTIFIER_LABEL_FONT
                textLabel.minimumScaleFactor = 0.7
                textLabel.text = text
                notifierView.addSubview(textLabel)
                
                if shouldDismiss {
                    self.performSelector(#selector(UIView.dismissMJNotifier), withObject: nil, afterDelay: 2)
//                } else {
//                    let separatorImageView = UIImageView(frame: CGRect(x: 0, y: CGRectGetHeight(textLabel.frame), width: CGRectGetWidth(notifierView.frame), height: MJAV_Height_Separator))
//                    separatorImageView.backgroundColor = UIColor.colorWithHex(hex: 0xF94137)
//                    notifierView.addSubview(separatorImageView)
//                    
//                    let cancelButton = UIButton(type: UIButtonType.Custom)
//                    cancelButton.frame = CGRect(x: 0, y: CGRectGetMaxY(separatorImageView.frame), width: CGRectGetWidth(notifierView.frame), height: MJAV_Height_Cancel_Button)
//                    cancelButton.backgroundColor = UIColor.colorWithHex(hex: 0x000000)
//                    cancelButton.addTarget(self, action: #selector(UIView.buttonCancelClicked(_:)), forControlEvents: UIControlEvents.TouchUpInside)
//                    cancelButton.titleLabel?.font = MJAV_NOTIFIER_CANCEL_FONT
//                    notifierView.addSubview(cancelButton)
                }
                
                self.startEntryAnimation(notifierView, withFinalFrame: finalFrame)
            }
        }
    }
    class func dismissMJNotifier() {
        NSObject.cancelPreviousPerformRequestsWithTarget(self, selector: #selector(UIView.dismissMJNotifier), object: nil)
        
        var notifier : UIView?
        
        for subview in MJAV_APPDELEGATE!.window!!.subviews {
            if subview.tag == MJAV_Tag && subview.isKindOfClass(UIView.self) {
                notifier = subview
            }
        }
        
        startExitAnimation(notifier)
    }
}

private extension UIView {
    class func isNotifierExistedAlready() -> UIView? {
        NSObject.cancelPreviousPerformRequestsWithTarget(self, selector: #selector(UIView.dismissMJNotifier), object: nil)
        
        var notifier : UIView?
        
        for subview in MJAV_APPDELEGATE!.window!!.subviews {
            if subview.tag == MJAV_Tag && subview.isKindOfClass(UIView.self) {
                notifier = subview
            }
        }
        
        return notifier
    }
    
    @objc class func buttonCancelClicked(sender : UIButton) {
        dismissMJNotifier()
    }
    
    class func updateNotifierWithAnimation(notifierView : UIView?, andText text : String, andCompletion completion : ((finished : Bool) -> Void)?) {
        if let view = notifierView {
            var finalFrame = view.frame
            finalFrame.origin.y = finalFrame.origin.y + 8
            
            UIView.animateWithDuration( 0.2,
                                        delay: 0,
                                        options: UIViewAnimationOptions.CurveEaseOut,
                                        animations: {
                                            view.alpha = 0
                                            view.frame = finalFrame
                                        },
                                        completion: { (finished : Bool) in
                                            completion?(finished: finished)
                                        }
                                    )
        }
    }
    
    class func startEntryAnimation(notifierView : UIView?, withFinalFrame finalFrame : CGRect) {
        
        if let view = notifierView {
            
            var mutableFinalFrame = finalFrame
            
            let finalYOffset = mutableFinalFrame.origin.y
            mutableFinalFrame.origin.y = finalFrame.origin.y - 15
            
            let transform = transformWithXAxisValue(-0.1, andAngle: 45)
            view.layer.zPosition = 400
            view.layer.transform = transform
            
            UIView.animateWithDuration(0.2, delay: 0, options: UIViewAnimationOptions.CurveEaseOut, animations: {
                
                view.frame = mutableFinalFrame
                
                let anotherTransform = transformWithXAxisValue(0.1, andAngle: 15)
                view.layer.zPosition = 400
                view.layer.transform = anotherTransform
                
            }, completion: { (finished : Bool) in
                UIView.animateWithDuration(0.4, delay: 0, options: UIViewAnimationOptions.CurveEaseIn, animations: {
                    
                    var atLastFrame = mutableFinalFrame
                    atLastFrame.origin.y = finalYOffset
                    view.frame = atLastFrame
                    
                    let transform = self.transformWithXAxisValue(0.0, andAngle: 90)
                    view.layer.zPosition = 400
                    view.layer.transform = transform
                    
                }, completion: nil)
            })
        }
        
    }
    
    class func startExitAnimation(notifierView : UIView?) {
        
        if let view = notifierView {
        
            let screenBounds = MJAV_APPDELEGATE!.window!!.bounds
            
            var notifierFrame = view.frame
            let finalYOffset = notifierFrame.origin.y - 12
            notifierFrame.origin.y = finalYOffset
            
            UIView.animateWithDuration(0.3, delay: 0, options: UIViewAnimationOptions.CurveEaseOut, animations: { 
                view.frame = notifierFrame
                let transform = transformWithXAxisValue(0.1, andAngle: 30)
                view.layer.zPosition = 400
                view.layer.transform = transform
            }, completion: { (finished : Bool) in
                UIView.animateWithDuration(0.15, delay: 0, options: UIViewAnimationOptions.CurveEaseIn, animations: { 
                    var atLastFrame = view.frame
                    atLastFrame.origin.y = CGRectGetHeight(screenBounds)
                    view.frame = atLastFrame
                    
                    let transform = transformWithXAxisValue(-1, andAngle: 90)
                    view.layer.zPosition = 400
                    view.layer.transform = transform
                }, completion: { (finished : Bool) in
                    view.removeFromSuperview()
                })
            })
        }
    }
    
    class func transformWithXAxisValue(xValue : CGFloat, andAngle angle : CGFloat) -> CATransform3D {
        var transform = CATransform3DIdentity
        
        transform.m34 = 1.0 / -1000
        
        transform = CATransform3DRotate(transform, angle * M_PI.toCGFloat / 180, xValue, 0, 0)
        
        return transform
    }
}