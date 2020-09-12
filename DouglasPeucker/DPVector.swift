//
//  DPVector.swift
//  DouglasPeucker
//
//  Created by luxuan on 2020/9/11.
//  Copyright © 2020 luxuan. All rights reserved.
//

import Foundation

public class DPVector{
    public var x:Double = 0.0
    public var y:Double = 0.0
    public var include:Bool = false
    
    public func initVector(X x:Double, Y y:Double) -> DPVector{
        self.x=x
        self.y=y
        return self
    }
    
    public func dotProduct(v:DPVector) -> Double{
        return x*v.x+y*v.y
    }
    
    public func magnitude()->Double{
        return sqrt(x*x+y*y)
    }
    
    public func unitVector()->DPVector{
        if(self.magnitude()==0){
            return self.initVector(X: 0,Y: 0)
        }
        return self.initVector(X: x/self.magnitude(), Y: y/self.magnitude())
    }
    
    public func setIncluded(isIncluded:Bool){
        self.include=isIncluded
    }
}
