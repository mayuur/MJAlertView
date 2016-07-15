//
//  UIColorExtension.swift
//  HealthPlus
//
//  Created by Jason.Chengzi on 16/05/13.
//  Copyright © 2016年 Hvit. All rights reserved.
//
import UIKit

//MARK: - UIColor
extension UIColor {
    
    ///CGFloat类型的RGB值
    var components : (red : CGFloat, green : CGFloat, blue : CGFloat, alpha : CGFloat) {
        var fRed    : CGFloat = 0
        var fGreen  : CGFloat = 0
        var fBlue   : CGFloat = 0
        var fAlpha  : CGFloat = 0
        
        self.getRed(&fRed, green: &fGreen, blue: &fBlue, alpha: &fAlpha)
        
        return (fRed, fGreen, fBlue, fAlpha)
    }
    ///Int类型的RGB值
    var RGBValues : (red : Int, green : Int, blue : Int, alpha : CGFloat) {
        let components = self.components
        return ((components.red * 255).toInt, (components.green * 255).toInt, (components.blue * 255).toInt, components.alpha)
    }
    
    var redComponent    : CGFloat {
        return self.components.red
    }
    var greenComponent  : CGFloat {
        return self.components.green
    }
    var blueComponent   : CGFloat {
        return self.components.blue
    }
    var alphaComponent  : CGFloat {
        return self.components.alpha
    }
    
    var coreImageColor : CoreImage.CIColor? {
        return CoreImage.CIColor(color: self)
    }
    
    var isLight : Bool {
        var white : CGFloat = 0
        self.getWhite(&white, alpha: nil)
        
        if white >= 0.5 {
            return true
        } else {
            return false
        }
    }
    
    ///便捷颜色。色相、饱和度、亮度、通透度
    class func colorWithHue(hue : CGFloat, saturation : CGFloat, brightness : CGFloat, andAlpha alpha : CGFloat) -> UIColor {
        return UIColor(
            hue: hue / 256,
            saturation: saturation / 256,
            brightness: brightness / 256,
            alpha: alpha
        )
    }
    class func colorWithHue(hue : CGFloat, saturation : CGFloat, brightness : CGFloat) -> UIColor {
        return colorWithHue(hue, saturation: saturation, brightness: brightness, andAlpha: 1)
    }
    ///便捷颜色初始化
    class func colorWithRed(red: CGFloat, green: CGFloat, blue: CGFloat, andAlpha alpha: CGFloat) -> UIColor {
        return UIColor(
            red: (red / 255.0),
            green: (green / 255.0),
            blue: (blue / 255.0),
            alpha: alpha
        )
    }
    class func colorWithRed(red: CGFloat, green: CGFloat, blue: CGFloat) -> UIColor {
        return UIColor.colorWithRed(
            red,
            green: green,
            blue: blue,
            andAlpha: 1
        )
    }
    ///16进制初始化颜色
    class func colorWithHex(hex h: Int, andAlpha alpha: CGFloat) -> UIColor {
        let red = CGFloat(((h & 0xFF0000) >> 16))
        let green = CGFloat(((h & 0xFF00) >> 8))
        let blue = CGFloat((h & 0xFF))
        
        return UIColor.colorWithRed(
            red, green:
            green,
            blue: blue,
            andAlpha: alpha
        )
    }
    class func colorWithHex(hex h: Int) -> UIColor {
        return UIColor.colorWithHex(hex: h, andAlpha: 1)
    }
    class func colorWithHex(hex : String, andAlpha alpha : CGFloat) -> UIColor {
        var cString : String = hex.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceAndNewlineCharacterSet()).uppercaseString
        
        if cString.hasPrefix("#") {
            cString = cString.substringFromIndex(cString.startIndex.advancedBy(1))
        }
        
        if cString.characters.count != 6 {
            return UIColor.grayColor()
        }
        
        var rgbValue : UInt32 = 0
        NSScanner(string: cString).scanHexInt(&rgbValue)
        
        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: alpha
        )
    }
    class func colorWithHex(hex : String) -> UIColor {
        return UIColor.colorWithHex(hex, andAlpha: 1)
    }
    class func randomColor() -> UIColor {
        return UIColor(
            hue: (CGFloat(arc4random()) % 256 / 256.0),
            saturation: (CGFloat(arc4random()) % 128 / 256.0) + 0.5,
            brightness: (CGFloat(arc4random()) % 128 / 256.0) + 0.5,
            alpha: 1
        )
    }
}
