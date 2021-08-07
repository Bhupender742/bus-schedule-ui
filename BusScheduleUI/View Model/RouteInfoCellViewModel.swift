//
//  RouteInfoCellViewModel.swift
//  BusScheduleUI
//
//  Created by Bhupender Rawat on 07/08/21.
//

import UIKit

class RouteInfoCellViewModel: NSObject {
    
    public let routeId: String
    public let routeName: String
    public let routeSource: String
    public let routeDestination: String
    public let routeTripDuration: String
    
    
    public init(with model: RouteInfo) {
        self.routeId = model.id
        self.routeName = model.name
        self.routeSource = model.source
        self.routeDestination = model.destination
        self.routeTripDuration = model.tripDuration
    }
    
}
