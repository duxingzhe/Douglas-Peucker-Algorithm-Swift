//
//  DouglasPeucker.swift
//  DouglasPeucker
//
//  Created by luxuan on 2020/9/11.
//  Copyright © 2020 luxuan. All rights reserved.
//

import Foundation
import CoreLocation

class DouglasPeucker{
    public var startingVectors:NSMutableArray? = []
    public var endVectors:NSMutableArray? = []
    
    public var tolerance:Double=0.0
    public var toleranceSquared:Double=0.0
    
    public func initArrayOfCLLocationCoordinate2D(Array arr:UnsafeMutablePointer<CLLocationCoordinate2D>, Size size:Int)->DouglasPeucker{
        endVectors=NSMutableArray.init(capacity: size)
        startingVectors=NSMutableArray.init(capacity: size)
        
        for i in 0..<size {
            var vp:DPVector=DPVector().initVector(X: coordinates[i].latitude, Y: coordinates[i].longitude)
            startingVectors!.add(vp)
        }
        
        (startingVectors!.object(at: 0) as! DPVector).setIncluded(isIncluded: true)
        (startingVectors!.lastObject as! DPVector).setIncluded(isIncluded: true)
        return self
    }
    
    public func simplerLineWithTolerance(T t:Double)->UnsafeMutablePointer<CLLocationCoordinate2D>{
        self.tolerance=t
        self.toleranceSquared=t*t
        
        self.douglasPeucker(Index1: 0, Index2: startingVectors!.count-1)
        
        for (index, item) in startingVectors!.enumerated(){
            if((item as! DPVector).include){
                endVectors!.add(item)
            }
        }
        
        var coordinates=UnsafeMutablePointer<CLLocationCoordinate2D>.allocate(capacity: endVectors!.count)

        print(endVectors!.count)
        for i in 0..<endVectors!.count{
            print("index", i)
            coordinates[i].longitude=(endVectors![i] as! DPVector).y
            coordinates[i].latitude=(endVectors![i] as! DPVector).x
        }
        
        return coordinates
    }
    
    public func douglasPeucker(Index1 startVertexIndex:Int, Index2 endVertexIndex:Int){
        
        if(endVertexIndex<=startVertexIndex+1){
            return
        }
        
        var line:DPLine=DPLine().initLine(Point1: startingVectors!.object(at: startVertexIndex) as! DPVector, Point2: startingVectors!.object(at: endVertexIndex)as! DPVector)
        
        var maxDistToLineSquared:Double=0;
        var maxDistIndex:Int=0;
        
        for index in 0...startVertexIndex {
            var distToLineSquared=line.distanceToPointSquared(Point: startingVectors!.object(at: index) as! DPVector)
            
            if(distToLineSquared>maxDistToLineSquared){
                maxDistToLineSquared=distToLineSquared
                maxDistIndex=index
            }
        }
        
        if(maxDistToLineSquared>toleranceSquared){
            (startingVectors!.object(at: maxDistIndex) as! DPVector).setIncluded(isIncluded: true)
            self.douglasPeucker(Index1: startVertexIndex, Index2: maxDistIndex)
            self.douglasPeucker(Index1: maxDistIndex, Index2: endVertexIndex)
        }
        
    }
}
