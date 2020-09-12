//
//  DPLine.swift
//  DouglasPeucker
//
//  Created by luxuan on 2020/9/11.
//  Copyright © 2020 luxuan. All rights reserved.
//

import Foundation

class DPLine{
    
    public var p1:DPVector?, p2:DPVector?
    
    public func initLine(Point1 point1:DPVector, Point2 point2:DPVector) -> DPLine {
        self.p1=point1
        self.p2=point2
        return self
    }
    
    public func lengthSquared()->Double{
        var dx = p1!.x-p2!.x;
        var dy = p1!.y-p2!.y;
        
        return dx*dx+dy*dy;
    }
    
    public func distanceToPointSquared(Point point:DPVector)-> Double {
        var v:DPVector=DPVector().initVector(X: point.x-p1!.x, Y: point.y-p1!.y)
        var l:DPVector=DPVector().initVector(X: p2!.x-p1!.x, Y: p2!.y-p1!.y)
        
        var dot:Double=v.dotProduct(v: l.unitVector())
        
        if(dot<=0){
            var dl:DPLine=self.initLine(Point1: p1!, Point2: point)
            return dl.lengthSquared()
        }
        
        if((dot*dot)>=self.lengthSquared()){
            var dl:DPLine=self.initLine(Point1: point, Point2: p2!)
            return dl.lengthSquared()
        }
        else
        {
            var dl:DPLine=self.initLine(Point1: p1!, Point2: point)
            var h:Double=dl.lengthSquared()
            return h-(dot*dot)
        }
    }
}
