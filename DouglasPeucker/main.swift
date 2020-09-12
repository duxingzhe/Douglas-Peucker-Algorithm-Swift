//
//  main.swift
//  DouglasPeucker
//
//  Created by luxuan on 2020/9/11.
//  Copyright © 2020 luxuan. All rights reserved.
//

import Foundation
import CoreLocation

// 数据来自高德地图
let string="118.780937,31.992218;118.780937,31.992188;118.780911,31.991372;118.780907,31.991176;118.780898,31.990725;118.780916,31.989961;118.780877,31.988733;118.780877,31.988668;118.780868,31.988377;118.780864,31.988016;118.78089,31.9876;118.781059,31.986493;118.781228,31.985642"
let point = string.components(separatedBy: ";").joined(separator:",").components(separatedBy: ",")

let count = point.count/2
var coordinates = UnsafeMutablePointer<CLLocationCoordinate2D>.allocate(capacity: count)
for i in 0..<count {
    coordinates[i].longitude=(point[2*i] as NSString).doubleValue
    coordinates[i].latitude=(point[2*i+1] as NSString).doubleValue
}

let douglasAlogrithm = DouglasPeucker()
    
douglasAlogrithm.initArrayOfCLLocationCoordinate2D(Array: coordinates, Size: count)

coordinates = douglasAlogrithm.simplerLineWithTolerance(T: 5)

for i in 0..<2{
    print(String(coordinates[i].latitude)+"  "+String(coordinates[i].longitude))
}
