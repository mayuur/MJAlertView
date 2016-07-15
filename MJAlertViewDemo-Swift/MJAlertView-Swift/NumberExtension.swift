//
//  NumberExtension.swift
//  HealthPlus
//
//  Created by Jason.Chengzi on 16/05/20.
//  Copyright © 2016年 Hvit. All rights reserved.
//
import UIKit

extension Int {
    ///转换为CGFloat
    var toCGFloat   : CGFloat   { return CGFloat(self)          }
    ///转换为Float
    var toFloat     : Float     { return Float(self)            }
    ///转换为Double
    var toDouble    : Double    { return Double(self)           }
    
    ///一半数值
    var half        : Int       { return self / 2               }
    ///相反数值
    var opposite    : Int       { return -self                  }
    ///绝对值
    var absolute    : Int       { return abs(self)              }
    ///两倍数值
    var double      : Int       { return self * 2               }
    ///三倍数值
    var triple      : Int       { return self * 3               }
    ///平方数
    var square      : Int       { return (self * self)          }
    ///立方数
    var cube        : Int       { return (self * self * self)   }
    
    ///是否在开区间内
    func isGreaterThan(min : Int, lessThan max : Int) -> Bool {
        if self > min && self < max {
            return true
        }
        return false
    }
    ///是否在闭区间内
    func isEqualAndGreaterThan(min : Int, equalAndLessThan max : Int) -> Bool {
        if self >= min && self <= max {
            return true
        }
        return false
    }
}

extension Float {
    ///转换为CGFloat
    var toCGFloat   : CGFloat   { return CGFloat(self)          }
    ///转换为Int
    var toInt       : Int       { return Int(self)              }
    ///转换为Double
    var toDouble    : Double    { return Double(self)           }
    
    ///一半数值
    var half        : Float     { return self / 2               }
    ///相反数值
    var opposite    : Float     { return -self                  }
    ///绝对值
    var absolute    : Float     { return abs(self)              }
    ///两倍数值
    var double      : Float     { return self * 2               }
    ///三倍数值
    var triple      : Float     { return self * 3               }
    ///平方数
    var square      : Float     { return (self * self)          }
    ///立方数
    var cube        : Float     { return (self * self * self)   }
    
    ///是否在开区间内
    func isGreaterThan(min : Float, lessThan max : Float) -> Bool {
        if self > min && self < max {
            return true
        }
        return false
    }
    ///是否在闭区间内
    func isEqualAndGreaterThan(min : Float, equalAndLessThan max : Float) -> Bool {
        if self >= min && self <= max {
            return true
        }
        return false
    }
}

extension Double {
    ///转换为CGFloat
    var toCGFloat   : CGFloat   { return CGFloat(self)          }
    ///转换为Float
    var toFloat     : Float     { return Float(self)            }
    ///转换为Int
    var toInt       : Int       { return Int(self)              }
    
    ///一半数值
    var half        : Double    { return self / 2               }
    ///相反数值
    var opposite    : Double    { return -self                  }
    ///绝对值
    var absolute    : Double    { return abs(self)              }
    ///两倍数值
    var double      : Double    { return self * 2               }
    ///三倍数值
    var triple      : Double    { return self * 3               }
    ///平方数
    var square      : Double    { return (self * self)          }
    ///立方数
    var cube        : Double    { return (self * self * self)   }
    
    ///是否在开区间内
    func isGreaterThan(min : Double, lessThan max : Double) -> Bool {
        if self > min && self < max {
            return true
        }
        return false
    }
    ///是否在闭区间内
    func isEqualAndGreaterThan(min : Double, equalAndLessThan max : Double) -> Bool {
        if self >= min && self <= max {
            return true
        }
        return false
    }
}