//
//  StringExtension.swift
//  HealthPlus
//
//  Created by Jason.Chengzi on 16/05/17.
//  Copyright © 2016年 Hvit. All rights reserved.
//
import UIKit

extension String {
    ///获取NSString对象
    var toNSString : NSString {
        return NSString(string: self)
    }
    ///获取字符串长度
    var length : Int {
        return self.characters.count
    }
    
    ///判断是否为整数
    var isInt : Bool {
        if Int(self) != nil {
            return true
        } else {
            return false
        }
    }
    ///判断是否为浮点数
    var isFloat : Bool {
        if Float(self) != nil {
            return true
        } else {
            return false
        }
    }
    ///判断是否为长浮点数
    var isDouble : Bool {
        if Double(self) != nil {
            return true
        } else {
            return false
        }
    }
    
    ///尝试转换为整型
    var nullableInt : Int? {
        return Int(self)
    }
    ///尝试转换为浮点数
    var nullableFloat : Float? {
        return Float(self)
    }
    ///尝试转换为长浮点数
    var nullableDouble : Double? {
        return Double(self)
    }
    
    ///强制转换为整型，失败返回0
    var toInt : Int {
        return Int(self) ?? 0
    }
    ///强制转换为浮点数，失败返回0
    var toFloat : Float {
        return Float(self) ?? Float(0)
    }
    ///强制转换为长浮点数，失败返回0
    var toDouble : Double {
        return Double(self) ?? Double(0)
    }
    
    ///获取第一个字母
    var firstLetter : String {
        var ret = ""
        if !self.canBeConvertedToEncoding(NSASCIIStringEncoding) {
            ret = self.letters.firstLetter
        } else {
            ret = "\("\(self.characters.first)" ?? "")"
        }
        return ret
    }
    
    var letters : String {
        let str = NSMutableString(string: self)
        if CFStringTransform(str, nil, kCFStringTransformMandarinLatin, false) {
            if CFStringTransform(str, nil, kCFStringTransformStripDiacritics, false) {
                return str as String
            }
        }
        return self
    }

    func getFirstLetter() -> String {
        return self.firstLetter
    }
    
    ///通过字体获取字符串的尺寸
    func sizeWithFont(font : UIFont) -> CGSize {
        //如果没有内容
        guard self.isEmpty == false else {
            return CGSizeZero
        }
        return self.toNSString.sizeWithAttributes([NSFontAttributeName : font])
    }
    ///通过字体和固定宽度计算字符串的高度
    func heightWithWidth(width : CGFloat, font : UIFont) -> CGFloat {
        //如果没有内容
        guard self.isEmpty == false else {
            return CGFloat(0)
        }
        return self.sizeWithFont(font).width / width
    }
    ///截取指定长度的字符串
    func substringWithStartPosition(start : Int, andEndPosition end : Int) -> String {
        return self.substringWithRange(self.startIndex.advancedBy(start)..<self.startIndex.advancedBy(end))
    }
    ///判断是否满足正则表达式
    func isMatchingPattern(pattern : MCPattern) -> Bool {
        let regex : NSRegularExpression? = try? NSRegularExpression(pattern: pattern.pattern, options: NSRegularExpressionOptions.CaseInsensitive)
        if let matches = regex?.matchesInString(self, options: [], range: NSMakeRange(0, self.toNSString.length)) {
            return matches.count > 0
        } else {
            return false
        }
    }
    
    
}

struct MCPattern {
    var pattern : String
}