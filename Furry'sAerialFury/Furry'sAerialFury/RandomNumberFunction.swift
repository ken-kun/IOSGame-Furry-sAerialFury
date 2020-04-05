//
//  RandomNumberFunction.swift
//  Furry'sAerialFury
//
//  Created by Kevin Ly on 2020-04-05.
//  Copyright © 2020 graphic. All rights reserved.
//

import Foundation
import CoreGraphics

public extension CGFloat{
    
    public static func random() ->CGFloat{
        
        return CGFloat(Float(arc4random()) / 0xFFFFFFFF)
    }
    
    public static func random(min min : CGFloat, max : CGFloat) -> CGFloat{
        
        return CGFloat.random() * (max - min) + min
    }
    
}
