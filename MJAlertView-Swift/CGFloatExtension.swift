//
//  CGFloatExtension.swift
//  ChildrenGuardian
//
//  Created by Jason.Chengzi on 16/06/17.
//  Copyright © 2016年 Hvit. All rights reserved.
//

extension CGFloat {
    ///转换为Float
    var toFloat     : Float     { return Float(self)            }
    ///转换为Int
    var toInt       : Int       { return Int(self)              }
    ///转换为Double
    var toDouble    : Double    { return Double(self)           }
    
    ///一半数值
    var half        : CGFloat   { return self / 2               }
    ///相反数值
    var opposite    : CGFloat   { return -self                  }
    ///绝对值
    var absolute    : CGFloat   { return abs(self)              }
    ///两倍数值
    var double      : CGFloat   { return self * 2               }
    ///三倍数值
    var triple      : CGFloat   { return self * 3               }
    ///平方数
    var square      : CGFloat   { return (self * self)          }
    ///立方数
    var cube        : CGFloat   { return (self * self * self)   }
    
    static func MIN(lbs lbs : CGFloat, rbs : CGFloat) -> CGFloat {
        if lbs > rbs {
            return rbs
        } else if lbs < rbs {
            return lbs
        } else {
            return lbs
        }
    }
}