//
//  RouteModel.swift
//  BusScheduleUI
//
//  Created by Bhupender Rawat on 06/08/21.
//

import Foundation

// MARK: - APIResponse
struct APIResponse: Codable {
    let routeInfo: [RouteInfo]
    let routeTimings: [String: [RouteTiming]]
}

// MARK: - RouteInfo
struct RouteInfo: Codable {
    let id, name, source, tripDuration: String
    let destination, icon: String
}

// MARK: - RouteTiming
struct RouteTiming: Codable {
    let totalSeats, avaiable: Int
    let tripStartTime: String
}
